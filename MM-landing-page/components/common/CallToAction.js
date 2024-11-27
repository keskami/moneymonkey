import React from 'react';
import { motion, useInView } from 'framer-motion';
import { useRef } from 'react';
import styles from './CallToAction.module.css';
import Link from 'next/link';

const CallToAction = () => {
  const ref = useRef(null);
  const isInView = useInView(ref, {
    once: true,
    amount: 0.3 // Slightly higher threshold for dramatic effect
  });

  const containerVariants = {
    hidden: { 
      opacity: 0
    },
    visible: {
      opacity: 1,
      transition: {
        staggerChildren: 0.3,
        delayChildren: 0.1
      }
    }
  };

  const textVariants = {
    hidden: { 
      opacity: 0,
      y: 30
    },
    visible: {
      opacity: 1,
      y: 0,
      transition: {
        duration: 0.8,
        ease: "easeOut"
      }
    }
  };

  const buttonVariants = {
    hidden: { 
      opacity: 0,
      y: 20,
      scale: 0.95
    },
    visible: {
      opacity: 1,
      y: 0,
      scale: 1,
      transition: {
        duration: 0.6,
        ease: "easeOut"
      }
    }
  };

  const curveVariants = {
    hidden: { 
      opacity: 0,
      scaleY: 0
    },
    visible: {
      opacity: 1,
      scaleY: 1,
      transition: {
        duration: 1,
        ease: "easeOut",
        delay: 0.2
      }
    }
  };

  return (
    <section className={styles.container} ref={ref}>
      <motion.div 
        className={styles.content}
        initial="hidden"
        animate={isInView ? "visible" : "hidden"}
        variants={containerVariants}
      >
        <motion.h2 
          className={styles.title}
          variants={textVariants}
        >
          Give your students<br />
          skills they'll use for<br />
          life.
        </motion.h2>
        <motion.div variants={buttonVariants}>
          <Link href="/signup" className={styles.button}>
            Sign Up for Free
          </Link>
        </motion.div>
      </motion.div>
      
      {/* Animated decorative curve */}
      <motion.div 
        className={styles.bottomCurve}
        variants={curveVariants}
        initial="hidden"
        animate={isInView ? "visible" : "hidden"}
      />
    </section>
  );
};

export default CallToAction;