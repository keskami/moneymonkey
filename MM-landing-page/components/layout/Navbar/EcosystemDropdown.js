import React from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import styles from './EcosystemDropdown.module.css';

const EcosystemDropdown = ({ isOpen }) => {
  const menuItems = [
    {
      icon: '/icons/book.svg',
      title: 'Courses',
      description: 'Standards-aligned curriculum and learning content. Complete flexibility.'
    },
    {
      icon: '/icons/teacher.svg',
      title: 'Assessment Tools',
      description: 'Leverage Generative AI to personalize the assessment process and data reports.'
    },
    {
      icon: '/icons/parent.svg',
      title: 'Teaching Supplements',
      description: 'Add lesson plans, presentations, certificates, and more to your course.'
    },
    {
      icon: '/icons/stocks.svg',
      title: 'Stock Market Simulator',
      description: 'Real data from 500+ global exchanges. Fake money, fake trades.'
    },
    {
      icon: '/icons/budget.svg',
      title: 'Personal Budget Simulator',
      description: 'Manage a budget, make financial decisions, and develop practical consumer skills.'
    },
    {
      icon: '/icons/savings.svg',
      title: 'Startup Simulator',
      description: 'Grow a startup from a small business to a major enterprise.'
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
                <motion.div
                  key={item.title}
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
              ))}
            </div>
          </div>
        </motion.div>
      )}
    </AnimatePresence>
  );
};

export default EcosystemDropdown;