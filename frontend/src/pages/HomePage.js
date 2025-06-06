import React, { useEffect, useState } from "react";
import "../assets/styles/Home.css";
import "../assets/styles/BookItem.css";
import { Link } from "react-router-dom";
import { getBooks } from "../services/api";
import defaultImage from "../assets/images/6659895.png";
import { FiBookOpen, FiUsers, FiBook, FiGlobe } from "react-icons/fi";

const HomePage = () => {
    const [newBooks, setNewBooks] = useState([]);
    const [bookData, setBookData] = useState([]);

    const categories = [
        { id: 1, name: "Kỹ năng & Phát triển bản thân", icon: <FiBookOpen /> },
        { id: 2, name: "Tâm lý - Triết học", icon: <FiGlobe /> },
        { id: 3, name: "Truyện tranh - Thiếu nhi", icon: <FiUsers /> },
        { id: 4, name: "Kinh doanh & Tài chính", icon: <FiBook /> },
    ];

    useEffect(() => {
        getBooks()
            .then((response) => {
                const sortedBooks = response.data.sort((a, b) => b.id - a.id);
                setNewBooks(sortedBooks.slice(0, 6));
                setBookData(sortedBooks);
            })
            .catch((err) => console.error("Lỗi khi lấy sách mới:", err));
    }, []);

    const changeImage = (event) => {
        event.src = defaultImage;
    };

    return (
        <div className="home">
            <div className="home_content">
                {/* Danh mục */}
                <div className="category-section">
                    <div className="category-list">
                        <h2>Danh mục sách</h2>
                        {categories.map((cat) => (
                            <Link to={`/books/comics`} key={cat.id} state={cat.name} className="category-item">
                                <span className="category-icon">{cat.icon}</span>
                                {cat.name}
                            </Link>
                        ))}
                    </div>
                </div>
                {/* Sách mới */}
                <div className="new-books-section">
                    <h2>Sách mới thêm</h2>
                    <div className="book-list-new">
                        {newBooks.map((book) => (
                            <div className="book-item" key={book.id}>
                                <Link to={`/books/${book.id}`} className="book-item-link">
                                    <img src={book.imgs} alt={book.title} className="book-item-image" onError={(e) => changeImage(e.target)} />
                                    <h3>{book.title}</h3>
                                    <p>Tác giả: {book.author}</p>
                                </Link>
                            </div>
                        ))}
                    </div>
                </div>
                {/* lọc thể loại sách */}
                {categories.map((category, index) => {
                    return (<div className="new-books-section">
                        <div className="section-header">
                            <h2>{category.name}</h2>
                            <Link to={`/books/comics`} state={category.name} className="view-all-btn">Xem tất cả</Link>
                        </div>
                        <div className="book-list-new">
                            {bookData ? bookData
                                .filter(book => book.genre === category.name)
                                .slice(0, 6)
                                .map(bookSort => (
                                    <div className="book-item" key={bookSort.id}>
                                        <Link to={`/books/${bookSort.id}`} className="book-item-link">
                                            <img src={bookSort.imgs} alt={bookSort.title} className="book-item-image" onError={(e) => changeImage(e.target)} />
                                            <h3>{bookSort.title}</h3>
                                            <p>Tác giả: {bookSort.author}</p>
                                        </Link>
                                    </div>
                                )) : <h2>Không có dữ liệu sách</h2>}
                        </div>
                    </div>)
                })
                }
            </div>
        </div>
    );
};

export default HomePage;
