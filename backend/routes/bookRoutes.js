const express = require("express");
const router = express.Router();
const Book = require("../models/Book");
const BookView = require("../models/BookView");
const AudioBook = require("../models/AudioBook");
const multer = require("multer");
const path = require("path");
const fs = require("fs");

const bookContentDir = "D:/DuAnFPT/LibraryApp/frontend/public/books_content";
const bookImagesDir = "D:/DuAnFPT/LibraryApp/frontend/public/images/books";


// Tạo thư mục nếu không tồn tại
if (!fs.existsSync(bookContentDir)) fs.mkdirSync(bookContentDir, { recursive: true });
if (!fs.existsSync(bookImagesDir)) fs.mkdirSync(bookImagesDir, { recursive: true });

// Cấu hình multer để lưu file EPUB
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        if (file.mimetype === "application/epub+zip" || file.mimetype === "application/epub" || file.mimetype === "application/octet-stream") {
            cb(null, bookContentDir);
        } else if (file.mimetype.startsWith("image/")) {
            cb(null, bookImagesDir);
        } else {
            cb(new Error("Chỉ chấp nhận file EPUB hoặc ảnh!"), false);
        }
    },
    filename: (req, file, cb) => {
        cb(null, file.originalname);
    }
});
const upload = multer({ storage });

// API lấy danh sách sách
router.get("/books", async (req, res) => {
    try {
        const books = await Book.findAll();
        res.json(books);
    } catch (error) {
        res.status(500).json({ message: "Lỗi khi lấy danh sách sách", error });
    }
});

//API lấy chi tiết sách
router.get("/books/:id", async (req, res) => {
    try {
        const { id } = req.params;
        const book = await Book.findByPk(id);
        if (!book) {
            return res.status(404).json({ message: "Không tìm thấy sách!" });
        }

        let bookView = await BookView.findOne({ where: { book_id: id } });

        if (!bookView) {
            await BookView.create({ book_id: id, view_count: 1 });
        } else {
            await BookView.increment("view_count", { by: 1, where: { book_id: id } });
        }

        res.status(200).json({ book, epubPath: book.content_path });
    } catch (error) {
        console.error("Lỗi khi lấy thông tin sách:", error);
        res.status(500).json({ message: "Lỗi khi lấy thông tin sách", error });
    }
});


// API thêm sách
router.post("/admin/books", upload.fields([{ name: "epub" }, { name: "imgs" }]), async (req, res) => {
    try {
        const { title, author, genre, published_year, description } = req.body;

        if (!req.files || !req.files["epub"]) {
            return res.status(400).json({ message: "Thiếu file EPUB" });
        }

        const epubPath = `/books_content/${req.files["epub"][0].filename}`;
        const imgPath = req.files["imgs"] ? `/images/books/${req.files["imgs"][0].filename}` : null;

        const newBook = await Book.create({
            title,
            author,
            genre,
            published_year,
            description,
            content_path: epubPath,
            imgs: imgPath
        });

        res.status(201).json({ message: "Sách đã được thêm thành công!", newBook });
    } catch (error) {
        console.error("Lỗi khi thêm sách:", error);
        res.status(500).json({ message: "Lỗi khi thêm sách", error });
    }
});


// API cập nhật sách
router.put("/admin/books/:id", upload.fields([{ name: "epub", maxCount: 1 }, { name: "imgs", maxCount: 1 }]), async (req, res) => {
    try {
        const { id } = req.params;
        const { title, author, genre, published_year, description } = req.body;
        const book = await Book.findByPk(id);

        if (!book) {
            return res.status(404).json({ message: "Không tìm thấy sách!" });
        }

        // Nếu có EPUB mới => xóa EPUB cũ
        if (req.files && req.files["epub"]) {
            const oldEpubPath = path.join(bookContentDir, path.basename(book.content_path));
            if (fs.existsSync(oldEpubPath)) {
                fs.unlinkSync(oldEpubPath);
            }
            book.content_path = `/books_content/${req.files["epub"][0].filename}`;
        }

        // Nếu có ảnh mới => xóa ảnh cũ
        if (req.files && req.files["imgs"]) {
            if (book.imgs) {
                const oldImgPath = path.join(bookImagesDir, path.basename(book.imgs));
                if (fs.existsSync(oldImgPath)) {
                    fs.unlinkSync(oldImgPath);
                }
            }
            book.imgs = `/images/books/${req.files["imgs"][0].filename}`;
        }

        book.title = title;
        book.author = author;
        book.genre = genre;
        book.published_year = published_year;
        book.description = description;

        await book.save();
        res.status(200).json({ message: "Sách đã được cập nhật!", book });
    } catch (error) {
        console.error("Lỗi khi cập nhật sách:", error);
        res.status(500).json({ message: "Lỗi khi cập nhật sách", error });
    }
});


