import { useState } from 'react';
import styles from './Navbar.module.css';
import EcosystemDropdown from './Navbar/EcosystemDropdown';

export default function Navbar() {
    const [menuOpen, setMenuOpen] = useState(false);
    const [ecosystemOpen, setEcosystemOpen] = useState(false);

    const toggleMenu = () => {
        setMenuOpen(!menuOpen);
    };

    const closeMenu = () => {
        setMenuOpen(false);
    };
    

    return (
        <nav className={styles.navbar}>
            <div className={styles.logo}>
                <img src="/logo.png" alt="Money Monkey Logo" />
            </div>

            <ul className={styles.desktopNav}>
                <li 
                    onMouseEnter={() => setEcosystemOpen(true)}
                    onMouseLeave={() => setEcosystemOpen(false)}
                >
                    <a href="/ecosystem">Ecosystem</a>
                    <EcosystemDropdown isOpen={ecosystemOpen} />
                </li>
                <li><a href="/usecases">Use Cases</a></li>
                <li><a href="/pricing">Pricing</a></li>
                <li><a href="/company">Company</a></li>
            </ul>

            {/* Right-Aligned Register and Login Links */}
            <div className={styles.desktopNavRegister}>
                <a href="/register">Register</a>
                <a href="/login" className={styles.loginButton}>Login</a>
            </div>

            {/* Mobile Hamburger */}
            <div className={styles.hamburger} onClick={toggleMenu}>
                <div className={styles.line}></div>
                <div className={styles.line}></div>
                <div className={styles.line}></div>
            </div>

            {/* Mobile Overlay Menu */}
            {menuOpen && (
                <div className={styles.overlay} onClick={closeMenu}>
                    <ul
                        className={styles.mobileNav}
                        onClick={(e) => e.stopPropagation()} // Prevent closing when clicking inside the menu
                    >
                        <li><a href="/ecosystem">Ecosystem</a></li>
                        <li><a href="/usecases">Use Cases</a></li>
                        <li><a href="/pricing">Pricing</a></li>
                        <li><a href="/company">Company</a></li>
                        <li><a href="/register">Register</a></li>
                        <li><a href="/login">Login</a></li>
                    </ul>
                </div>
            )}
        </nav>
    );
}
