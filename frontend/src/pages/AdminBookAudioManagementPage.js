import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { getAudioBooks, deleteAudioBook } from "../services/api"; // Import API mới
import "../assets/styles/AdminTable.css";
import { toast } from "react-toastify";
import Swal from "sweetalert2";
import Pagination from "../components/Pagination";

const AdminBookAudioManagementPage = () => {
    const [audioBooks, setAudioBooks] = useState([]);
    const [searchTerm, setSearchTerm] = useState("");
    const [currentPage, setCurrentPage] = useState(1);
    const booksPerPage = 5;

    // Lấy danh sách sách nói
    useEffect(() => {
        getAudioBooks()
            .then(response => setAudioBooks(response.data))
            .catch(error => console.error("Lỗi khi lấy danh sách sách nói:", error));
    }, []);

    const handleDelete = async (id) => {
        const result = await Swal.fire({
            title: 'Xác nhận xóa?',
            text: "Bạn có chắc chắn muốn xóa sách này không?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Xóa',
            cancelButtonText: 'Hủy'
        });

        if (result.isConfirmed) {
            try {
                await deleteAudioBook(id); // Dùng API xóa sách nói
                setAudioBooks(prev => prev.filter((book) => book.id !== id));
                toast.success("Sách đã được xóa!");
            } catch (error) {
                console.error("Lỗi khi xóa sách:", error);
            }
        }
    };

    // Lọc theo từ khóa
    const filteredAudioBooks = audioBooks.filter((book) => {
        const title = book.title?.toLowerCase() || "";
        const search = searchTerm.toLowerCase();
        return title.includes(search);
    });

    return (
        <>
            <div className="account-header">
                <h2 className="account-heading">Danh Mục Sách Nói</h2>
                <input
                    className="search-input-admin"
                    type="text"
                    placeholder="Tìm kiếm tên sách..."
                    value={searchTerm}
                    onChange={(e) => {
                        setSearchTerm(e.target.value);
                        setCurrentPage(1);
                    }}
                />
                <Link to={`/admin/books/addAudioBook`} className="account-create-btn">
                    Thêm mới
                </Link>
            </div>
            <Pagination
                items={filteredAudioBooks}
                currentPage={currentPage}
                itemsPerPage={booksPerPage}
                onPageChange={setCurrentPage}
                renderItems={(currentItems) => (
                    <table className="details-table">
                        <thead className="details-thead">
                            <tr className="details-title-list">
                                <td className="details-title-item">Tiêu Đề</td>
                                <td className="details-title-item">Tác Giả</td>
                                <td className="details-title-item">Thể Loại</td>
                                <td className="details-title-item">Ảnh Bìa</td>
                                <td className="details-title-item">Tệp Âm Thanh</td>
                                <td className="details-title-item"></td>
                            </tr>
                        </thead>
                        <tbody className="details-tbody">
                            {currentItems.length > 0 ? (
                                currentItems.map((book) => (
                                    <tr className="details-content-list" key={book.id}>
                                        <td className="details-content-item">{book.title}</td>
                                        <td className="details-content-item">{book.author}</td>
                                        <td className="details-content-item">{book.genre}</td>
                                        <td className="details-content-item justify_item">
                                            <img
                                                src={process.env.PUBLIC_URL + book.imgs}
                                                alt={book.title}
                                                className="book-cover"
                                            />
                                        </td>
                                        <td className="details-content-item">

                                            <a href={book.audio_url} target="_blank" rel="noopener noreferrer">
                                                {book.audio_url}
                                            </a>
                                        </td>
                                        <td className="details-content-item">
                                            <div style={{ display: "flex", alignItems: "center", justifyContent: "center", gap: "10px" }}>
                                                <Link
                                                    to={`/admin/books/edit/${book.id}`}
                                                    className="details-content-item-btn"
                                                >
                                                    Sửa
                                                </Link>
                                                <button
                                                    onClick={() => handleDelete(book.id)}
                                                    className="details-content-item-btn-delete"
                                                >
                                                    Xóa
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                ))
                            ) : (
                                <tr>
                                    <td colSpan="6" style={{ textAlign: "center", padding: "20px" }}>
                                        Không tìm thấy sách nào.
                                    </td>
                                </tr>
                            )}
                        </tbody>
                    </table>
                )}
            />
        </>
    );
};

export default AdminBookAudioManagementPage;
