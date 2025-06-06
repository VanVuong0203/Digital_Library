import React, { useState } from "react";
import { Link, Outlet, useNavigate } from "react-router-dom";
import "../assets/styles/Admin.css";
import { FaUserTie, FaBars, FaBook, FaUser, FaComment, FaFileInvoice, FaSlidersH, FaSignOutAlt } from "react-icons/fa";


const Admin = () => {
    const [statusMenu, setStatusMenu] = useState(false);
    const navigate = useNavigate();

    const handleToggleMenu = () => {
        setStatusMenu(!statusMenu);
    };

    const logOut = () => {
        navigate('/', { replace: true });
    };
    return (
        <div style={{ display: "flex" }}>
            <div className={`navigation col l-3 ${statusMenu ? "active" : ""}`}>
                <ul className={'nav-list'}>
                    <li className={'nav-item'}>
                        <Link to="/admin" className={'nav-item-link'}>
                            <span className={'nav-icon'}>
                                <FaUserTie className="icon" />
                            </span>
                            <h3 className={'nav-title'}>FPT Book Library</h3>
                        </Link>
                    </li>
                    <li className={'nav-item'}>
                        <Link to={"/admin/books"} className={'nav-item-link'}>
                            <span className={'nav-icon'}>
                                <FaBook className="icon" />
                            </span>
                            <span className={'nav-title'}>Sách Điện Tử</span>
                        </Link>
                    </li>
                    <li className={'nav-item'}>
                        <Link to={"/admin/audiobooks"} className={'nav-item-link'}>
                            <span className={'nav-icon'}>
                                <FaFileInvoice className="icon" />
                            </span>
                            <span className={'nav-title'}>Sách Nói</span>
                        </Link>
                    </li>
                    <li className={'nav-item'}>
                        <Link to={"/admin/users"} className={'nav-item-link'}>
                            <span className={'nav-icon'}>
                                <FaUser className="icon" />
                            </span>
                            <span className={'nav-title'}>Khách Hàng</span>
                        </Link>
                    </li>
                    <li className={'nav-item'}>
                        <Link to={"/admin/ratings"} className={'nav-item-link'}>
                            <span className={'nav-icon'}>
                                <FaComment className="icon" />
                            </span>
                            <span className={'nav-title'}>Đánh Giá</span>
                        </Link>
                    </li>
                    <li className={'nav-item'}>
                        <Link to="/admin/slider" className={'nav-item-link'}>
                            <span className={'nav-icon'}>
                                <FaSlidersH className="icon" />
                            </span>
                            <span className={'nav-title'}>Slider</span>
                        </Link>
                    </li>
                    {/* <li className={'nav-item'}>
                        <Link className={'nav-item-link'}>
                            <span className={'nav-icon'}>
                                <FaWarehouse className="icon" />
                            </span>
                            <span className={'nav-title'}>Kho</span>
                        </Link>
                    </li> */}
                    <li className={'nav-item'} onClick={logOut}>
                        <Link to={''} className={'nav-item-link'}>
                            <span className={'nav-icon'}>
                                <FaSignOutAlt className="icon" />
                            </span>
                            <span className={'nav-title'}>Thoát</span>
                        </Link>
                    </li>
                </ul>
            </div>
            <div className={`content col l-9 ${statusMenu ? 'active' : ''}`}>
                <div className={'topbar'}>
                    <div className={'toggle'} onClick={handleToggleMenu}>
                        <FaBars className="icon" />
                    </div>
                    <div className={'user'}>
                    </div>
                </div>

                <Outlet />
            </div>
        </div >
    );
};
export default Admin;
