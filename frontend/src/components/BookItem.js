import React from "react";
import { Link } from "react-router-dom";
import "../assets/styles/BookItem.css";
import defaultImage from "../assets/images/6659895.png";


const BookItem = ({ book }) => {

    const changeImage = (event) => {
        event.src = defaultImage;
    }

    return (
        <div className="book-item">
            <Link to={`/books/${book.id}`} className="book-item-link">
                <img src={book.imgs} alt={book.title} className="book-item-image" onError={(e) => changeImage(e.target)} />
                <h3>{book.title}</h3>
                <p>Tác giả: {book.author}</p>
            </Link>
        </div>
    );
};

export default BookItem;
