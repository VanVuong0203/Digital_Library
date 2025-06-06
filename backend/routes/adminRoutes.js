const express = require('express');
const Slider = require('../models/slider');
const rating = require('../models/rating');
const User = require('../models/user');
const router = express.Router();
const path = require("path");
const fs = require("fs");
const multer = require("multer");

const sliderDir = "D:/DuAnFPT/LibraryApp/frontend/public/slider";

if (!fs.existsSync(sliderDir)) fs.mkdirSync(sliderDir, { recursive: true });

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        if (file.mimetype.startsWith("image/")) {
            cb(null, sliderDir);
        } else {
            cb(new Error("Chỉ chấp nhận file ảnh!"), false);
        }
    },
    filename: (req, file, cb) => {
        cb(null, file.originalname);
    }
});
const upload = multer({ storage });


//API lấy danh sách slider
router.get('/slider', async (req, res) => {
    try {
        const slider = await Slider.findAll();
        res.status(200).json(slider);
    } catch (error) {
        console.error("Lỗi khi lấy danh sách slider:", error);
        res.status(500).json({ message: "Lỗi khi lấy danh sách slider", error });
    }
});

// API cập nhật Slider
router.put("/admin/slider", upload.fields([
    { name: 'img1', maxCount: 1 },
    { name: 'img2', maxCount: 1 },
    { name: 'img3', maxCount: 1 },
    { name: 'img4', maxCount: 1 }
]), async (req, res) => {
    try {
        const slider = await Slider.findByPk(1);
        if (!slider) {
            return res.status(404).json({ message: "Không tìm thấy Slider!" });
        }

        const fileFields = ['img1', 'img2', 'img3', 'img4'];

        fileFields.forEach(field => {
            const newFile = req.files?.[field]?.[0];
            const isClearRequest = req.body?.[field] === '';

            if (newFile) {
                //Nếu có file mới: xóa file cũ nếu có, cập nhật file mới
                if (slider[field]) {
                    const oldPath = path.join(sliderDir, path.basename(slider[field]));
                    if (fs.existsSync(oldPath)) {
                        fs.unlinkSync(oldPath);
                    }
                }
                slider[field] = `/slider/${newFile.filename}`;
            } else if (isClearRequest) {
                //Nếu người dùng gửi rỗng: xóa file cũ và cập nhật DB = null
                if (slider[field]) {
                    const oldPath = path.join(sliderDir, path.basename(slider[field]));
                    if (fs.existsSync(oldPath)) {
                        fs.unlinkSync(oldPath);
                    }
                }
                slider[field] = null;
            }
        });

        await slider.save();
        res.status(200).json({ message: "Slider đã được cập nhật!", slider });
    } catch (error) {
        console.error("Lỗi cập nhật slider:", error);
        res.status(500).json({ message: "Lỗi khi cập nhật Slider", error });
    }
});

// API lấy danh sách đánh giá
router.get("/admin/ratings", async (req, res) => {
    try {
        const ratings = await rating.findAll();
        res.json(ratings);
    } catch (error) {
        res.status(500).json({ message: "Lỗi khi lấy danh sách sách", error });
    }
});

// API Lấy danh sách khách hàng cho admin
router.get('/users', async (req, res) => {
    try {
        const users = await User.findAll();
        res.status(200).json(users);
    } catch (error) {
        console.error("Lỗi khi lấy danh sách người dùng:", error);
        res.status(500).json({ message: "Lỗi khi lấy danh sách người dùng", error });
    }
});

// API xóa khách hàng
router.delete("/admin/users/:id", async (req, res) => {
    try {
        const userID = req.params.id;

        const users = await User.findByPk(userID);
        if (!users) {
            return res.status(404).json({ message: "Không tìm thấy người dùng" });
        }

        await users.destroy();
        res.status(200).json({ message: "Người dùng đã được xóa thành công!" });
    } catch (error) {
        console.error("Lỗi khi xóa người dùng:", error);
        res.status(500).json({ message: "Lỗi khi xóa người dùng", error });
    }
});

// API ghi nhận lượt truy cập
router.post("/admin/track-view", async (req, res) => {
    try {
        await PageView.create({
            user_ip: req.ip,
            user_agent: req.headers['user-agent'],
            page_url: req.body.page_url,
        });
        res.status(201).json({ message: "Ghi nhận lượt truy cập" });
    } catch (error) {
        res.status(500).json({ message: "Lỗi ghi nhận lượt truy cập", error });
    }
});


