import React, { useState, useEffect } from "react";
import "../assets/styles/AdminPage.css";
import { FaStar, FaEye, FaBook } from "react-icons/fa";
import { motion } from "framer-motion";
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, PieChart, Pie, Cell, Legend } from "recharts";
import { getAllRatings, getTotalViews, getTopBooks, getPieData } from "../services/api";

const AdminPage = () => {
    const [totalRatings, setTotalRatings] = useState(0);
    const [totalViews, setTotalViews] = useState(0);
    const [topBooks, setTopBooks] = useState([]);
    const [barData, setBarData] = useState([
        { name: 'Tháng 1', views: 1200 },
        { name: 'Tháng 2', views: 1300 },
        { name: 'Tháng 3', views: 1100 },
        { name: 'Tháng 4', views: 1400 },
        { name: 'Tháng 5', views: 1500 },
        { name: 'Tháng 6', views: 1600 },
        { name: 'Tháng 7', views: 1700 },
        { name: 'Tháng 8', views: 1800 },
        { name: 'Tháng 9', views: 1900 },
        { name: 'Tháng 10', views: 2000 },
        { name: 'Tháng 11', views: 2200 },
        { name: 'Tháng 12', views: 2300 },
    ]);
    const [pieData, setPieData] = useState([]);
    const COLORS = ["#0088FE", "#00C49F", "#FFBB28", "#FF8042"];

    useEffect(() => {
        const fetchData = async () => {
            try {
                // Lấy tổng số đánh giá
                const ratingsRes = await getAllRatings();
                setTotalRatings(ratingsRes.data.length);

                // Lấy tổng số lượt truy cập
                const viewsRes = await getTotalViews();
                setTotalViews(viewsRes.data.totalViews);

                // Lấy danh sách sách đọc nhiều nhất (ví dụ)
                const topBooksRes = await getTopBooks();
                setTopBooks(topBooksRes.data);

                // Lấy dữ liệu cho biểu đồ Pie (tỉ lệ đọc sách)
                const pieChartData = await getPieData();

                // Ép kiểu 'value' từ string sang number
                const formattedPieData = pieChartData.data.map(item => ({
                    ...item,
                    value: parseFloat(item.value),
                }));

                setPieData(formattedPieData);
            } catch (error) {
                console.error("Lỗi khi lấy dữ liệu:", error);
            }
        };

        fetchData();
    }, []);

    return (
        <div className="admin-dashboard">
            <h2>Thống Kê Quản Trị</h2>

            <div className="stats-grid">
                <motion.div className="stat-card" whileHover={{ scale: 1.05 }}>
                    <FaStar className="stat-icon" />
                    <div>
                        <h3>{totalRatings}</h3>
                        <p>Tổng đánh giá</p>
                    </div>
                </motion.div>

                <motion.div className="stat-card" whileHover={{ scale: 1.05 }}>
                    <FaEye className="stat-icon" />
                    <div>
                        <h3>{totalViews}</h3>
                        <p>Lượt truy cập</p>
                    </div>
                </motion.div>

                <motion.div className="stat-card large" whileHover={{ scale: 1.03 }}>
                    <FaBook className="stat-icon" />
                    <div>
                        <h3>Sách đọc nhiều nhất</h3>
                        <ul className="top-books-list">
                            {topBooks.length > 0 ? (
                                topBooks.map((book, index) => (
                                    <li key={index}>
                                        {index + 1}. {book.Book.title} ({book.read_count} lượt đọc)
                                    </li>
                                ))
                            ) : (
                                <li>Không có dữ liệu</li>
                            )}
                        </ul>
                    </div>
                </motion.div>
            </div>

            <div className="charts-section">
                <div className="chart-box">
                    <h4>Lượt truy cập theo tháng</h4>
                    <BarChart width={500} height={300} data={barData}>
                        <CartesianGrid strokeDasharray="5 5" />
                        <XAxis dataKey="name" />
                        <YAxis />
                        <Tooltip />
                        <Legend />
                        <Bar dataKey="views" fill="#007bff" />
                    </BarChart>
                </div>

                <div className="chart-box">
                    <h4>Tỉ lệ đọc sách</h4>
                    <div className="pie-chart-wrapper">
                        {Array.isArray(pieData) && pieData.length > 0 ? (
                            <motion.div
                                key={totalRatings}
                                initial={{ scale: 0 }}
                                animate={{ scale: 1 }}
                                transition={{ duration: 0.7, ease: "easeOut" }}
                            >
                                <PieChart width={300} height={300}>
                                    <Pie data={pieData} cx="50%" cy="50%" outerRadius={80} label dataKey="value">
                                        {pieData.map((_, index) => (
                                            <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                                        ))}
                                    </Pie>
                                    <Tooltip />
                                </PieChart>
                            </motion.div>
                        ) : (
                            <p>Không có dữ liệu cho biểu đồ</p>
                        )}

                        <div className="custom-legend">
                            {pieData.map((entry, index) => (
                                <div key={`item-${index}`} className="legend-item">
                                    <span className="legend-color" style={{ backgroundColor: COLORS[index % COLORS.length] }}></span>
                                    {entry.name}
                                </div>
                            ))}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default AdminPage;