// API xóa sách
router.delete("/admin/books/:id", async (req, res) => {
    try {
        const { id } = req.params;
        const book = await Book.findByPk(id);
        if (!book) {
            return res.status(404).json({ message: "Không tìm thấy sách" });
        }

        if (book.content_path) {
            const bookFilePath = path.join(bookContentDir, path.basename(book.content_path));
            if (fs.existsSync(bookFilePath)) {
                fs.unlinkSync(bookFilePath);
            }
        }

        await book.destroy();
        res.status(200).json({ message: "Sách đã được xóa thành công!" });
    } catch (error) {
        res.status(500).json({ message: "Lỗi khi xóa sách", error });
    }
});

//API lấy sách đọc nhiều nhất
router.get("/admin/top-books", async (req, res) => {
    try {
        // Lấy danh sách sách và sắp xếp theo view_count giảm dần
        const topBooks = await BookView.findAll({
            order: [['read_count', 'DESC']],
            limit: 3, // Lấy 3 sách đọc nhiều nhất
            include: [
                {
                    model: Book,
                    attributes: ['id', 'title']
                }
            ]
        });

        if (!topBooks) {
            return res.status(404).json({ message: "Không có sách nào!" });
        }

        res.status(200).json(topBooks);
    } catch (error) {
        console.error("Lỗi khi lấy sách đọc nhiều nhất:", error);
        res.status(500).json({ message: "Lỗi khi lấy sách đọc nhiều nhất", error });
    }
});

// API lấy dữ liệu biểu đồ Pie (top 4 sách có lượt xem nhiều nhất)
router.get("/admin/pie-data", async (req, res) => {
    try {
        const bookViews = await BookView.findAll({
            include: [{
                model: Book,
                attributes: ['title']
            }],
            order: [['read_count', 'DESC']]
        });

        // Lấy top 4 cuốn sách có lượt xem nhiều nhất
        const topBooks = bookViews.slice(0, 4);

        // Tính tổng số lượt xem của 4 cuốn đó
        const totalTopViews = topBooks.reduce((sum, bookView) => sum + bookView.read_count, 0);

        // Tính tỷ lệ phần trăm cho mỗi sách trong top 4
        const pieData = topBooks.map(bookView => ({
            name: bookView.Book ? bookView.Book.title : 'Không có tên sách',
            value: totalTopViews > 0 ? ((bookView.read_count / totalTopViews) * 100).toFixed(2) : 0
        }));

        res.status(200).json(pieData);
    } catch (error) {
        console.error("Lỗi khi lấy dữ liệu biểu đồ:", error);
        res.status(500).json({ message: "Lỗi khi lấy dữ liệu biểu đồ", error });
    }
});

// API lấy lượt đọc sách theo id sách
router.get("/admin/readbook/:bookId", async (req, res) => {
    const { bookId } = req.params;
    try {
        const bookView = await BookView.findOne({
            where: { book_id: bookId }
        });

        if (!bookView) {
            return res.status(404).json({ message: "Không tìm thấy lượt đọc cho sách này." });
        }

        res.json({
            book_id: bookView.book_id,
            read_count: bookView.read_count
        });
    } catch (error) {
        console.error("Lỗi khi lấy lượt đọc:", error);
        res.status(500).json({ message: "Lỗi server", error });
    }
});

// Tăng lượt đọc sách theo ID
router.post("/admin/readbook/:id", async (req, res) => {
    try {
        const { id } = req.params;
        let bookView = await BookView.findOne({ where: { book_id: id } });

        if (!bookView) {
            bookView = await BookView.create({ book_id: id, read_count: 1 });
        } else {
            await BookView.increment("read_count", { by: 1, where: { book_id: id } });
        }

        res.status(200).json({ message: "Đã cập nhật lượt đọc", read_count: bookView.read_count });
    } catch (error) {
        console.error("Lỗi khi cập nhật lượt đọc:", error);
        res.status(500).json({ message: "Lỗi khi cập nhật lượt đọc", error });
    }
});


