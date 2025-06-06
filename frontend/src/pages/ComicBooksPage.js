import React, { useState, useEffect } from "react";
import { getBooks } from "../services/api";
import BookItem from "../components/BookItem";
import "../assets/styles/BookListPage.css";
import { useLocation } from "react-router-dom";

const ComicBooksPage = () => {
    const [filteredBooks, setFilteredBooks] = useState([]);
    const location = useLocation();


    useEffect(() => {
        getBooks()
            .then(response => {
                const result = location?.state ? location.state : "";
                setFilteredBooks(response.data.filter(book => book.genre === result));
            })
            .catch(error => console.error("Lỗi khi lấy danh sách sách:", error));
    }, [location?.state]);

    return (
        <div>
            <div className="book-list">
                {filteredBooks.length > 0 ? (
                    filteredBooks.map((book) => <BookItem key={book.id} book={book} />)
                ) : (
                    <p>Không có sách nào thuộc thể loại {location?.state}.</p>
                )}
            </div>
        </div>
    );
};

export default ComicBooksPage;
