import { motion } from 'framer-motion';
import styles from './HeroSection.module.css';

export default function HeroSection() {
  const containerVariants = {
    hidden: { opacity: 0 },
    visible: { 
      opacity: 1,
      transition: {
        staggerChildren: 0.2,
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
        ease: 'easeOut'
      }
    }
  };

  return (
    <motion.main 
      className={styles.container}
      initial="hidden"
      animate="visible"
      variants={containerVariants}
    >
      <div className={styles.leftContent}>
        <motion.h1 
          className={styles.title}
          variants={itemVariants}
        >
          Transforming Financial Literacy with Engaging, Hands-On Learning
        </motion.h1>
        <motion.p 
          className={styles.subtitle}
          variants={itemVariants}
        >
          AI-powered financial education through application-based learning and gamification for K-12 schools, colleges, and banks.
        </motion.p>
        <motion.a 
          href="#" 
          className={styles.demoButton}
          variants={itemVariants}
        >
          Book a Demo →
        </motion.a>
      </div>
      <motion.div 
        className={styles.rightContent}
        variants={itemVariants}
      >
        <img 
          src="/homeimage.png" 
          alt="Platform Preview" 
          className={styles.mockupImage}
        />
      </motion.div>
    </motion.main>
  );
}