// Lấy tất cả sách nói
router.get("/audio-books", async (req, res) => {
    try {
        const audioBooks = await AudioBook.findAll();
        res.json(audioBooks);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Lấy chi tiết sách nói theo ID
router.get("/audio-books/:id", async (req, res) => {
    try {
        const { id } = req.params;
        const audioBook = await AudioBook.findByPk(id);

        if (!audioBook) {
            return res.status(404).json({ message: "Không tìm thấy sách nói!" });
        }

        res.status(200).json(audioBook);
    } catch (error) {
        console.error("Lỗi khi lấy chi tiết sách nói:", error);
        res.status(500).json({ message: "Lỗi server", error });
    }
});


// Thêm sách nói mới
router.post("/audio-books", async (req, res) => {
    try {
        const { title, author, audio_url, cover_image, description } = req.body;
        const newBook = await AudioBook.create({ title, author, audio_url, cover_image, description });
        res.status(201).json(newBook);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
});



module.exports = router;


/**
 * @swagger
 * tags:
 *   - name: Books
 *     description: Các API liên quan đến sách
 */

/**
 * @swagger
 * /books:
 *   get:
 *     summary: Lấy danh sách sách
 *     tags: [Books]
 *     responses:
 *       200:
 *         description: Danh sách sách
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: object
 *                 properties:
 *                   id:
 *                     type: integer
 *                   title:
 *                     type: string
 *                   author:
 *                     type: string
 *                   genre:
 *                     type: string
 *                   published_year:
 *                     type: integer
 *                   description:
 *                     type: string
 *       500:
 *         description: Lỗi khi lấy danh sách sách
 */

/**
 * @swagger
 * /books/{id}:
 *   get:
 *     summary: Lấy chi tiết sách theo ID
 *     tags: [Books]
 *     parameters:
 *       - name: id
 *         in: path
 *         description: ID của sách
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Chi tiết sách
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 id:
 *                   type: integer
 *                 title:
 *                   type: string
 *                 author:
 *                   type: string
 *                 genre:
 *                   type: string
 *                 published_year:
 *                   type: integer
 *                 description:
 *                   type: string
 *                 content_path:
 *                   type: string
 *       404:
 *         description: Không tìm thấy sách
 *       500:
 *         description: Lỗi khi lấy thông tin sách
 */

/**
 * @swagger
 * /admin/books:
 *   post:
 *     summary: Thêm sách mới
 *     tags: [Books]
 *     requestBody:
 *       required: true
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             properties:
 *               title:
 *                 type: string
 *               author:
 *                 type: string
 *               genre:
 *                 type: string
 *               published_year:
 *                 type: integer
 *               description:
 *                 type: string
 *               epub:
 *                 type: string
 *                 format: binary
 *               imgs:
 *                 type: string
 *                 format: binary
 *     responses:
 *       201:
 *         description: Sách đã được thêm thành công
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                 newBook:
 *                   type: object
 *                   properties:
 *                     id:
 *                       type: integer
 *                     title:
 *                       type: string
 *                     author:
 *                       type: string
 *                     genre:
 *                       type: string
 *                     published_year:
 *                       type: integer
 *                     description:
 *                       type: string
 *                     content_path:
 *                       type: string
 *                     imgs:
 *                       type: string
 *       400:
 *         description: Thiếu file EPUB
 *       500:
 *         description: Lỗi khi thêm sách
 */

/**
 * @swagger
 * /admin/books/{id}:
 *   put:
 *     summary: Cập nhật sách theo ID
 *     tags: [Books]
 *     parameters:
 *       - name: id
 *         in: path
 *         description: ID của sách
 *         required: true
 *         schema:
 *           type: integer
 *     requestBody:
 *       required: true
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             properties:
 *               title:
 *                 type: string
 *               author:
 *                 type: string
 *               genre:
 *                 type: string
 *               published_year:
 *                 type: integer
 *               description:
 *                 type: string
 *               epub:
 *                 type: string
 *                 format: binary
 *               imgs:
 *                 type: string
 *                 format: binary
 *     responses:
 *       200:
 *         description: Sách đã được cập nhật
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                 book:
 *                   type: object
 *                   properties:
 *                     id:
 *                       type: integer
 *                     title:
 *                       type: string
 *                     author:
 *                       type: string
 *                     genre:
 *                       type: string
 *                     published_year:
 *                       type: integer
 *                     description:
 *                       type: string
 *                     content_path:
 *                       type: string
 *                     imgs:
 *                       type: string
 *       404:
 *         description: Không tìm thấy sách
 *       500:
 *         description: Lỗi khi cập nhật sách
 */

/**
 * @swagger
 * /admin/books/{id}:
 *   delete:
 *     summary: Xóa sách theo ID
 *     tags: [Books]
 *     parameters:
 *       - name: id
 *         in: path
 *         description: ID của sách
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Sách đã được xóa thành công
 *       404:
 *         description: Không tìm thấy sách
 *       500:
 *         description: Lỗi khi xóa sách
 */

/**
 * @swagger
 * /admin/top-books:
 *   get:
 *     summary: Lấy sách đọc nhiều nhất
 *     tags: [Books]
 *     responses:
 *       200:
 *         description: Danh sách sách đọc nhiều nhất
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: object
 *                 properties:
 *                   book:
 *                     type: object
 *                     properties:
 *                       id:
 *                         type: integer
 *                       title:
 *                         type: string
 *                   read_count:
 *                     type: integer
 *       404:
 *         description: Không có sách nào
 *       500:
 *         description: Lỗi khi lấy sách đọc nhiều nhất
 */

/**
 * @swagger
 * /admin/pie-data:
 *   get:
 *     summary: Lấy dữ liệu biểu đồ Pie (top 4 sách có lượt xem nhiều nhất)
 *     tags: [Books]
 *     responses:
 *       200:
 *         description: Dữ liệu biểu đồ Pie
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: object
 *                 properties:
 *                   name:
 *                     type: string
 *                   value:
 *                     type: number
 *       500:
 *         description: Lỗi khi lấy dữ liệu biểu đồ
 */

/**
 * @swagger
 * /admin/readbook/{bookId}:
 *   get:
 *     summary: Lấy lượt đọc sách theo ID sách
 *     tags: [Books]
 *     parameters:
 *       - name: bookId
 *         in: path
 *         description: ID của sách
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Lượt đọc của sách
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 book_id:
 *                   type: integer
 *                 read_count:
 *                   type: integer
 *       404:
 *         description: Không tìm thấy lượt đọc cho sách này
 *       500:
 *         description: Lỗi server
 */

/**
 * @swagger
 * /admin/readbook/{id}:
 *   post:
 *     summary: Tăng lượt đọc sách theo ID
 *     tags: [Books]
 *     parameters:
 *       - name: id
 *         in: path
 *         description: ID của sách
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Đã cập nhật lượt đọc
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                 read_count:
 *                   type: integer
 *       500:
 *         description: Lỗi khi cập nhật lượt đọc
 */

/**
 * @swagger
 * /audio-books:
 *   get:
 *     summary: Lấy tất cả sách nói
 *     tags: [AudioBooks]
 *     responses:
 *       200:
 *         description: Danh sách sách nói
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: object
 *       500:
 *         description: Lỗi khi lấy danh sách sách nói
 */

/**
 * @swagger
 * /audio-books/{id}:
 *   get:
 *     summary: Lấy chi tiết sách nói theo ID
 *     tags: [AudioBooks]
 *     parameters:
 *       - name: id
 *         in: path
 *         description: ID của sách nói
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Chi tiết sách nói
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 id:
 *                   type: integer
 *                 title:
 *                   type: string
 *                 author:
 *                   type: string
 *                 audio_url:
 *                   type: string
 *                 cover_image:
 *                   type: string
 *                 description:
 *                   type: string
 *       404:
 *         description: Không tìm thấy sách nói
 *       500:
 *         description: Lỗi server
 */

/**
 * @swagger
 * /audio-books:
 *   post:
 *     summary: Thêm sách nói mới
 *     tags: [AudioBooks]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               title:
 *                 type: string
 *               author:
 *                 type: string
 *               audio_url:
 *                 type: string
 *               cover_image:
 *                 type: string
 *               description:
 *                 type: string
 *     responses:
 *       201:
 *         description: Sách nói đã được thêm thành công
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 id:
 *                   type: integer
 *                 title:
 *                   type: string
 *                 author:
 *                   type: string
 *                 audio_url:
 *                   type: string
 *                 cover_image:
 *                   type: string
 *                 description:
 *                   type: string
 *       400:
 *         description: Lỗi khi thêm sách nói
 */

