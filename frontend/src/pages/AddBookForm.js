import React, { useState } from 'react';
// import { useNavigate } from 'react-router-dom';
import { addBook } from '../services/api';
import { toast } from "react-toastify";
import { FaBook, FaUser, FaMoneyBill, FaImage, FaAlignLeft, FaLayerGroup, FaFileAlt } from 'react-icons/fa';
import "../assets/styles/BookForm.css";

// Danh sách thể loại
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

const AddBookForm = () => {
    const [book, setBook] = useState({
        title: '',
        author: '',
        genre: genres[0],
        published_year: '',
        description: '',
        imgs: '',
        content: ''
    });
    const [error, setError] = useState('');
    const [coverPreview, setCoverPreview] = useState(null); // Preview ảnh bìa
    // const navigate = useNavigate();

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

            // Hiển thị preview ảnh
            const reader = new FileReader();
            reader.onloadend = () => {
                setCoverPreview(reader.result);
            };
            reader.readAsDataURL(file);
        } else {
            setCoverPreview(null);
        }
    };

    const isImageValid = (file) => {
        return new Promise((resolve) => {
            const reader = new FileReader();

            reader.onload = () => {
                const img = new Image();
                img.onload = () => {
                    if (img.width > 0 && img.height > 0) {
                        resolve(true);
                    } else {
                        resolve(false);
                    }
                };
                img.onerror = () => resolve(false);
                img.src = reader.result;
            };

            reader.onerror = () => {
                resolve(false);
            };

            reader.readAsDataURL(file);
        });
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setError('');

        // Kiểm tra file EPUB
        if (!book.content) {
            setError("Vui lòng chọn file EPUB hợp lệ!");
            return;
        }

        const allowedEpubTypes = [
            "application/epub+zip",
            "application/epub",
            "application/octet-stream"
        ];
        if (!allowedEpubTypes.includes(book.content.type)) {
            setError("Chỉ chấp nhận file EPUB!");
            return;
        }

        // Kiểm tra file ảnh nếu có
        if (book.imgs) {
            const allowedImageTypes = ["image/jpeg", "image/png", "image/gif"];
            if (!allowedImageTypes.includes(book.imgs.type)) {
                setError("Ảnh không hợp lệ! Chỉ chấp nhận PNG, JPG hoặc GIF.");
                return;
            }

            if (!book.imgs.size || book.imgs.size === 0) {
                setError("Ảnh bị hỏng hoặc không thể đọc được!");
                return;
            }
            const valid = await isImageValid(book.imgs);
            if (!valid) {
                setError("Ảnh bị hỏng hoặc không thể hiển thị!");
                return;
            }
        }

        // Nếu không có lỗi, tạo FormData và gửi lên server
        const formData = new FormData();
        formData.append('title', book.title);
        formData.append('author', book.author);
        formData.append('genre', book.genre);
        formData.append('published_year', book.published_year);
        formData.append('description', book.description);
        formData.append('epub', book.content);
        if (book.imgs) {
            formData.append('imgs', book.imgs);
        }

        try {
            await addBook(formData);
            toast.success('Thêm sách thành công!');
        } catch (error) {
            setError('Lỗi khi thêm sách, vui lòng thử lại.');
            console.error('Lỗi khi thêm sách:', error);
            toast.error('Gửi sách thất bại.');
        }
    };

    return (
        <div className="book-form-container">
            <h2>Thêm Sách Mới</h2>
            {error && <p className="error-message">{error}</p>}
            <form className="book-form" onSubmit={handleSubmit}>
                <div className="form-column image-column">
                    {coverPreview ? (
                        <div className="preview-container">
                            <img src={coverPreview} alt="Preview" />
                        </div>
                    ) : (
                        <div className="placeholder-preview">Ảnh bìa sẽ hiển thị tại đây</div>
                    )}
                </div>

                <div className="form-column">
                    <div>
                        <label><FaBook /> Tên sách</label>
                        <input
                            type="text"
                            name="title"
                            value={book.title}
                            onChange={handleChange}
                            required
                        />
                    </div>
                    <div>
                        <label><FaUser /> Tác giả</label>
                        <input
                            type="text"
                            name="author"
                            value={book.author}
                            onChange={handleChange}
                            required
                        />
                    </div>
                    <div>
                        <label><FaLayerGroup /> Thể loại</label>
                        <select
                            name="genre"
                            value={book.genre}
                            onChange={handleChange}
                            required
                        >
                            {genres.map((genre, index) => (
                                <option key={index} value={genre}>{genre}</option>
                            ))}
                        </select>
                    </div>
                    <div>
                        <label><FaMoneyBill /> Năm xuất bản</label>
                        <input
                            type="number"
                            name="published_year"
                            value={book.published_year}
                            onChange={handleChange}
                            min="1900"
                            max={new Date().getFullYear()}
                            required
                        />
                    </div>
                </div>

                <div className="form-column">
                    <div>
                        <label><FaFileAlt /> Chọn file EPUB</label>
                        <input
                            type="file"
                            accept=".epub"
                            onChange={handleFileChange}
                            required
                        />
                    </div>
                    <div>
                        <label><FaImage /> Chọn ảnh bìa</label>
                        <input
                            type="file"
                            accept="image/*"
                            onChange={handleImageChange}
                        />
                    </div>
                    <div>
                        <label><FaAlignLeft /> Mô tả</label>
                        <textarea
                            name="description"
                            value={book.description}
                            onChange={handleChange}
                            required
                        />
                    </div>
                </div>
                <div className="button-container">
                    <button type="submit">Thêm sách</button>
                </div>
            </form>

        </div>
    );
};

export default AddBookForm;