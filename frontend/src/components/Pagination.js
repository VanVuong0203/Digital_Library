// src/components/Pagination.js
import React, { useEffect } from "react";
import "../assets/styles/Pagination.css";

const Pagination = ({ items, currentPage, itemsPerPage, onPageChange, renderItems }) => {
    const totalPages = Math.ceil(items.length / itemsPerPage);

    useEffect(() => {
        if (currentPage > totalPages && totalPages > 0) {
            onPageChange(totalPages);
        }
    }, [items, currentPage, totalPages, onPageChange]);

    const indexOfLastItem = currentPage * itemsPerPage;
    const indexOfFirstItem = indexOfLastItem - itemsPerPage;
    const currentItems = items.slice(indexOfFirstItem, indexOfLastItem);

    const generatePages = () => {
        const pages = [];

        for (let i = 1; i <= totalPages; i++) {
            if (
                i === 1 ||
                i === totalPages ||
                (i >= currentPage - 2 && i <= currentPage + 2)
            ) {
                pages.push(i);
            }
        }

        return pages;
    };

    const pages = generatePages();

    return (
        <>
            {renderItems(currentItems)}

            <div className="pagination">
                {currentPage > 1 && (
                    <button className="pagination-btn" onClick={() => onPageChange(currentPage - 1)}>
                        «
                    </button>
                )}

                {pages.map((page, index) => {
                    const prevPage = pages[index - 1];
                    const isGap = index > 0 && page - prevPage > 1;
                    return (
                        <React.Fragment key={page}>
                            {isGap && <span className="pagination-ellipsis">...</span>}
                            <button
                                className={`pagination-btn ${currentPage === page ? "active" : ""}`}
                                onClick={() => onPageChange(page)}
                            >
                                {page}
                            </button>
                        </React.Fragment>
                    );
                })}

                {currentPage < totalPages && (
                    <button className="pagination-btn" onClick={() => onPageChange(currentPage + 1)}>
                        »
                    </button>
                )}
            </div>
        </>
    );
};

export default Pagination;
