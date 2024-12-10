import CourseCard from './components/CourseCard';
import styles from './CourseGrid.module.css';
import { motion } from 'framer-motion';

const courseData = [
  {
    id: 1,
    image: '/course-images/responsibility.png',
    title: 'Financial Responsibility',
    category: 'Module 1',
    price: 10,
    hours: 5
  },
  {
    id: 2,
    image: '/course-images/careers.png',
    title: 'Relating Income and Careers',
    category: 'Module 2',
    price: 6,
    hours: 3
  },
  {
    id: 3,
    image: '/course-images/planning.png',
    title: 'Planning and Managing Money',
    category: 'Module 3',
    price: 11,
    hours: 6
  },
  {
    id: 4,
    image: '/course-images/credit.png',
    title: 'Managing Credit and Debt',
    category: 'Module 4',
    price: 8,
    hours: 4
  },
  {
    id: 5,
    image: '/course-images/insurance.png',
    title: 'Risk Management and Insurance',
    category: 'Module 5',
    price: 6,
    hours: 4
  },
  {
    id: 6,
    image: '/course-images/saveinvest.png',
    title: 'Saving and Investing',
    category: 'Module 6',
    price: 13,
    hours: 7
  },
];

const container = {
  hidden: { opacity: 0 },
  show: {
    opacity: 1,
    transition: {
      staggerChildren: 0.3,
      duration: 0.8,
      ease: "easeOut"
    }
  }
 };
 
 const item = {
  hidden: { opacity: 0, y: 30 },
  show: { 
    opacity: 1, 
    y: 0,
    transition: {
      duration: 0.4,
      ease: "easeOut"
    }
  }
 };

const CourseGrid = () => {
  return (
    <section className={styles.section}>
      <div className={styles.container}>
        <motion.div 
          className={styles.grid}
          variants={container}
          initial="hidden"
          animate="show"
        >
          {courseData.map((course) => (
            <motion.div key={course.id} variants={item}>
              <CourseCard
                image={course.image}
                title={course.title}
                category={course.category}
                price={course.price}
                hours={course.hours}
              />
            </motion.div>
          ))}
        </motion.div>
      </div>
    </section>
  );
};

export default CourseGrid;