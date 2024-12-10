import React from 'react';
import Link from 'next/link';
import { motion, AnimatePresence } from 'framer-motion';
import styles from './EcosystemDropdown.module.css';

const EcosystemDropdown = ({ isOpen }) => {
  const menuItems = [
    {
      icon: '/icons/book.svg',
      title: 'Courses',
      description: 'Standards-aligned curriculum and learning content. Application-based learning.',
      link: '/courses'
    },
    {
      icon: '/icons/teacher.svg',
      title: 'Teacher/Parent Tools',
      description: 'Leverage AI and dashboards to personalize the assessment process and develop curriculum.',
      link: '/assessment-tools'
    },
    {
      icon: '/icons/parent.svg',
      title: 'Teaching Supplements',
      description: 'Enhance your course with lesson plans, presentations, certificates, and other resources.',
      link: '/teaching-supplements'
    },
    {
      icon: '/icons/stocks.svg',
      title: 'Stock Market Simulator',
      description: 'Make fake trades on 500+ global exchanges. Teaching core principles for long term wealth.',
      link: '/stock-simulator'
    },
    {
      icon: '/icons/budget.svg',
      title: 'Personal Budget Simulator',
      description: 'Create budgets, make informed financial choices, and build essential consumer skills.',
      link: '/budget-simulator'
    },
    {
      icon: '/icons/savings.svg',
      title: 'Credit/Debt Simulator',
      description: 'Build credit, manage loans, and explore the impact of interest rates in a risk-free environment.',
      link: '/credit-simulator'
    }
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

export default EcosystemDropdown;