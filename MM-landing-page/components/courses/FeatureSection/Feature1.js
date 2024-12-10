import React from 'react';
import { motion, useInView } from 'framer-motion';
import { useRef } from 'react';
import styles from './Feature.module.css';
import Image from 'next/image';
import Link from 'next/link';

const CourseFeature1 = () => {
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
      x: -30
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
          className={styles.imageContainer}
          variants={slideVariants}
        >
          <Image
            src="/course-images/course-features/coursefeature1.png"
            alt="Standards-aligned curriculum interface"
            width={800}
            height={500}
            className={styles.image}
          />
        </motion.div>
        <motion.div 
          className={styles.textContent}
          variants={containerVariants}
        >
          <motion.h2 
            className={styles.title}
            variants={fadeUpVariants}
          >
            Gamified Units
          </motion.h2>
          <motion.p 
            className={styles.description}
            variants={fadeUpVariants}
          >
            Money Monkey uses research backed educational-science to engage and retain learners of all levels
          </motion.p>
        </motion.div>
      </motion.div>
    </section>
  );
};

export default CourseFeature1;