import React, { useEffect, useState } from 'react';
import { getRatingsByBookId } from '../services/api';
import { FaStar } from 'react-icons/fa';
import dayjs from 'dayjs';
import relativeTime from 'dayjs/plugin/relativeTime';
import 'dayjs/locale/vi';

dayjs.extend(relativeTime);
dayjs.locale('vi');

const BookReviewList = ({ bookId }) => {
    const [reviews, setReviews] = useState([]);

    useEffect(() => {
        getRatingsByBookId(bookId)
            .then(res => setReviews(res.data))
            .catch(err => console.error('Lỗi khi lấy đánh giá:', err));
    }, [bookId]);

    return (
        <div className="rating-section">
            <h3>Đánh giá từ người đọc:</h3>
            {reviews.length === 0 ? (
                <p>Chưa có đánh giá nào.</p>
            ) : (
                reviews.map((r, i) => (
                    <div key={i} className="review-item">
                        <div className="review-stars">
                            {[...Array(5)].map((_, j) => (
                                <FaStar key={j} color={j < r.rating ? "#ffc107" : "#e4e5e9"} size={18} />
                            ))}
                        </div>
                        <p>
                            <strong>{r?.username || 'Người dùng ẩn danh'}</strong> - {dayjs(r.date).add(7, 'hour').format('DD/MM/YYYY - HH:mm')} ({dayjs(r.date).add(7, 'hour').fromNow()})
                        </p>
                        <p>{r.comment}</p>
                    </div>
                ))
            )}
        </div>
    );
};

export default BookReviewList;
