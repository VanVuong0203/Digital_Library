import React, { useState } from "react";
import { toast } from "react-toastify";
import { addAudioBook } from "../services/api";
import "../assets/styles/AudioBookForm.css";

const AddAudioBookPage = () => {
    const [title, setTitle] = useState("");
    const [author, setAuthor] = useState("");
    const [coverImage, setCoverImage] = useState("");
    const [previewImage, setPreviewImage] = useState("");
    const [audioPath, setAudioPath] = useState("");
    const [description, setDescription] = useState("");

    const handleSubmit = async (e) => {
        e.preventDefault();

        if (!title || !author || !audioPath || !coverImage) {
            toast.error("Vui lòng điền đầy đủ thông tin.");
            return;
        }

        const audioBookData = {
            title,
            author,
            audio_url: audioPath,
            cover_image: coverImage,
            description,
        };

        try {
            await addAudioBook(audioBookData);
            toast.success("Sách nói đã được thêm!");
            // Reset form nếu cần:
            setTitle("");
            setAuthor("");
            setCoverImage("");
            setPreviewImage("");
            setAudioPath("");
            setDescription("");
        } catch (error) {
            console.error("Lỗi khi thêm sách:", error);
            toast.error("Đã có lỗi xảy ra, vui lòng thử lại.");
        }
    };

    return (
        <div className="book-form-container-audio">
            <h2>Thêm Sách Nói Mới</h2>
            <form className="book-form" onSubmit={handleSubmit}>
                {/* Cột trái - Ảnh bìa hiển thị */}
                <div className="form-column column-1">
                    {previewImage && (
                        <div className="image-preview">
                            <img
                                src={previewImage}
                                alt="Ảnh bìa"
                                onError={(e) => {
                                    e.target.src = "/default-cover.jpg";
                                }}
                            />
                        </div>
                    )}
                </div>

                {/* Cột giữa - Tiêu đề & Tác giả */}
                <div className="form-column column-2">
                    <div className="form-group">
                        <label>Tiêu Đề</label>
                        <input
                            type="text"
                            value={title}
                            onChange={(e) => setTitle(e.target.value)}
                            placeholder="Nhập tiêu đề sách"
                        />
                    </div>
                    <div className="form-group">
                        <label>Tác Giả</label>
                        <input
                            type="text"
                            value={author}
                            onChange={(e) => setAuthor(e.target.value)}
                            placeholder="Nhập tên tác giả"
                        />
                    </div>
                    <div className="form-group">
                        <label>Đường Dẫn Tệp Âm Thanh</label>
                        <input
                            type="text"
                            value={audioPath}
                            onChange={(e) => setAudioPath(e.target.value)}
                            placeholder="Nhập đường dẫn âm thanh"
                        />
                    </div>
                </div>

                {/* Cột phải - Mô tả và Đường dẫn ảnh bìa */}
                <div className="form-column column-3">
                    <div className="form-group">
                        <label>Mô Tả</label>
                        <textarea
                            value={description}
                            onChange={(e) => setDescription(e.target.value)}
                            placeholder="Nhập mô tả sách nói"
                        />
                    </div>
                    <div className="form-group">
                        <label>Đường Dẫn Ảnh Bìa</label>
                        <input
                            type="text"
                            value={coverImage}
                            onChange={(e) => {
                                setCoverImage(e.target.value);
                                setPreviewImage(e.target.value);
                            }}
                            placeholder="Nhập URL ảnh bìa"
                        />
                    </div>
                </div>

                <div className="button-container">
                    <button type="submit" className="submit-btn">
                        Thêm Sách Nói
                    </button>
                </div>
            </form>
        </div>
    );
};

export default AddAudioBookPage;
