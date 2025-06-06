import React, { useState } from "react";
import "../assets/styles/AuthPage.css";
import { toast } from "react-toastify";
import { useNavigate } from "react-router-dom";

const AuthPage = () => {
    const [signIn, toggle] = useState(true);
    const navigate = useNavigate();

    const [loginData, setLoginData] = useState({ email: "", password: "" });
    const [registerData, setRegisterData] = useState({ name: "", email: "", password: "", confirmPassword: "" });
    const [error, setError] = useState("");

    const handleLoginSubmit = async (e) => {
        e.preventDefault();
        setError("");

        try {
            const res = await fetch("http://localhost:8080/api/login", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(loginData)
            });

            const data = await res.json();

            if (!res.ok) throw new Error(data.message || "Đăng nhập thất bại!");

            localStorage.setItem("token", data.token);
            localStorage.setItem("user", JSON.stringify(data.user));

            toast.success(data.message || "Đăng nhập thành công!");
            navigate("/");

        } catch (err) {
            setError(err.message);
            toast.error(err.message || "Có lỗi xảy ra!");
        }
    };

    const handleRegisterSubmit = async (e) => {
        e.preventDefault();
        setError("");

        if (registerData.password !== registerData.confirmPassword) {
            const msg = "Mật khẩu và xác nhận không khớp!";
            setError(msg);
            toast.error(msg);
            return;
        }

        try {
            const res = await fetch("http://localhost:8080/api/register", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(registerData)
            });

            const data = await res.json();

            if (!res.ok) throw new Error(data.message || "Đăng ký thất bại!");

            toast.success("Đăng ký thành công!");
            toggle(true);
        } catch (err) {
            setError(err.message);
            toast.error(err.message || "Có lỗi xảy ra!");
        }
    };

    return (
        <div className="auth-wrapper">
            <div className={`container ${signIn ? "" : "right-panel-active"}`}>
                {/* Đăng ký */}
                <div className="form-container sign-up-container">
                    <form onSubmit={handleRegisterSubmit}>
                        <h2>Tạo tài khoản</h2>
                        <input
                            type="text"
                            placeholder="Họ tên"
                            value={registerData.name}
                            onChange={(e) => setRegisterData({ ...registerData, name: e.target.value })}
                            required
                        />
                        <input
                            type="email"
                            placeholder="Email"
                            value={registerData.email}
                            onChange={(e) => setRegisterData({ ...registerData, email: e.target.value })}
                            required
                        />
                        <input
                            type="password"
                            placeholder="Mật khẩu"
                            value={registerData.password}
                            onChange={(e) => setRegisterData({ ...registerData, password: e.target.value })}
                            required
                        />
                        <input
                            type="password"
                            placeholder="Xác nhận mật khẩu"
                            value={registerData.confirmPassword}
                            onChange={(e) => setRegisterData({ ...registerData, confirmPassword: e.target.value })}
                            required
                        />
                        {error && <p className="error-message">{error}</p>}
                        <button className="btn-register" type="submit">Đăng ký</button>
                    </form>
                </div>

                {/* Đăng nhập */}
                <div className="form-container sign-in-container">
                    <form onSubmit={handleLoginSubmit}>
                        <h2>Đăng nhập</h2>
                        <input
                            type="email"
                            placeholder="Email"
                            value={loginData.email}
                            onChange={(e) => setLoginData({ ...loginData, email: e.target.value })}
                            required
                        />
                        <input
                            type="password"
                            placeholder="Mật khẩu"
                            value={loginData.password}
                            onChange={(e) => setLoginData({ ...loginData, password: e.target.value })}
                            required
                        />
                        {error && <p className="error-message">{error}</p>}
                        <button className="btn-login" type="submit">Đăng nhập</button>
                    </form>
                </div>

                {/* Overlay */}
                <div className="overlay-container">
                    <div className="overlay">
                        <div className="overlay-panel overlay-left">
                            <h2>Chào mừng trở lại!</h2>
                            <p>Đã có tài khoản? Hãy đăng nhập để tiếp tục</p>
                            <button className="ghost" onClick={() => toggle(true)}>Đăng nhập</button>
                        </div>
                        <div className="overlay-panel overlay-right">
                            <h2>Xin chào, bạn mới!</h2>
                            <p>Chưa có tài khoản? Hãy đăng ký ngay</p>
                            <button className="ghost" onClick={() => toggle(false)}>Đăng ký</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default AuthPage;
