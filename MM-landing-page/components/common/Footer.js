import Image from 'next/image';
import Link from 'next/link';
import styles from './Footer.module.css';

const Footer = () => {
  return (
    <footer className={styles.footer}>
      <div className={styles.container}>
        <div className={styles.grid}>
          {/* Logo and Address Section */}
          <div>
            <Image 
              src="/logo.png" 
              alt="Money Monkey Logo" 
              width={200}
              height={75}
              className={styles.logo}
            />
            <div className={styles.addressSection}>
              <p className={styles.label}>Address:</p>
              <p>4096 Brown Farm Dr</p>
              <p>Carmel, IN 46074</p>
              <div className={styles.contactInfo}>
                <p className={styles.label}>Contact:</p>
                <p>moneymonkeyinqueries@gmail.com</p>
              </div>
            </div>
          </div>

          {/* Navigation Sections */}
          <div className={styles.navigationGrid}>
            {/* Solutions Section */}
            <div className={styles.linksSection}>
              <h3 className={styles.sectionTitle}>Solutions</h3>
              <div className={styles.linkList}>
                <Link href="#" className={styles.link}>Courses</Link>
                <Link href="#" className={styles.link}>Assessment Tools</Link>
                <Link href="#" className={styles.link}>Stock Simulator</Link>
                <Link href="#" className={styles.link}>Budget Simulator</Link>
                <Link href="#" className={styles.link}>Credit Simulator</Link>
              </div>
            </div>

            {/* Use Cases Section */}
            <div className={styles.linksSection}>
              <h3 className={styles.sectionTitle}>Use Cases</h3>
              <div className={styles.linkList}>
                <Link href="#" className={styles.link}>K-12 Schools</Link>
                <Link href="#" className={styles.link}>Higher Education</Link>
                <Link href="#" className={styles.link}>Businesses</Link>
              </div>
            </div>

            {/* Resources Section */}
            <div className={styles.linksSection}>
              <h3 className={styles.sectionTitle}>Resources</h3>
              <div className={styles.linkList}>
                <Link href="#" className={styles.link}>Free Resource Library</Link>
                <Link href="#" className={styles.link}>Blog & Research</Link>
                <Link href="#" className={styles.link}>Professional Development</Link>
              </div>
            </div>

            {/* Company Section */}
            <div className={styles.linksSection}>
              <h3 className={styles.sectionTitle}>Company</h3>
              <div className={styles.linkList}>
                <Link href="#" className={styles.link}>About Us</Link>
                <Link href="#" className={styles.link}>Careers</Link>
                <Link href="#" className={styles.link}>Contact Us</Link>
                <Link href="#" className={styles.link}>Terms of Service</Link>
                <Link href="#" className={styles.link}>Privacy Policy</Link>
                <Link href="#" className={styles.link}>COPPA Policy</Link>
              </div>
            </div>
          </div>
        </div>

        {/* Copyright Section */}
        <div className={styles.copyright}>
          <p>© 2024 Money Monkey, LLC. All Rights Reserved.</p>
        </div>
      </div>
    </footer>
  );
};

export default Footer;