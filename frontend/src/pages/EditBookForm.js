import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { getBookById, updateBook } from '../services/api';
import "../assets/styles/BookForm.css";

const genres = [
    'Học thuật & Giáo trình',
    'Kỹ năng & Phát triển bản thân',
    'Kinh doanh & Tài chính',
    'Văn học',
    'Khoa học - Công nghệ',
    'Tâm lý - Triết học',
    'Lịch sử - Chính trị',
    'Khoa học viễn tưởng & fantasy',
    'Y học - Sức khỏe',
    'Truyện tranh - Thiếu nhi'
];

const EditBookForm = () => {
    const { id } = useParams();
    const navigate = useNavigate();
    const [book, setBook] = useState({
        title: '',
        author: '',
        genre: '',
        published_year: '',
        description: '',
        imgs: null
    });
    const [error, setError] = useState('');
    const [previewImage, setPreviewImage] = useState('');

    useEffect(() => {
        getBookById(id)
            .then(response => {
                const data = response.data.book;
                setBook(data);
                setPreviewImage(data.imgs);
            })
            .catch(error => {
                console.error('Lỗi khi lấy thông tin sách:', error);
            });
    }, [id]);

    const handleChange = (e) => {
        const { name, value } = e.target;
        setBook({ ...book, [name]: value });
    };

    const handleFileChange = (e) => {
        const file = e.target.files[0];
        if (file) {
            const allowedTypes = ["application/epub+zip", "application/epub", "application/octet-stream"];
            if (allowedTypes.includes(file.type)) {
                setBook({ ...book, content: file });
            } else {
                setError("Chỉ chấp nhận file EPUB!");
            }
        }
    };

    const handleImageChange = (e) => {
        const file = e.target.files[0];
        if (file) {
            setBook({ ...book, imgs: file });

            const reader = new FileReader();
            reader.onloadend = () => {
                setPreviewImage(reader.result);
            };
            reader.readAsDataURL(file);
        }
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setError('');

        try {
            await updateBook(id, book);
            alert('Sách đã được cập nhật!');
            navigate(`/books/${id}`, { replace: true });
        } catch (error) {
            setError('Lỗi khi cập nhật sách.');
            console.error('Lỗi khi cập nhật sách:', error);
        }
    };

    return (
        <div className="book-form-container">
            <h2>Sửa Thông Tin Sách</h2>
            {error && <p className="error-message">{error}</p>}
            <form className="book-form" onSubmit={handleSubmit}>
                <div className="form-column image-column">
                    <div className="preview-container">
                        {previewImage && (
                            <img src={previewImage} alt="Ảnh bìa sách" />
                        )}
                    </div>
                </div>

                <div className="form-column">
                    <label>Tên sách</label>
                    <input
                        type="text"
                        name="title"
                        value={book.title}
                        onChange={handleChange}
                        required
                    />

                    <label>Tác giả</label>
                    <input
                        type="text"
                        name="author"
                        value={book.author}
                        onChange={handleChange}
                        required
                    />
                    <label>Thể loại</label>
                    <select
                        name="genre"
                        value={book.genre}
                        onChange={handleChange}
                        required
                    >
                        <option value="">-- Chọn thể loại --</option>
                        {genres.map((genre, index) => (
                            <option key={index} value={genre}>
                                {genre}
                            </option>
                        ))}
                    </select>

                    <label>Năm xuất bản</label>
                    <input
                        type="number"
                        name="published_year"
                        value={book.published_year}
                        onChange={handleChange}
                        required
                    />
                </div>
                <div className="form-column" >
                    <label>Chọn file Epub</label>
                    <input
                        type="file"
                        accept=".epub"
                        onChange={handleFileChange}
                    />
                    <label>Chọn ảnh bìa</label>
                    <input
                        type="file"
                        accept="image/*"
                        onChange={handleImageChange}
                    />
                    <label>Mô tả</label>
                    <textarea
                        name="description"
                        value={book.description}
                        onChange={handleChange}
                        required
                    />
                </div>

                <div className="button-container">
                    <button type="submit">Cập nhật sách</button>
                </div>
            </form>
        </div>
    );
};

export default EditBookForm;
