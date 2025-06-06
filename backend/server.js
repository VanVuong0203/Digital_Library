require("dotenv").config();
const express = require("express");
const cors = require("cors");
const path = require("path");

const sequelize = require("./config/database");
const Book = require("./models/Book");
const User = require("./models/user");
const Rating = require("./models/rating");

const authRouters = require("./routes/authRoutes");
const adminRouters = require("./routes/adminRoutes");
const bookRoutes = require("./routes/bookRoutes");

const swaggerUi = require("swagger-ui-express");
const swaggerJSDoc = require("swagger-jsdoc");

const app = express();
app.use(cors());
app.use(express.json());

// Thiết lập mối quan hệ
Rating.belongsTo(User, { foreignKey: "user_id" });
User.hasMany(Rating, { foreignKey: "user_id" });

// Swagger cấu hình
const swaggerDefinition = {
    openapi: "3.0.0",
    info: {
        title: "Library Book API",
        version: "1.0.0",
        description: "Tài liệu API cho hệ thống quản lý sách",
    },
    servers: [
        {
            url: "http://localhost:8080",
            description: "Local server",
        },
    ],
};

const swaggerOptions = {
    swaggerDefinition,
    apis: ["./routes/*.js"], // <-- Đường dẫn tới các file chứa Swagger JSDoc
};

const swaggerSpec = swaggerJSDoc(swaggerOptions);
app.use("/swagger-ui", swaggerUi.serve, swaggerUi.setup(swaggerSpec));

// Router
app.use("/api", authRouters, adminRouters);
app.use("", bookRoutes);
app.use("/images", express.static(path.join(__dirname, "public/images")));

// Đồng bộ database
sequelize
    .sync()
    .then(() => console.log("Database đã được đồng bộ!"))
    .catch((err) => console.error("Lỗi đồng bộ database:", err));

// Các API (nên dời phần này vào file routes để dễ quản lý hơn)
/**
 * @swagger
 * /books:
 *   get:
 *     summary: Lấy danh sách tất cả sách
 *     tags: [Books]
 *     responses:
 *       200:
 *         description: Thành công
 */
app.get("/books", async (req, res) => {
    const books = await Book.findAll();
    res.json(books);
});

/**
 * @swagger
 * /admin/users:
 *   get:
 *     summary: Lấy danh sách người dùng (admin)
 *     tags: [Admin]
 *     responses:
 *       200:
 *         description: Thành công
 */
app.get("/admin/users", async (req, res) => {
    const users = await User.findAll();
    res.json(users);
});

/**
 * @swagger
 * /admin/books:
 *   get:
 *     summary: Lấy danh sách sách (admin)
 *     tags: [Admin]
 *     responses:
 *       200:
 *         description: Thành công
 */
app.get("/admin/books", async (req, res) => {
    const books = await Book.findAll();
    res.json(books);
});

// Khởi động server
const PORT = process.env.PORT || 8080;
app.listen(PORT, () => console.log(`Backend chạy tại http://localhost:${PORT}`));
