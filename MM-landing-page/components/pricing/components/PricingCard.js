import styles from './PricingCard.module.css';

const PricingCard = ({ 
  name, 
  price, 
  description, 
  buttonText, 
  features, 
  theme,
  popular,
  isYearly 
}) => {
  return (
    <div className={`${styles.card} ${styles[theme]}`}>
      {popular && <span className={styles.popularBadge}>Most Popular</span>}
      <div className={styles.header}>
        <h3 className={styles.planName}>{name}</h3>
        <div className={styles.priceContainer}>
          <span className={styles.currency}>$</span>
          <span className={styles.price}>{price}</span>
          <span className={styles.period}>/{isYearly ? 'yr' : 'mo'}</span>
        </div>
        <p className={styles.description}>{description}</p>
      </div>

      <button className={styles.button}>
        {buttonText}
      </button>

      <div className={styles.features}>
        {features.map((feature, index) => (
          <div key={index} className={styles.feature}>
            <span className={`${styles.icon} ${feature.included ? styles.included : styles.excluded}`}>
              {feature.included ? '✓' : '✕'}
            </span>
            <span className={feature.included ? '' : styles.excludedText}>
              {feature.text}
            </span>
          </div>
        ))}
      </div>
    </div>
  );
};

export default PricingCard;