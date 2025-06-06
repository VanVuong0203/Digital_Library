import axios from "axios";

const API_URL = "http://localhost:8080";

// Lấy danh sách sách
export const getBooks = () => axios.get(`${API_URL}/books`);

// Lấy thông tin sách theo ID
export const getBookById = (id) => axios.get(`${API_URL}/books/${id}`);

// Xóa sách theo ID
export const deleteBook = (id) => axios.delete(`${API_URL}/admin/books/${id}`);

// Lấy danh sách người dùng (Admin)
export const getUsers = () => axios.get(`${API_URL}/admin/users`);

// Xóa người dùng theo ID
export const deleteUser = (id) => axios.delete(`${API_URL}/api/admin/users/${id}`);

// Thêm sách mới
export const addBook = (data) => {
    return axios.post(`${API_URL}/admin/books`, data);
};

// Cập nhật sách
export const updateBook = (id, book) => {
    const formData = new FormData();

    formData.append("title", book.title);
    formData.append("author", book.author);
    formData.append("genre", book.genre);
    formData.append("published_year", book.published_year);
    formData.append("description", book.description);
    formData.append('epub', book.content);

    if (book.imgs instanceof File) {
        formData.append("imgs", book.imgs);
    }

    return axios.put(`${API_URL}/admin/books/${id}`, formData, {
        headers: {
            "Content-Type": "multipart/form-data",
        },
    });
};
// Gửi đánh giá
export const submitRating = (bookId, ratingData) => {
    return axios.post(`${API_URL}/api/book/${bookId}`, ratingData);
};

// Lấy đánh giá theo ID sách
export const getRatingsByBookId = (bookId) => {
    return axios.get(`${API_URL}/api/book/${bookId}`);
};

//lấy tất cả đánh giá
export const getAllRatings = () => {
    return axios.get(`${API_URL}/api/admin/ratings`);
};

// Xóa đánh giá theo ID
export const deleteRating = (id) => axios.delete(`${API_URL}/api/admin/ratings/${id}`);

//api lấy slider
export const fetchSlider = () => {
    return axios.get(`${API_URL}/api/slider`);
}

//api cập nhật slider
export const updateSlider = (payload) => {
    return axios.put(`${API_URL}/api/admin/slider`, payload);
}

// Lấy tổng lượt truy cập
export const getTotalViews = () => {
    return axios.get(`${API_URL}/api/admin/total-views`);
};

// API để lấy sách đọc nhiều nhất
export const getTopBooks = () => axios.get(`${API_URL}/admin/top-books`);


// API lấy dữ liệu Pie Chart
export const getPieData = () => axios.get(`${API_URL}/admin/pie-data`);

//api lấy lượt đọc sách theo id
export const getReadBookId = (bookId) => axios.get(`${API_URL}/admin/readbook/${bookId}`);

// Tăng lượt đọc sách theo ID
export const increaseReadCount = (bookId) => {
    return axios.post(`${API_URL}/admin/readbook/${bookId}`)
        .then(response => {
            // Xử lý kết quả trả về nếu thành công
            console.log("Lượt đọc sách đã được cập nhật:", response.data);
            return response.data;
        })
        .catch(error => {
            // Xử lý lỗi khi gọi API
            console.error("Có lỗi khi tăng lượt đọc sách:", error);
            throw error;
        });
};

//AUDIO BOOK APIs 

// Lấy danh sách sách nói
export const getAudioBooks = () => axios.get(`${API_URL}/audio-books`);

// Thêm sách nói mới
export const addAudioBook = (data) => axios.post(`${API_URL}/audio-books`, data);

// Xóa sách nói theo ID
export const deleteAudioBook = (id) => axios.delete(`${API_URL}/audio-books/${id}`);

// Lấy sách nói theo ID
export const getAudioBookById = (id) => axios.get(`${API_URL}/audio-books/${id}`);

// Cập nhật sách nói
export const updateAudioBook = (id, data) => axios.put(`${API_URL}/audio-books/${id}`, data);
