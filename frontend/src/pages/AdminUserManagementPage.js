import { useEffect, useState } from "react";
import { deleteUser, getUsers } from "../services/api";
import "../assets/styles/AdminTable.css";
import Swal from "sweetalert2";
import { toast } from "react-toastify";
import Pagination from "../components/Pagination";

const AdminUserManagementPage = () => {
    const [users, setUsers] = useState([]);
    const [searchTerm, setSearchTerm] = useState("");
    const [currentPage, setCurrentPage] = useState(1);
    const usersPerPage = 8;

    useEffect(() => {
        getUsers()
            .then(Response => {
                console.log("data:> ", Response.data);

                setUsers(Response.data)
            })
            .catch(error => console.error("Lỗi khi lấy danh sách khách hàng:", error));
    }, []);

    const handleDelete = async (id) => {
        const result = await Swal.fire({
            title: 'Xác nhận xóa?',
            text: "Bạn có chắc chắn muốn xóa khách hàng này không?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Xóa',
            cancelButtonText: 'Hủy'
        });

        if (result.isConfirmed) {
            try {
                await deleteUser(id);
                setUsers(prev => prev.filter((user) => user.id !== id));
                toast.success("Khách hàng đã được xóa!");
            } catch (error) {
                console.error("Lỗi khi xóa khách hàng!:", error);
            }
        }
    };

    // Lọc theo từ khóa
    const filteredUsers = users.filter((user) => {
        const name = user.name?.toLowerCase() || "";
        const search = searchTerm.toLowerCase();
        return name.includes(search);
    });

    return (
        <>
            <div className={('account-header')}>
                <h2 className={('account-heading')}>Danh Sách Khách Hàng</h2>
                <input
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
                items={filteredUsers}
                currentPage={currentPage}
                itemsPerPage={usersPerPage}
                onPageChange={setCurrentPage}
                renderItems={(currentItems) => (
                    < table className={('details-table')}>
                        <thead className={('details-thead')}>
                            <tr className={('details-title-list')}>
                                <td className={('details-title-item')}>Name</td>
                                <td className={('details-title-item')}>Email</td>
                                <td className={('details-title-item')}>Password</td>
                                <td className={('details-title-item')}>Role</td>
                                <td className={('details-title-item')}></td>
                            </tr>
                        </thead>
                        <tbody className='details-tbody'>
                            {currentItems.length > 0 ? (
                                currentItems.map((user) => (
                                    <tr className={('details-content-list')} key={user.id}>
                                        <td className={('details-content-item')}>{user.name}</td>
                                        <td className={('details-content-item')}>{user.email}</td>
                                        <td className={('details-content-item')}>{user.password}</td>
                                        <td className={('details-content-item')}>{user.role}</td>
                                        <td className={('details-content-item')}>
                                            <div style={{ display: "flex", alignItems: "center", justifyContent: "center", gap: "10px" }}>
                                                <button
                                                    onClick={() => handleDelete(user.id)}
                                                    className={('details-content-item-btn-delete')}
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

export default AdminUserManagementPage;