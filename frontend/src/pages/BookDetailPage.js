import React, { useEffect, useState } from "react";
import { useParams, useNavigate, useLocation } from "react-router-dom";
import { getBookById, getReadBookId, increaseReadCount, getAudioBookById } from "../services/api";
import "../assets/styles/BookDetailPage.css";
import Dialog from '@mui/material/Dialog';
import DialogTitle from '@mui/material/DialogTitle';
import DialogActions from '@mui/material/DialogActions';
import Button from '@mui/material/Button';
import BookReviewList from "../components/BookReviewList";

const BookDetailPage = () => {
    const { id } = useParams();
    const location = useLocation();
    const isAudio = new URLSearchParams(location.search).get("type") === "audio";

    const [book, setBook] = useState(null);
    const [openModal, setOpenModal] = useState(false);
    const [readBook, setReadBook] = useState(0);
    const [playing, setPlaying] = useState(false);

    const navigate = useNavigate();

    useEffect(() => {
        const fetchBook = async () => {
            try {
                const response = isAudio
                    ? await getAudioBookById(id)
                    : await getBookById(id);

                setBook(isAudio ? response.data : response.data.book);
            } catch (error) {
                console.error("Lỗi khi lấy thông tin sách:", error);
            }
        };

        fetchBook();

        getReadBookId(id)
            .then(response => {
                setReadBook(response.data.read_count);
            })
            .catch(error => console.error("Lỗi khi lấy lượt đọc sách:", error));
    }, [id, isAudio]);

    const handleReadOrPlay = () => {
        const token = localStorage.getItem("token");

        if (!token) {
            setOpenModal(true);
            return;
        }

        if (isAudio) {
            setPlaying(true);
        } else {
            increaseReadCount(id)
                .then(response => {
                    setReadBook(response.read_count);
                    navigate(`/books/read/${id}`, { replace: true });
                })
                .catch(error => console.error("Có lỗi khi tăng lượt đọc sách:", error));
        }
    };

    const handleCloseModal = () => {
        setOpenModal(false);
    };

    const handleLoginRedirect = () => {
        navigate("/login", { replace: true });
    };

    return book ? (
        <div className="book-detail-page">
            <div className="book-detail-container">
                <div className="book-main-info">
                    <div className="book-image">
                        <img src={book.imgs || book.cover_image} alt={book.title} className="book-image" />
                    </div>
                    <div className="book-info-1">
                        <h2 className="book-title">{book.title}</h2>
                        <p><strong>Tác giả:</strong> {book.author}</p>
                        <p><strong>Thể loại:</strong> {book.genre}</p>
                        <p><strong>Mô tả:</strong> {book.description}</p>
                        <p><strong>Năm xuất bản:</strong> {book.published_year}</p>
                        <p><strong>Lượt đọc:</strong> {readBook}</p>
                        <p><strong>Đánh giá trung bình:</strong> {book.total_rating || "Chưa có đánh giá"} / 5</p>
                        <button className="btn-read-book" onClick={handleReadOrPlay}>
                            {isAudio ? "Nghe sách" : "Đọc sách"}
                        </button>
                    </div>
                </div>

                {isAudio && playing && (
                    <div className="audio-player-wrapper">
                        <h3>📖 Đang phát: {book.title}</h3>
                        <audio controls autoPlay src={book.audio_url} className="audio-player" />
                    </div>
                )}

                <div className="book-review-section">
                    <BookReviewList bookId={id} />
                </div>
            </div>

            <Dialog open={openModal} onClose={handleCloseModal}>
                <DialogTitle>Bạn cần đăng nhập trước khi {isAudio ? "nghe sách" : "đọc sách"}</DialogTitle>
                <DialogActions>
                    <Button onClick={handleCloseModal} color="secondary">Đóng</Button>
                    <Button onClick={handleLoginRedirect} variant="contained" color="primary">Đăng nhập</Button>
                </DialogActions>
            </Dialog>
        </div>
    ) : (
        <p>Đang tải...</p>
    );
};

export default BookDetailPage;
