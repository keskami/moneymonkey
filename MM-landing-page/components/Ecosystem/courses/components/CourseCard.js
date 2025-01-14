import Image from 'next/image';
import styles from './CourseCard.module.css';

const CourseCard = ({ image, title, category, price, hours }) => {
  return (
    <div className={styles.card}>
      <div className={styles.imageContainer}>
        <Image 
          src={image} 
          alt={title}
          fill
          className={styles.image}
        />
      </div>
      <div className={styles.content}>
        <h3 className={styles.title}>{title}</h3>
        <span className={styles.category}>{category}</span>
        <div className={styles.details}>
          <span className={styles.price}>{price} Units</span>
          <span className={styles.hours}>{hours} hrs</span>
        </div>
      </div>
    </div>
  );
};

export default CourseCard;