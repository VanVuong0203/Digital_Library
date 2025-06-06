import React, { useEffect, useState } from "react";
import { useNavigate, Link, useLocation, useParams } from "react-router-dom";
import "../assets/styles/Header.css";
import { toast } from "react-toastify";
import defaultImage from "../assets/images/6659895.png";

const Header = (props) => {
    const { setSearchQuery } = props;
    const [txtSearch, setTxtSearch] = useState("");
    const [isLoggedIn, setIsLoggedIn] = useState(false);
    const [selectedCategory, setSelectedCategory] = useState("");
    const [searchCategory, setSearchCategory] = useState("");
    const [suggestions, setSuggestions] = useState([]);
    const navigate = useNavigate();

    const location = useLocation();
    const { id } = useParams();

    const categories = [
        { value: "fiction", label: "Khoa học viễn tưởng" },
        { value: "legend", label: "Văn học" },
        { value: "curriculum", label: "Học thuật - Giáo trình" },
        { value: "skill", label: "Kỹ năng - Phát triển" },
        { value: "business", label: "Kinh doanh - Tài chính" },
        { value: "technology", label: "Khoa học - Công nghệ" },
        { value: "mentality", label: "Tâm lý" },
        { value: "history", label: "Lịch sử" },
        { value: "medicine", label: "Y học" },
        { value: "comic", label: "Truyện tranh" }
    ];

    useEffect(() => {
        setTxtSearch("");
        setSearchQuery("");

        const token = localStorage.getItem("token");
        setIsLoggedIn(!!token);
    }, [location, setSearchQuery]);

    const handleSearch = () => {
        if (
            location.pathname === "/books" ||
            location.pathname === `/books/${id}` ||
            location.pathname === `/books/comics`
        ) {
            setSearchQuery({
                title: txtSearch,
                genre: searchCategory !== "" ? searchCategory : selectedCategory
            });
        }
    };

    const handleLogout = () => {
        localStorage.removeItem("token");
        setIsLoggedIn(false);
        toast.success("Đăng xuất thành công!");
    };

    const changeImage = (event) => {
        event.src = defaultImage;
    };

    const handleInputChange = async (e) => {
        const value = e.target.value;
        setTxtSearch(value);

        if (value.trim().length > 0) {
            try {
                // Gửi yêu cầu tìm kiếm đến API với từ khóa
                const res = await fetch(`http://localhost:8080/books?title=${value}`);
                const data = await res.json();

                // Lọc các sách có tên chứa từ khóa tìm kiếm
                const filteredSuggestions = data.filter(book => book.title.toLowerCase().includes(value.toLowerCase()));

                setSuggestions(filteredSuggestions); // Cập nhật gợi ý
            } catch (err) {
                console.error("Lỗi khi tìm kiếm:", err);
            }
        } else {
            setSuggestions([]); // Xóa gợi ý khi không có từ khóa tìm kiếm
        }
    };

    const handleSuggestionClick = (bookId) => {
        // Khi nhấn vào gợi ý, chuyển hướng đến trang chi tiết sách
        navigate(`/books/${bookId}`); // Điều hướng đến trang chi tiết sách
        setSuggestions([]); // Dọn dẹp gợi ý
    };

    return (
        <nav className="header">
            <div className="header-logo">
                <Link className="header-logo-item" to='/'>
                    <img src="/images/logo.png" alt="Logo" className="header-logo-item-icon" height='70px' width='auto' />
                </Link>
                <div className="la-co-container">
                    <div className="flag-pole"></div>
                    <img src="https://waka.vn/images/vn_flag.gif" alt="" className="la-co" />
                </div>
            </div>

            <div className="header-content">
                <h5 className="header-logo-item">Chi nhánh Công ty TNHH FPT IS tại TP Hồ Chí Minh</h5>
                <h4 className="header-logo-item">KHO TƯ LIỆU ĐIỆN TỬ</h4>
            </div>

            <div className="header-search">
                <select
                    className="header-option"
                    value={selectedCategory}
                    onChange={(e) => {
                        setSelectedCategory(e.target.value);
                        const selectedText = e.target.options[e.target.selectedIndex].text;
                        setSearchCategory(selectedText === "Tất cả thể loại" ? "" : selectedText);
                    }}
                >
                    <option value="">Tất cả thể loại</option>
                    {categories.map((category) => (
                        <option key={category.value} value={category.value}>
                            {category.label}
                        </option>
                    ))}
                </select>

                <div className="autocomplete-container">
                    <input
                        className="header_search-txt"
                        type="text"
                        placeholder="Tìm kiếm sách..."
                        value={txtSearch}
                        onChange={handleInputChange}
                    />
                    {suggestions.length > 0 && (
                        <ul className="autocomplete-suggestions">
                            {suggestions.map((book) => (
                                <li key={book.id} onClick={() => handleSuggestionClick(book.id)} className="suggestion-item">
                                    <img src={book.imgs} alt={book.title} className="suggestion-image" onError={(e) => changeImage(e.target)} />
                                    <span className="suggestion-title">{book.title}</span>
                                </li>
                            ))}
                        </ul>
                    )}
                </div>

                <button className="header_search-btn" onClick={handleSearch}>
                    <img src="/images/iconsearch.png" alt="Tìm kiếm" className="search-icon" height='25px' width='auto' />
                </button>
            </div>

            <div className="header-login">
                {isLoggedIn ? (
                    <button onClick={handleLogout} className="login-btn">Đăng Xuất</button>
                ) : (
                    <Link to='/login' className='login-btn'>Đăng Nhập</Link>
                )}
            </div>
        </nav>
    );
};

export default Header;
