import React, { useEffect, useState } from "react";
import { getAllRatings, deleteRating } from "../services/api";
import "../assets/styles/AdminTable.css";
import Swal from "sweetalert2";
import { toast } from "react-toastify";
import Pagination from "../components/Pagination";

const AdminRatingManagementPage = () => {
    const [ratings, setRatings] = useState([]);
    const [searchTerm, setSearchTerm] = useState("");
    const [currentPage, setCurrentPage] = useState(1);
    const ratingsPerPage = 10;

    const [sortField, setSortField] = useState("");
    const [sortOrder, setSortOrder] = useState("asc");

    useEffect(() => {
        getAllRatings()
            .then((response) => setRatings(response.data))
            .catch((error) => console.error("Lỗi khi lấy danh sách đánh giá:", error));
    }, []);

    const handleDelete = async (id) => {
        const result = await Swal.fire({
            title: 'Xác nhận xóa?',
            text: "Bạn có chắc chắn muốn xóa đánh giá này không?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Xóa',
            cancelButtonText: 'Hủy'
        });

        if (result.isConfirmed) {
            try {
                await deleteRating(id);
                setRatings(prev => prev.filter((rating) => rating.id !== id));
                toast.success("Đánh giá đã được xóa!");
            } catch (error) {
                console.error("Lỗi khi xóa đánh giá:", error);
            }
        }
    };

    // Lọc theo từ khóa
    const filteredRatings = ratings.filter((rating) => {
        const name = rating.name?.toLowerCase() || "";
        const title = rating.title?.toLowerCase() || "";
        const search = searchTerm.toLowerCase();
        return name.includes(search) || title.includes(search);
    });

    // Sắp xếp
    const sortedRatings = [...filteredRatings].sort((a, b) => {
        if (!sortField) return 0;

        if (sortField === "rating") {
            return sortOrder === "asc" ? a.rating - b.rating : b.rating - a.rating;
        }

        if (sortField === "date") {
            const dateA = new Date(a.date);
            const dateB = new Date(b.date);
            return sortOrder === "asc" ? dateA - dateB : dateB - dateA;
        }

        return 0;
    });

    return (
        <>
            <div className="account-header">
                <h2 className="account-heading">Danh Mục Đánh Giá</h2>
            </div>

            {/* Bộ lọc sắp xếp */}
            <div className="sort-controls">
                <label>Sắp xếp: </label>
                <select
                    value={sortField}
                    onChange={(e) => setSortField(e.target.value)}
                    className="sort-select"
                >
                    <option value="">-- Chọn tiêu chí --</option>
                    <option value="rating">Số sao</option>
                    <option value="date">Ngày đánh giá</option>
                </select>

                <select
                    value={sortOrder}
                    onChange={(e) => setSortOrder(e.target.value)}
                    className="sort-select"
                >
                    <option value="asc">Tăng dần</option>
                    <option value="desc">Giảm dần</option>
                </select>

                <input
                    style={{ marginLeft: "690px" }}
                    type="text"
                    placeholder="Tìm kiếm tên khách hoặc sách..."
                    value={searchTerm}
                    onChange={(e) => {
                        setSearchTerm(e.target.value);
                        setCurrentPage(1);
                    }}
                    className="search-input-admin"
                />
            </div>

            <Pagination
                items={sortedRatings}
                currentPage={currentPage}
                itemsPerPage={ratingsPerPage}
                onPageChange={setCurrentPage}
                renderItems={(currentItems) => (
                    <table className="details-table">
                        <thead className="details-thead">
                            <tr className="details-title-list">
                                <td className="details-title-item">Tên Khách Hàng</td>
                                <td className="details-title-item">Sách</td>
                                <td className="details-title-item">Đánh Giá</td>
                                <td className="details-title-item">Đánh Giá(⭐)</td>
                                <td className="details-title-item">Ngày Đánh Giá</td>
                                <td className="details-title-item"></td>
                            </tr>
                        </thead>
                        <tbody className="details-tbody" >
                            {currentItems.length > 0 ? (
                                currentItems.map((rating) => (
                                    <tr className="details-content-list" key={rating.id}>
                                        <td className="details-content-item">{rating.name}</td>
                                        <td className="details-content-item">{rating.title}</td>
                                        <td className="details-content-item">{rating.comment}</td>
                                        <td className="details-content-item">
                                            {[...Array(5)].map((_, i) => (
                                                <span
                                                    key={i}
                                                    className="star"
                                                    style={{ color: i < rating.rating ? "gold" : "#ccc" }}
                                                >
                                                    ★
                                                </span>
                                            ))}
                                        </td>
                                        <td className="details-content-item">{rating.date}</td>
                                        <td className="details-content-item">
                                            <div style={{ display: "flex", justifyContent: "center" }}>
                                                <button
                                                    onClick={() => handleDelete(rating.id)}
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
                                        Không tìm thấy đánh giá nào.
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

export default AdminRatingManagementPage;
