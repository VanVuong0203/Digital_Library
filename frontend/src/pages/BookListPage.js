import React, { useState, useEffect } from "react";
import { getBooks } from "../services/api";
import BookItem from "../components/BookItem";
import "../assets/styles/BookListPage.css";

const BookListPage = (props) => {
    const [books, setBooks] = useState([]);
    const [filteredBooks, setFilteredBooks] = useState([]);
    const { searchQuery } = props

    useEffect(() => {
        if (!searchQuery) return;

        const titleKeyword = searchQuery.title?.toLowerCase() || "";
        const genreKeyword = searchQuery.genre || "";

        const filtered = books.filter(book => {
            const matchesTitleOrAuthor =
                book.title.toLowerCase().includes(titleKeyword) ||
                book.author.toLowerCase().includes(titleKeyword);

            const matchesGenre =
                genreKeyword === "" || book.genre.includes(genreKeyword);
            return matchesTitleOrAuthor && matchesGenre;
        });

        setFilteredBooks(filtered);
    }, [searchQuery, books]);



    useEffect(() => {
        getBooks()
            .then(response => {
                setBooks(response.data);
                setFilteredBooks(response.data);
            })
            .catch(error => console.error("Lỗi khi lấy danh sách sách:", error));
    }, []);

    return (
        <>
            <div className="book-list">
                {filteredBooks.map((book) => <BookItem key={book.id} book={book} />)}
            </div>
        </>
    );
};

export default BookListPage;
