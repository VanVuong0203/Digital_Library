const express = require("express");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const User = require("../models/user");
const Rating = require("../models/rating");
const Book = require("../models/Book");
const BookView = require("../models/BookView");
require("dotenv").config();

const router = express.Router();

//đăng ký người dùng
router.post("/register", async (req, res) => {
    try {
        const { name, email, password, confirmPassword } = req.body;

        if (password !== confirmPassword) {
            return res.status(400).json({ message: "Mật khẩu và xác nhận mật khẩu không trùng khớp!" })
        }

        const existingUser = await User.findOne({ where: { email } });

        if (existingUser) {
            return res.status(400).json({ message: "Email đã được sử dụng!" + email });
        }

        const hashedPassword = await bcrypt.hash(password, 10);

        const newUser = await User.create({
            name,
            email,
            password: hashedPassword,
            role: "user",
        });

        res.status(201).json({ message: "Đăng ký thành công!" });
    } catch (error) {
        res.status(500).json({ message: "Lỗi Server", error });
    }
});

//đăng nhập người dùng
router.post("/login", async (req, res) => {
    try {
        const { email, password } = req.body;

        const user = await User.findOne({ where: { email } });

        if (!user) {
            return res.status(400).json({ message: "Email không tồn tại!" });
        }

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ message: "Sai mật khẩu!" });
        }

        const token = jwt.sign(
            { id: user.id, role: user.role },
            process.env.JWT_SECRET,
            { expiresIn: "5h" }
        );
        res.status(200).json({ message: "Đăng nhập thành công!", token, user });


    } catch (error) {


        res.status(500).json({ message: "Lỗi server", error });
    }
});


// Thêm đánh giá
router.post("/book/:bookId", async (req, res) => {
    try {
        const { userId, rating, comment } = req.body;

        const { bookId } = req.params;

        const user = await User.findByPk(userId);
        const book = await Book.findByPk(bookId);

        if (!userId || !bookId || !rating || !comment) {
            return res.status(400).json({ message: "Thiếu thông tin đánh giá." });
        }

        const newRating = await Rating.create({
            user_id: userId,
            book_id: bookId,
            name: user.name,
            title: book.title,
            rating: rating,
            comment: comment,
            date: new Date()
        });

        console.log(newRating);



        res.status(201).json({ message: "Gửi đánh giá thành công!", rating: newRating });
    } catch (error) {
        console.error("Lỗi khi gửi đánh giá:", error);
        res.status(500).json({ message: "Lỗi server", error });
    }
});



// Lấy đánh giá theo id book
router.get("/book/:bookId", async (req, res) => {
    try {
        const { bookId } = req.params;

        const ratings = await Rating.findAll({
            where: { book_id: bookId },
            include: [{
                model: User,
                attributes: ['name']
            }],
            order: [['date', 'DESC']]
        });

        const formatted = ratings.map(r => ({
            rating: r.rating,
            comment: r.comment,
            date: r.date,
            user: r.User.id,
            username: r.User.name
        }));

        res.json(formatted);
    } catch (error) {
        console.error("Lỗi khi lấy đánh giá:", error);
        res.status(500).json({ message: "Lỗi server", error });
    }
});

// API xóa đánh giá
router.delete("/admin/ratings/:id", async (req, res) => {
    try {
        const { id } = req.params;
        const rating = await Rating.findByPk(id);
        if (!rating) {
            return res.status(404).json({ message: "Không tìm thấy sách" });
        }
        await rating.destroy();
        res.status(200).json({ message: "Sách đã được xóa thành công!" });
    } catch (error) {
        res.status(500).json({ message: "Lỗi khi xóa sách", error });
    }
});


//API lấy tất cả lượt truy cập
router.get("/admin/total-views", async (req, res) => {
    try {
        // Tính tổng giá trị trong cột view_count
        const totalViews = await BookView.sum('view_count');

        res.status(200).json({ totalViews });
    } catch (error) {
        console.error("Lỗi khi lấy tổng lượt truy cập:", error);
        res.status(500).json({ message: "Lỗi khi lấy tổng lượt truy cập", error });
    }
});


