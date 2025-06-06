import React, { useEffect, useState } from "react";
import "../assets/styles/BookItem.css";
import "../assets/styles/AudioBooks.css";
import { getAudioBooks } from "../services/api";
import { useNavigate } from "react-router-dom";


const AudioBooks = () => {
    const [audioBooks, setAudioBooks] = useState([]);
    const [currentAudio, setCurrentAudio] = useState(null);
    const [showPlayer, setShowPlayer] = useState(false);
    const navigate = useNavigate();

    useEffect(() => {
        const fetchData = async () => {
            try {
                const res = await getAudioBooks();
                setAudioBooks(res.data);
            } catch (err) {
                console.error("Lỗi khi tải sách nói:", err);
            }
        };
        fetchData();
    }, []);

    // const handlePlayPreview = (book) => {
    //     setCurrentAudio(book);
    //     setShowPlayer(true);
    // };

    const handleClose = () => {
        setShowPlayer(false);
        setCurrentAudio(null);
    };

    return (
        <div className={`audio-books-container ${showPlayer ? "blurred" : ""}`}>
            <div className="book-list" style={{ display: "flex", flexWrap: "wrap", gap: "20px" }}>
                {audioBooks.map((book) => (
                    <div key={book.id} className="book-item" onClick={() => navigate(`/books/${book.id}?type=audio`)}
                        style={{ cursor: "pointer" }}>
                        <img src={book.cover_image} alt={book.title} />
                        <h3>{book.title}</h3>
                        <p>Tác giả: {book.author}</p>
                        {/* <button onClick={() => handlePlayPreview(book)} className="preview-button">
                            🎧 Nghe thử
                        </button> */}
                    </div>
                ))}
            </div>

            {showPlayer && currentAudio && (
                <div className="audio-modal">
                    <div className="modal-content">
                        <span className="close-btn" onClick={handleClose}>&times;</span>
                        <img src={currentAudio.cover_image} alt={currentAudio.title} className="modal-img" />
                        <h3>{currentAudio.title}</h3>
                        <p>{currentAudio.author}</p>
                        <audio controls autoPlay src={currentAudio.audio_url} className="audio-player" />
                    </div>
                </div>
            )}
        </div>
    );
};

export default AudioBooks;
