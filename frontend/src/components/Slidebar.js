import React, { useState } from "react";
import { Link } from "react-router-dom";
import { FaBook, FaHeadphones, FaImages, FaVideo, FaChalkboardTeacher, FaStar, FaUserShield, FaPhone } from "react-icons/fa";
import "../assets/styles/Slidebar.css";

const Slidebar = () => {
    const [openMenus, setOpenMenus] = useState({});

    const toggleMenu = (menu) => {
        setOpenMenus((prev) => ({
            ...prev,
            [menu]: !prev[menu],
        }));
    };

    return (
        <div className="slidebar">
            <div className="slidebar-section">
                <h3 className="slidebar-title">THƯ VIỆN SỐ</h3>
                <ul className="slidebar-list">
                    <li className={`dropdown ${openMenus.sachDienTu ? "open" : ""}`} onClick={() => toggleMenu("sachDienTu")}>
                        <div className="dropdown-title">
                            <FaBook className="icon" />
                            <span>Thư Viện Sách</span>
                            <span className={`arrow ${openMenus.sachDienTu ? "rotate" : ""}`}></span>
                        </div>
                        <ul className={`submenu ${openMenus.sachDienTu ? "open" : ""}`}>
                            <li><Link to="/books" className="submenu-link">Sách Điện Tử</Link></li>
                            <li><Link to="/books/audio" className="submenu-link">Sách Nói</Link></li>
                        </ul>
                    </li>
                    <li className="dropdown-title">
                        <Link to="/books/comics" className="dropdown-link" state={"Truyện tranh - Thiếu nhi"}>
                            <FaHeadphones className="icon" />
                            <span>Truyện Tranh</span>
                        </Link>
                    </li>
                    <li className="dropdown-title">
                        <Link to="/books/comics" className="dropdown-link" state={"Kinh doanh & Tài chính"}>
                            <FaImages className="icon" />
                            <span>Kinh Doanh</span>
                        </Link>
                    </li>
                    <li className="dropdown-title">
                        <Link to="/books/comics" className="dropdown-link" state={"Tâm lý - Triết học"}>
                            <FaVideo className="icon" />
                            <span>Tâm Lý Học</span>
                        </Link>
                    </li>
                    <li className={`dropdown ${openMenus.video ? "open" : ""}`} onClick={() => toggleMenu("video")}>
                        <div className="dropdown-title">
                            <FaChalkboardTeacher className="icon" />
                            <span>Bài Giảng Điện Tử</span>
                            <span className={`arrow ${openMenus.video ? "rotate" : ""}`}></span>
                        </div>
                        <ul className={`submenu ${openMenus.video ? "open" : ""}`}>
                            <li>
                                <Link to="/videos" className="dropdown-link">Bài giảng</Link>
                            </li>
                            <li>
                                <Link to="/learning-materials" className="dropdown-link">Học liệu</Link>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
            <div className="library-section">DANH MỤC</div>
            <ul className="library-list">
                <li className="dropdown-title">
                    <Link to="/reviews" className="dropdown-link">
                        <FaStar className="icon" />
                        <span>ĐÁNH GIÁ</span>
                    </Link>
                </li>
                <Link to='/admin'>
                    <li className="dropdown-title">
                        <FaUserShield className="icon" />
                        <span>ADMIN</span>
                    </li>
                </Link>
                <li className="dropdown-title">
                    <FaPhone className="icon" />
                    <span>LIÊN HỆ</span>
                </li>
            </ul>
        </div>
    );
};

export default Slidebar;
