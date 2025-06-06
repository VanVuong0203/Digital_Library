import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';
import reportWebVitals from './reportWebVitals';
import "./assets/styles/global.css";
import { Bounce, ToastContainer } from 'react-toastify';


const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <>
    <App />
    <ToastContainer
      position="bottom-right"
      autoClose={3000}
      hideProgressBar={false}
      newestOnTop={false}
      closeOnClick={false}
      rtl={false}
      pauseOnFocusLoss={false}
      draggable
      pauseOnHover={false}
      theme="light"
      transition={Bounce}
    />
  </>
);
reportWebVitals();


if (process.env.NODE_ENV === 'development') {
  const originalConsoleWarn = console.warn;
  console.warn = (...args) => {
    if (args[0] && args[0].includes('ResizeObserver loop completed with undelivered notifications')) {
      return;  // Bỏ qua cảnh báo này
    }
    originalConsoleWarn(...args);
  };
}

const resizeObserver = new ResizeObserver((entries) => {
  // Trì hoãn xử lý các thay đổi kích thước với requestAnimationFrame
  requestAnimationFrame(() => {
    entries.forEach(entry => {
      // Xử lý thay đổi kích thước ở đây
      console.log(entry.target, entry.contentRect);
    });
  });
});

const element = document.querySelector('#elementToObserve');
if (element) {
  resizeObserver.observe(element);
}

