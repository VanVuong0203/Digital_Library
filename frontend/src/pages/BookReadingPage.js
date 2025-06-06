import React, { useEffect, useState, useRef } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { getBookById, getRatingsByBookId, submitRating } from '../services/api';
import '../assets/styles/BookReadingPage.css';
import ePub from 'epubjs';
import { FaStar } from 'react-icons/fa';

const BookReadingPage = () => {
    const { id } = useParams();
    const [book, setBook] = useState(null);
    const [bookUrl, setBookUrl] = useState('');
    const frontViewerRef = useRef(null);
    const renditionRef = useRef(null);
    const bookInstanceRef = useRef(null);
    const [currentPage, setCurrentPage] = useState(1);
    const [totalPages, setTotalPages] = useState(0);
    const navigate = useNavigate();
    const [isAnimating, setIsAnimating] = useState(false);

    // Đánh giá
    const [rating, setRating] = useState(0);
    const [hoverRating, setHoverRating] = useState(0);
    const [reviewText, setReviewText] = useState('');
    const [reviews, setReviews] = useState([]);
    const [showModal, setShowModal] = useState(false);
    const [hasRated, setHasRated] = useState(false);

    const handleExit = () => {
        const user = JSON.parse(localStorage.getItem("user"));
        const alreadyRated = reviews.some(r => r.userId === user?.id);
        if (alreadyRated || hasRated) {
            navigate(-1, { replace: true });
        } else {
            setShowModal(true);
        }
    };

    useEffect(() => {
        getBookById(id)
            .then(res => {
                setBook(res.data.book);
                if (res.data.book?.content_path) setBookUrl(res.data.book.content_path);
            })
            .catch(err => console.error('Lỗi khi lấy sách:', err));

        getRatingsByBookId(id)
            .then(res => setReviews(res.data))
            .catch(err => console.error('Lỗi khi lấy đánh giá:', err));
    }, [id]);

    useEffect(() => {
        if (bookUrl && frontViewerRef.current) {
            const book = ePub(bookUrl);
            bookInstanceRef.current = book;

            const frontRendition = book.renderTo(frontViewerRef.current, {
                width: "100%",
                height: "100%",
                allowScriptedContent: true,
            });

            renditionRef.current = frontRendition;

            frontRendition.on('rendered', () => {
                book.loaded.spine.then(spine => {
                    setTotalPages(spine.items.length);
                });
                if (frontRendition.location?.start) {
                    updateCurrentPage(frontRendition.location.start.cfi);
                }
            });

            frontRendition.on('relocated', location => {
                if (location.start) updateCurrentPage(location.start.cfi);
                setIsAnimating(false);
            });

            frontRendition.display();

            return () => {
                frontRendition.destroy();
            };
        }
    }, [bookUrl]);

    const updateCurrentPage = (cfi) => {
        if (renditionRef.current?.location?.start) {
            const pageNumber = renditionRef.current.location.start.index + 1;
            setCurrentPage(pageNumber);
        }
    };

    const goToPage = async (direction) => {
        if (isAnimating) return;
        setIsAnimating(true);
        if (direction === 'next') {
            frontViewerRef.current.classList.add('slide-out-left');
            await renditionRef.current?.next();
            frontViewerRef.current.classList.remove('slide-out-left');
            frontViewerRef.current.classList.add('slide-in-right');
            setTimeout(() => {
                frontViewerRef.current.classList.remove('slide-in-right');
                setIsAnimating(false);
            }, 300);
        } else {
            frontViewerRef.current.classList.add('slide-out-right');
            await renditionRef.current?.prev();
            frontViewerRef.current.classList.remove('slide-out-right');
            frontViewerRef.current.classList.add('slide-in-left');
            setTimeout(() => {
                frontViewerRef.current.classList.remove('slide-in-left');
                setIsAnimating(false);
            }, 300);
        }
    };

    const handleSubmitRating = () => {
        if (!rating || !reviewText.trim()) {
            alert("Vui lòng chọn số sao và viết nhận xét.");
            return;
        }
        const user = JSON.parse(localStorage.getItem("user"));
        const newReview = {
            userId: user.id,
            bookId: id,
            rating,
            comment: reviewText,
            date: new Date().toISOString(),
        };
        submitRating(id, newReview)
            .then(() => {
                setReviews(prev => [...prev, newReview]);
                setRating(0);
                setReviewText('');
                setHasRated(true);
                setShowModal(false);
                navigate(-1, { replace: true });
            })
            .catch(err => {
                console.error('Lỗi gửi đánh giá:', err);
                alert("Không thể gửi đánh giá.");
            });
    };

    return (
        <div className="book-reading-wrapper">
            <button className="exit-button" onClick={handleExit}>❌ Thoát</button>

            <button
                className="nav-button back-button"
                onClick={() => goToPage('prev')}
                disabled={currentPage <= 1 || isAnimating}
            >⬅ Back</button>

            <div className="book-reading-container">
                {book ? (
                    <div className="book-content">
                        <div ref={frontViewerRef} className="epub-viewer" />
                    </div>
                ) : (
                    <p>Đang tải sách...</p>
                )}
            </div>

            <button
                className="nav-button next-button"
                onClick={() => goToPage('next')}
                disabled={currentPage >= totalPages || isAnimating}
            >Next ➡</button>

            {showModal && (
                <div className="modal-overlay">
                    <div className="modal-content">
                        <h3>Đánh giá sách nếu bạn đã đọc!!!</h3>
                        <div className="stars">
                            {[...Array(5)].map((_, index) => {
                                const starValue = index + 1;
                                return (
                                    <label key={index}>
                                        <input
                                            type="radio"
                                            name="rating"
                                            value={starValue}
                                            onClick={() => setRating(starValue)}
                                            style={{ display: "none" }}
                                        />
                                        <FaStar
                                            size={24}
                                            color={starValue <= (hoverRating || rating) ? "#ffc107" : "#e4e5e9"}
                                            onMouseEnter={() => setHoverRating(starValue)}
                                            onMouseLeave={() => setHoverRating(0)}
                                            style={{ cursor: "pointer" }}
                                        />
                                    </label>
                                );
                            })}
                        </div>
                        <textarea
                            value={reviewText}
                            onChange={(e) => setReviewText(e.target.value)}
                            placeholder="Viết nhận xét của bạn..."
                            rows="4"
                            className="review-input"
                        />
                        <div className="modal-buttons">
                            <button onClick={handleSubmitRating} className="submit-review-button">Gửi đánh giá</button>
                            <button onClick={() => navigate(-1, { replace: true })} className="cancel-button">Huỷ</button>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
};

export default BookReadingPage;
