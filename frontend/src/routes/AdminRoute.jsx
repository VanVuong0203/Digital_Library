import React, { useState, useEffect } from "react";
import { Outlet, useNavigate } from "react-router-dom";
import { jwtDecode } from "jwt-decode";
import { Dialog, DialogTitle, DialogActions, Button } from "@mui/material";

const AdminRoute = () => {
    const [openModal, setOpenModal] = useState(false);
    const [redirectPath, setRedirectPath] = useState(null);
    const [isAuthorized, setIsAuthorized] = useState(false);
    const navigate = useNavigate();

    useEffect(() => {
        const token = localStorage.getItem("token");

        if (!token) {
            setRedirectPath("/login");
            setOpenModal(true);
            return;
        }

        try {
            const decodedToken = jwtDecode(token);
            const now = Math.floor(Date.now() / 1000);

            if (decodedToken.exp < now) {
                setRedirectPath("/login");
                setOpenModal(true);
                return;
            }

            if (decodedToken.role !== "admin") {
                setRedirectPath("/");
                setOpenModal(true);
                return;
            }

            setIsAuthorized(true);
        } catch (error) {
            console.error("Token không hợp lệ:", error);
            setRedirectPath("/login");
            setOpenModal(true);
        }
    }, []);

    const handleCloseModal = () => {
        setOpenModal(false);
        if (redirectPath) {
            navigate(redirectPath, { replace: true });
        }
    };

    if (openModal) {
        return (
            <Dialog open={openModal} onClose={handleCloseModal}>
                <DialogTitle>
                    {redirectPath === "/"
                        ? "Bạn không có quyền truy cập trang quản trị"
                        : "Phiên đăng nhập đã hết hạn hoặc bạn chưa đăng nhập"}
                </DialogTitle>
                <DialogActions>
                    <Button onClick={handleCloseModal} color="secondary">Đóng</Button>
                    {redirectPath === "/login" && (
                        <Button
                            onClick={() => navigate("/login", { replace: true })}
                            variant="contained"
                            color="primary"
                        >
                            Đăng nhập
                        </Button>
                    )}
                </DialogActions>
            </Dialog>
        );
    }

    return isAuthorized ? <Outlet /> : null;
};

export default AdminRoute;
