import { Navigate, Outlet } from "react-router-dom";
import { jwtDecode } from "jwt-decode";

const PrivateRoute = () => {
    const token = localStorage.getItem("token");

    if (!token) {
        return <Navigate to="/login" />;
    }

    try {
        const decodedToken = jwtDecode(token);
        const now = Math.floor(Date.now() / 1000);

        // Kiểm tra token có hết hạn không
        if (decodedToken.exp < now) {
            alert("Phiên đăng nhập đã hết hạn!");
            return <Navigate to="/login" />;
        }

        return <Outlet />;
    } catch (error) {
        console.error("Lỗi decode token:", error);
        return <Navigate to="/login" />;
    }
};

export default PrivateRoute;
