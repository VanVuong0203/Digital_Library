import React from "react";
import Header from "../components/Header";
import Footer from "../components/Footer";
import Slidebar from "../components/Slidebar";

import "../assets/styles/Layout.css";
import "../assets/styles/Footer.css";
import { Outlet, useLocation } from "react-router-dom";
import Sliders from "../components/Sliders";



const MainLayout = (props) => {
    const location = useLocation();
    const { searchQuery, setSearchQuery } = props;

    const hideSidebarAndFooter =
        location.pathname.startsWith("/books/read/") ||
        location.pathname === "/login" ||
        location.pathname === "/register";

    return (
        <div style={{
            display: "flex",
            flexDirection: "column",
            flex: "1 1 auto"
        }}>
            {!location.pathname.startsWith("/books/read/") && (
                <Header searchQuery={searchQuery} setSearchQuery={setSearchQuery} />
            )}
            <main className="wrapper">
                {!hideSidebarAndFooter && <Slidebar />}
                <div className="wrapper_inner" >
                    {location.pathname === "/" && <Sliders />}
                    <Outlet />
                </div>
            </main>

            {/* <main className="wrapper" style={{ display: "flex" }}>

                <div className="wrapper_inner" style={{ marginLeft: hideSidebarAndFooter ? "0" : "260px" }}>

                  
                </div>
            </main> */}

            {!hideSidebarAndFooter && <Footer />}
        </div >
    );
};



export default MainLayout;
