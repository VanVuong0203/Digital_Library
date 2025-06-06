import React, { useEffect, useState } from "react";
import "../assets/styles/Slideshow.css";
import { motion, AnimatePresence } from "framer-motion";
import { ChevronLeft, ChevronRight } from "lucide-react";

const Slides = () => {
    const [currentIndex, setCurrentIndex] = useState(0);
    const slides = [
        { id: 1, src: "https://source.unsplash.com/800x400/?nature", alt: "Nature" },
        { id: 2, src: "https://source.unsplash.com/800x400/?city", alt: "City" },
        { id: 3, src: "https://source.unsplash.com/800x400/?technology", alt: "Technology" },
    ];

    useEffect(() => {
        const interval = setInterval(() => {
            nextSlide();
        }, 3000);
        return () => clearInterval(interval);
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, [currentIndex]);

    const nextSlide = () => setCurrentIndex((prev) => (prev + 1) % slides.length);
    const prevSlide = () => setCurrentIndex((prev) => (prev - 1 + slides.length) % slides.length);
    return (
        <div className="slideshow">
            <div className="slideshow-container">
                <AnimatePresence>
                    <motion.img
                        key={slides[currentIndex].id}
                        src={slides[currentIndex].src}
                        alt={slides[currentIndex].alt}
                        initial={{ opacity: 0, x: 50 }}
                        animate={{ opacity: 1, x: 0 }}
                        exit={{ opacity: 0, x: -50 }}
                        transition={{ duration: 0.5 }}
                        className="slide-image"
                    />
                </AnimatePresence>
            </div>

            <button className="slide-btn left" onClick={prevSlide}>
                <ChevronLeft size={24} />
            </button>
            <button className="slide-btn right" onClick={nextSlide}>
                <ChevronRight size={24} />
            </button>

            <div className="dots">
                {slides.map((_, i) => (
                    <span key={i} className={`dot ${currentIndex === i ? "active" : ""}`} />
                ))}
            </div>
        </div>
    );
};

export default Slides;
