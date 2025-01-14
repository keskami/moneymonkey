import Image from 'next/image';
import { motion } from 'framer-motion';
import styles from './CourseHeroSection.module.css';

const CourseHero = () => {
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
     <div className={styles.container}>
       <motion.div 
         className={styles.content}
         variants={itemVariants}
       >
         <motion.h1 variants={itemVariants}>Our Courses</motion.h1>
         <motion.p variants={itemVariants}>
           This is your educational companion, dedicated to providing a seamless learning experience.
         </motion.p>
       </motion.div>
       <motion.div 
         className={styles.imageContainer}
         variants={itemVariants}
       >
         <Image
           src="/coursehero.png"
           alt="Students learning together"
           fill
           style={{ objectFit: 'cover' }}
           priority
         />
       </motion.div>
     </div>
   </motion.section>
 );
};

export default CourseHero;