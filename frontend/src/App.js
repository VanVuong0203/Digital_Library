import React, { useState } from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import MainLayout from "./layout/MainLayout";
import PrivateRoute from "./routes/PrivateRoute";
import AdminRoute from "./routes/AdminRoute";
import HomePage from "./pages/HomePage";
import BookListPage from "./pages/BookListPage";
import AdminBookManagementPage from "./pages/AdminBookManagementPage";
import AdminBookAudioManagementPage from "./pages/AdminBookAudioManagementPage";
import AdminRatingManagementPage from "./pages/AdminRatingManagementPage";
import AdminUserManagementPage from "./pages/AdminUserManagementPage";
import BookReadingPage from "./pages/BookReadingPage";
import ComicBooksPage from "./pages/ComicBooksPage";
import BookDetailPage from "./pages/BookDetailPage";
import Admin from "./pages/Admin";
import EditBookForm from "./pages/EditBookForm";
import AddBookForm from "./pages/AddBookForm";
import AuthPage from "./pages/AuthPage";
import AdminSlider from "./pages/AdminSlider";
import AdminPage from "./pages/AdminPage";
import AudioBooks from './pages/AudioBooks';
import ScrollToTop from "./components/ScrollToTop";
import AddAudioBookPage from "./pages/AddAudioBookPage";

function App() {
  const [searchQuery, setSearchQuery] = useState("");

  return (
    <Router>
      <ScrollToTop />

      <Routes>
        {/* Các route công khai */}
        <Route path="/" element={<MainLayout setSearchQuery={setSearchQuery} searchQuery={searchQuery} />} >
          <Route path="/" element={<HomePage />} />
          <Route path="/login" element={<AuthPage />} />
          <Route path="/register" element={<AuthPage />} />
          <Route path="/books" element={<BookListPage searchQuery={searchQuery} />} />
          <Route path="/books/:id" element={<BookDetailPage />} />
          <Route path="/books/comics" element={<ComicBooksPage searchQuery={{ title: "" }} />} />

          {/*Route chỉ cho người đã đăng nhập */}
          <Route element={<PrivateRoute />}>
            <Route path="/books/read/:id" element={<BookReadingPage />} />
            <Route path="/books/audio" element={<AudioBooks />} />
          </Route>
        </Route>

        {/*Route cho admin */}
        <Route path="/admin" element={<AdminRoute />}>
          <Route path="" element={<Admin />} >
            <Route path="" element={<AdminPage />} />
            <Route path="slider" element={<AdminSlider />} />
            <Route path="books" element={<AdminBookManagementPage />} />
            <Route path="audiobooks" element={<AdminBookAudioManagementPage />} />
            <Route path="users" element={<AdminUserManagementPage />} />
            <Route path="ratings" element={<AdminRatingManagementPage />} />
            <Route path="books/add" element={<AddBookForm />} />
            <Route path="books/addAudioBook" element={<AddAudioBookPage />} />
            <Route path="books/edit/:id" element={<EditBookForm />} />
          </Route>
        </Route>
      </Routes>
    </Router>

  );
}

export default App;
