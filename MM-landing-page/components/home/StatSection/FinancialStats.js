import React from 'react';
import { motion, useInView, useAnimationControls } from 'framer-motion';
import { useRef, useEffect } from 'react';
import styles from './FinancialStats.module.css';

// Counter component for number animation
const AnimatedCounter = ({ value, isInView }) => {
  const controls = useAnimationControls();
  const numberRef = useRef(null);
  
  // Parse the value to handle different formats
  const parseValue = (val) => {
    if (val.includes('$')) {
      return parseFloat(val.replace('$', '').replace('T', ''));
    }
    return parseFloat(val.replace('%', ''));
  };

  // Format the value back to original string format
  const formatValue = (val, originalValue) => {
    if (originalValue.includes('$')) {
      return `$${val.toFixed(2)}T`;
    }
    return `${Math.round(val)}%`;
  };

  const targetValue = parseValue(value);

  useEffect(() => {
    if (isInView) {
      controls.start({
        value: targetValue,
        transition: { duration: 1.5, ease: "easeOut" }
      });
    }
  }, [isInView, controls, targetValue]);

  return (
    <motion.span
      ref={numberRef}
      initial={{ value: 0 }}
      animate={controls}
      onUpdate={(latest) => {
        if (numberRef.current) {
          numberRef.current.textContent = formatValue(latest.value, value);
        }
      }}
    />
  );
};

const FinancialStats = () => {
  const ref = useRef(null);
  const isInView = useInView(ref, { 
    once: true,
    amount: 0.2
  });

  const stats = [
    {
      number: "66%",
      description: "of Americans are financially illiterate"
    },
    {
      number: "78%",
      description: "of U.S. adults live paycheck to paycheck"
    },
    {
      number: "$1.76T",
      description: "total U.S. student loan debt"
    },
    {
      number: "40%",
      description: "of Americans can't cover a $400 emergency"
    }
  ];

  const containerVariants = {
    hidden: { 
      opacity: 0,
      y: 20
    },
    visible: {
      opacity: 1,
      y: 0,
      transition: {
        staggerChildren: 0.2,
        delayChildren: 0.1
      }
    }
  };

  const itemVariants = {
    hidden: { 
      opacity: 0,
      y: 20
    },
    visible: {
      opacity: 1,
      y: 0,
      transition: {
        duration: 0.6,
        ease: "easeOut"
      }
    }
  };

  return (
    <section className={styles.container} ref={ref}>
      <motion.div 
        className={styles.wrapper}
        initial="hidden"
        animate={isInView ? "visible" : "hidden"}
        variants={containerVariants}
      >
        <motion.h2 
          className={styles.title}
          variants={itemVariants}
        >
          Financial Literacy Crisis
        </motion.h2>
        
        <div className={styles.statsGrid}>
          {stats.map((stat, index) => (
            <motion.div 
              key={index} 
              className={styles.statItem}
              variants={itemVariants}
            >
              <motion.div 
                className={styles.divider}
                initial={{ scaleX: 0 }}
                animate={isInView ? { scaleX: 1 } : { scaleX: 0 }}
                transition={{ duration: 0.8, delay: 0.2 * index }}
              />
              <p className={styles.number}>
                <AnimatedCounter value={stat.number} isInView={isInView} />
              </p>
              <motion.p 
                className={styles.description}
                variants={itemVariants}
              >
                {stat.description}
              </motion.p>
            </motion.div>
          ))}
        </div>
      </motion.div>
    </section>
  );
};

export default FinancialStats;