import { motion } from 'framer-motion';
import styles from './K-12-HeroSection.module.css';

const K12Hero = () => {
  const containerVariants = {
    hidden: { opacity: 0 },
    visible: {
      opacity: 1,
      transition: {
        staggerChildren: 0.2
      }
    }
  };

  const itemVariants = {
    hidden: { opacity: 0, y: 20 },
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
    <motion.section 
      className={styles.heroSection}
      initial="hidden"
      animate="visible"
      variants={containerVariants}
    >
      <div className={styles.whiteContainer}>
        <div className={styles.contentContainer}>
          <div className={styles.textContent}>
            <motion.h1 
              className={styles.heading}
              variants={itemVariants}
            >
              WHO WE SERVE
              <motion.div 
                className={styles.subHeading}
                variants={itemVariants}
              >
                Money Monkey
                <br />
                <div className={styles.teachersWrapper}>
                  for K-12 schools
                  <motion.img 
                    src="/who-we-serve-images/K12-squiggle.png"
                    alt="decorative squiggle"
                    className={styles.squiggle}
                    variants={itemVariants}
                  />
                </div>
              </motion.div>
            </motion.h1>
            
            <motion.p 
              className={styles.description}
              variants={itemVariants}
            >
Money Monkey supports K-12 schools with state-standard aligned curriculum
and engaging tools to teach essential financial literacy skills.
            </motion.p>

            <motion.div 
              className={styles.buttonContainer}
              variants={itemVariants}
            >
              <button className={styles.button}>
                Book a demo
                <svg
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2.5"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                >
                  <path d="M5 12h14M12 5l7 7-7 7" />
                </svg>
              </button>
            </motion.div>
          </div>

          <motion.div 
            className={styles.imageContainer}
            variants={itemVariants}
          >
            <img
              src="/who-we-serve-images/K12-candid.png"
              alt="Course illustrations"
              className={styles.heroImage}
            />
          </motion.div>
        </div>
      </div>
    </motion.section>
  );
};

export default K12Hero;