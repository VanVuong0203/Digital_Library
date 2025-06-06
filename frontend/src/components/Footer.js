import React from "react";

const Footer = () => {
    return (
        <footer>
            <div className="footer-container">
                <div className="footer-column">
                    <h3>Thư Viện Sách</h3>
                    <p>Website chia sẻ và đọc sách trực tuyến dành cho mọi lứa tuổi.</p>
                </div>
                <div className="footer-column">
                    <h4>Liên kết</h4>
                    <ul>
                        <li><a href="/">Trang chủ</a></li>
                        <li><a href="/about">Giới thiệu</a></li>
                        <li><a href="/contact">Liên hệ</a></li>
                    </ul>
                </div>
                <div className="footer-column">
                    <h4>Kết nối</h4>
                    <ul>
                        <li><a href="https://www.facebook.com/profile.php?id=100051728762627" target="_blank" rel="noreferrer">Facebook</a></li>
                        <li><a href="https://www.facebook.com/profile.php?id=100051728762627" target="_blank" rel="noreferrer">Twitter</a></li>
                        <li><a href="https://www.instagram.com/_hv.vuong_/" target="_blank" rel="noreferrer">Instagram</a></li>
                    </ul>
                </div>
                <div className="footer-column">
                    <h4>Thông tin</h4>
                    <p>📍 123 Nguyễn Văn A, TP.HCM</p>
                    <p>📞 0123 456 789</p>
                    <p>📧 lienhe@thuvien.com</p>
                </div>
            </div>
            <div className="footer-bottom">
                <p>© 2025 Thư Viện Sách. All rights reserved.</p>
            </div>
        </footer>
    );
};

export default Footer;