// API lấy tổng số lượt truy cập
router.get("/admin/total-views", async (req, res) => {
    try {
        const count = await PageView.count();
        res.json({ totalViews: count });
    } catch (error) {
        res.status(500).json({ message: "Lỗi lấy tổng số lượt truy cập", error });
    }
});

module.exports = router;



/**
 * @swagger
 * tags:
 *   - name: Slider
 *     description: Các API liên quan đến Slider
 */

/**
 * @swagger
 * /slider:
 *   get:
 *     summary: Lấy danh sách Slider
 *     tags: [Slider]
 *     responses:
 *       200:
 *         description: Danh sách slider
 *       500:
 *         description: Lỗi khi lấy danh sách slider
 */
router.get('/slider', async (req, res) => {
    // Đoạn mã xử lý lấy danh sách slider
});

/**
 * @swagger
 * /admin/slider:
 *   put:
 *     summary: Cập nhật Slider
 *     tags: [Slider]
 *     requestBody:
 *       required: true
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             properties:
 *               img1:
 *                 type: string
 *                 format: binary
 *               img2:
 *                 type: string
 *                 format: binary
 *               img3:
 *                 type: string
 *                 format: binary
 *               img4:
 *                 type: string
 *                 format: binary
 *     responses:
 *       200:
 *         description: Slider đã được cập nhật thành công
 *       404:
 *         description: Không tìm thấy Slider
 *       500:
 *         description: Lỗi khi cập nhật Slider
 */
router.put("/admin/slider", upload.fields([
    { name: 'img1', maxCount: 1 },
    { name: 'img2', maxCount: 1 },
    { name: 'img3', maxCount: 1 },
    { name: 'img4', maxCount: 1 }
]), async (req, res) => {
    // Đoạn mã xử lý cập nhật slider
});

/**
 * @swagger
 * tags:
 *   - name: Rating
 *     description: Các API liên quan đến đánh giá
 */

/**
 * @swagger
 * /admin/ratings:
 *   get:
 *     summary: Lấy danh sách đánh giá
 *     tags: [Rating]
 *     responses:
 *       200:
 *         description: Danh sách đánh giá
 *       500:
 *         description: Lỗi khi lấy danh sách đánh giá
 */
router.get("/admin/ratings", async (req, res) => {
    // Đoạn mã xử lý lấy danh sách đánh giá
});

/**
 * @swagger
 * tags:
 *   - name: User
 *     description: Các API liên quan đến người dùng
 */

/**
 * @swagger
 * /users:
 *   get:
 *     summary: Lấy danh sách khách hàng
 *     tags: [User]
 *     responses:
 *       200:
 *         description: Danh sách khách hàng
 *       500:
 *         description: Lỗi khi lấy danh sách người dùng
 */
router.get('/users', async (req, res) => {
    // Đoạn mã xử lý lấy danh sách người dùng
});

/**
 * @swagger
 * /admin/users/{id}:
 *   delete:
 *     summary: Xóa người dùng theo ID
 *     tags: [User]
 *     parameters:
 *       - name: id
 *         in: path
 *         description: ID của người dùng
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Người dùng đã được xóa thành công
 *       404:
 *         description: Không tìm thấy người dùng
 *       500:
 *         description: Lỗi khi xóa người dùng
 */
router.delete("/admin/users/:id", async (req, res) => {
    // Đoạn mã xử lý xóa người dùng
});

/**
 * @swagger
 * tags:
 *   - name: Admin
 *     description: Các API liên quan đến quản trị viên
 */

/**
 * @swagger
 * /admin/track-view:
 *   post:
 *     summary: Ghi nhận lượt truy cập
 *     tags: [Admin]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               page_url:
 *                 type: string
 *     responses:
 *       201:
 *         description: Ghi nhận lượt truy cập thành công
 *       500:
 *         description: Lỗi ghi nhận lượt truy cập
 */
router.post("/admin/track-view", async (req, res) => {
    // Đoạn mã xử lý ghi nhận lượt truy cập
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
 *         description: Lỗi khi lấy tổng số lượt truy cập
 */
router.get("/admin/total-views", async (req, res) => {
    // Đoạn mã xử lý lấy tổng lượt truy cập
});