module.exports = router;


/**
 * @swagger
 * tags:
 *   - name: User
 *     description: Các API liên quan đến người dùng
 */

/**
 * @swagger
 * /register:
 *   post:
 *     summary: Đăng ký người dùng mới
 *     tags: [User]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               name:
 *                 type: string
 *               email:
 *                 type: string
 *               password:
 *                 type: string
 *               confirmPassword:
 *                 type: string
 *     responses:
 *       201:
 *         description: Đăng ký thành công
 *       400:
 *         description: Mật khẩu và xác nhận mật khẩu không trùng khớp hoặc email đã được sử dụng
 *       500:
 *         description: Lỗi server
 */
router.post("/register", async (req, res) => {
    // Đoạn mã xử lý đăng ký
});

/**
 * @swagger
 * /login:
 *   post:
 *     summary: Đăng nhập người dùng
 *     tags: [User]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               email:
 *                 type: string
 *               password:
 *                 type: string
 *     responses:
 *       200:
 *         description: Đăng nhập thành công
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                 token:
 *                   type: string
 *                 user:
 *                   type: object
 *                   properties:
 *                     id:
 *                       type: integer
 *                     name:
 *                       type: string
 *                     email:
 *                       type: string
 *                     role:
 *                       type: string
 *       400:
 *         description: Email không tồn tại hoặc sai mật khẩu
 *       500:
 *         description: Lỗi server
 */
router.post("/login", async (req, res) => {
    // Đoạn mã xử lý đăng nhập
});

/**
 * @swagger
 * /book/{bookId}:
 *   post:
 *     summary: Thêm đánh giá cho sách
 *     tags: [Rating]
 *     parameters:
 *       - name: bookId
 *         in: path
 *         description: ID của sách
 *         required: true
 *         schema:
 *           type: integer
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               userId:
 *                 type: integer
 *               rating:
 *                 type: integer
 *               comment:
 *                 type: string
 *     responses:
 *       201:
 *         description: Gửi đánh giá thành công
 *       400:
 *         description: Thiếu thông tin đánh giá
 *       500:
 *         description: Lỗi server
 */
router.post("/book/:bookId", async (req, res) => {
    // Đoạn mã xử lý thêm đánh giá
});

/**
 * @swagger
 * /book/{bookId}:
 *   get:
 *     summary: Lấy danh sách đánh giá của một sách
 *     tags: [Rating]
 *     parameters:
 *       - name: bookId
 *         in: path
 *         description: ID của sách
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Danh sách đánh giá của sách
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: object
 *                 properties:
 *                   rating:
 *                     type: integer
 *                   comment:
 *                     type: string
 *                   date:
 *                     type: string
 *                   user:
 *                     type: integer
 *                   username:
 *                     type: string
 *       500:
 *         description: Lỗi server
 */
router.get("/book/:bookId", async (req, res) => {
    // Đoạn mã xử lý lấy đánh giá
});

/**
 * @swagger
 * /admin/ratings/{id}:
 *   delete:
 *     summary: Xóa đánh giá theo ID
 *     tags: [Admin]
 *     parameters:
 *       - name: id
 *         in: path
 *         description: ID của đánh giá
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Đánh giá đã được xóa thành công
 *       404:
 *         description: Không tìm thấy đánh giá
 *       500:
 *         description: Lỗi server
 */
router.delete("/admin/ratings/:id", async (req, res) => {
    // Đoạn mã xử lý xóa đánh giá
});

/**
 * @swagger
 * /admin/total-views:
 *   get:
 *     summary: Lấy tổng số lượt truy cập
 *     tags: [Admin]
 *     responses:
 *       200:
 *         description: Tổng số lượt truy cập
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 totalViews:
 *                   type: integer
 *       500:
 *         description: Lỗi khi lấy tổng lượt truy cập
 */
router.get("/admin/total-views", async (req, res) => {
    // Đoạn mã xử lý lấy tổng lượt truy cập
});
