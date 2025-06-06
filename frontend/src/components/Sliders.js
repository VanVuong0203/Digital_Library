import React, { useEffect, useState, useCallback } from "react";
import "../assets/styles/Slideshow.css";
import { motion, AnimatePresence } from "framer-motion";
import { ChevronLeft, ChevronRight } from "lucide-react";
import { fetchSlider } from "../services/api";

const Sliders = () => {
    const [currentIndex, setCurrentIndex] = useState(0);
    const [sliderData, setSliderData] = useState([]);

    useEffect(() => {
        const getSliderData = async () => {
            try {
                const response = await fetchSlider();
                const data = response.data[0];
                const slides = [];

                ['img1', 'img2', 'img3', 'img4'].forEach((key, index) => {
                    if (data[key]) {
                        slides.push({
                            id: index,
                            src: data[key],
                            alt: `Slide ${index + 1}`
                        });
                    }
                });

                setSliderData(slides);
            } catch (error) {
                console.error("Lỗi khi tải slider:", error);
            }
        };

        getSliderData();
    }, []);

    const nextSlide = useCallback(() => {
        setCurrentIndex((prev) => (prev + 1) % sliderData.length);
    }, [sliderData.length]);

    const prevSlide = () => {
        setCurrentIndex((prev) => (prev - 1 + sliderData.length) % sliderData.length);
    };

    useEffect(() => {
        const interval = setInterval(nextSlide, 5000);
        return () => clearInterval(interval);
    }, [nextSlide]);

    if (sliderData.length === 0) return null;

    return (
        <div className="slideshow">
            <div className="slideshow-container">
                <AnimatePresence mode="wait">
                    <motion.img
                        key={sliderData[currentIndex].id}
                        src={sliderData[currentIndex].src}
                        alt={sliderData[currentIndex].alt}
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
                {sliderData.map((_, i) => (
                    <span key={i} className={`dot ${currentIndex === i ? "active" : ""}`} />
                ))}
            </div>
        </div>
    );
};

export default Sliders;
