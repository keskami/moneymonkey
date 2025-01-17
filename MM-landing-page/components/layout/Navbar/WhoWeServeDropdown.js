import React from 'react';
import Link from 'next/link';
import { motion, AnimatePresence } from 'framer-motion';
import styles from './EcosystemDropdown.module.css';

const WhoWeServeDropdown = ({ isOpen }) => {
  const menuItems = [
    {
      icon: '/icons/high-school.svg',
      title: 'K-12 Schools',
      description: 'Interactive financial literacy tools aligned with K-12 education.',
      link: '/WhoWeServe/k-12-schools'
    },
    {
      icon: '/icons/college.svg',
      title: 'Colleges and Universities',
      description: 'Personalized platforms to build real-world financial skills on campus.',
      link: '/WhoWeServe/college'
    },
    {
      icon: '/icons/bank.svg',
      title: 'Banks',
      description: 'Helping financial institutions enhance community outreach and engagement.',
      link: '/WhoWeServe/bank'
    },
  ];

  return (
    <AnimatePresence>
      {isOpen && (
        <motion.div 
          className={styles.dropdownContainer}
          initial={{ opacity: 0, y: -10 }}
          animate={{ opacity: 1, y: 0 }}
          exit={{ opacity: 0, y: -10 }}
          transition={{ duration: 0.2 }}
        >
          <div className={styles.dropdownContent}>
            <div className={styles.menuGrid}>
              {menuItems.map((item, index) => (
                <Link href={item.link} key={item.title} className={styles.cardLink}>
                  <motion.div
                    className={styles.menuCard}
                    initial={{ opacity: 0, y: 10 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ 
                      duration: 0.2,
                      delay: index * 0.05
                    }}
                  >
                    <div className={styles.iconContainer}>
                      <img src={item.icon} alt={item.title} className={styles.icon} />
                    </div>
                    <h3 className={styles.cardTitle}>{item.title}</h3>
                    <p className={styles.cardDescription}>{item.description}</p>
                  </motion.div>
                </Link>
              ))}
            </div>
          </div>
        </motion.div>
      )}
    </AnimatePresence>
  );
};

export default WhoWeServeDropdown;