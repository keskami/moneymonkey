import React from 'react';
import { motion, useInView } from 'framer-motion';
import { useRef } from 'react';
import styles from './Feature.module.css';
import Image from 'next/image';
import Link from 'next/link';

const Feature4 = () => {
  const ref = useRef(null);
  const isInView = useInView(ref, {
    once: true,
    amount: 0.2
  });

  const containerVariants = {
    hidden: { 
      opacity: 0
    },
    visible: {
      opacity: 1,
      transition: {
        staggerChildren: 0.2,
        delayChildren: 0.1
      }
    }
  };

  const slideVariants = {
    hidden: { 
      opacity: 0,
      x: 30 // Sliding from right instead of left
    },
    visible: {
      opacity: 1,
      x: 0,
      transition: {
        duration: 0.8,
        ease: "easeOut"
      }
    }
  };

  const fadeUpVariants = {
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
    <section className={styles.featureContainer} ref={ref}>
      <motion.div 
        className={styles.contentWrapper}
        initial="hidden"
        animate={isInView ? "visible" : "hidden"}
        variants={containerVariants}
      >
        <motion.div 
          className={styles.textContent}
          variants={containerVariants}
        >
          <motion.h2 
            className={styles.title}
            variants={fadeUpVariants}
          >
            student/children progress insights
          </motion.h2>
          <motion.p 
            className={styles.description}
            variants={fadeUpVariants}
          > 
            Coming soon - Empowering educators and parents with real-time insights into student progress, including accuracy and time spent learning, through flexible, tailored curricula for grades 6-12 and beyond. 
          </motion.p>
          <motion.div 
            className={styles.buttonContainer}
            variants={fadeUpVariants}
          >
            <Link href="/dashboards" className={styles.button}>
              Dashboard
            </Link>
            <Link href="/pricing" className={`${styles.button} ${styles.buttonSecondary}`}>
              Pricing {'>'}
            </Link>
          </motion.div>
        </motion.div>
        <motion.div 
          className={styles.imageContainer}
          variants={slideVariants}
        >
          <Image
            src="/comingsoon.png"
            alt="Personalized assignments interface"
            width={800}
            height={500}
            className={styles.image}
          />
        </motion.div>
      </motion.div>
    </section>
  );
};

export default Feature4;