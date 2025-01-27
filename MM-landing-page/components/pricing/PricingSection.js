import { useState } from 'react';
import styles from './PricingSection.module.css';
import PricingCard from './components/PricingCard';

const PricingSection = () => {
  const [isYearly, setIsYearly] = useState(false);

  const pricingPlans = [
    {
      name: "BASIC EDUCATION",
      price: { monthly: 0, yearly: 0 },
      description: "Available Features",
      buttonText: "Get Started",
      features: [
        { text: "Access to all material.", included: true },
        { text: "Limited scenario application", included: true },
        { text: "Basic community support.", included: true },
        { text: "No simulations.", included: false },
        { text: "Ad-supported platform.", included: true },
        { text: "Limited monkey features", included: true },
        { text: "Early access to new courses.", included: false }
      ],
      theme: "basic"
    },
    {
      name: "PRO EDUCATION",
      price: { monthly: 5.99, yearly: 60 },
      description: "Available Features",
      buttonText: "Get Started",
      features: [
        { text: "Access to all material.", included: true },
        { text: "Full scenario application.", included: true },
        { text: "Priority community support.", included: true },
        { text: "All simulations.", included: true },
        { text: "Ad-free experience.", included: true },
        { text: "All monkey features", included: true },
        { text: "Standard access to new courses.", included: true }
      ],
      theme: "standard"
    },
    {
      name: "FAMILY",
      price: { monthly: 9.99, yearly: 96 },
      description: "Available Features",
      buttonText: "Get Started",
      features: [
        { text: "Up to 4 children", included: true },
        { text: "Access to all material.", included: true },
        { text: "Full scenario application.", included: true },
        { text: "Priority community support.", included: true },
        { text: "All simulations.", included: true },
        { text: "Ad-free experience.", included: true },
        { text: "All monkey features", included: true },
        { text: "Standard access to new courses.", included: true },
        { text: "Parent tracking dashboard", included: true }
      ],
      theme: "pro",
      popular: true
    },
    {
      name: "SCHOOLS",
      price: { monthly: 'TBD', yearly: 'TBD' },
      description: "Available Features",
      buttonText: "Get Template",
      features: [
        { text: "Access to all material.", included: true },
        { text: "Full scenario application.", included: true },
        { text: "Priority community support.", included: true },
        { text: "All simulations.", included: true },
        { text: "Ad-free experience.", included: true },
        { text: "All monkey features", included: true },
        { text: "Standard access to new courses.", included: true },
        { text: "Custom curriculum building tool.", included: true },
        { text: "Teacher tracking dashboard.", included: true }
      ],
      theme: "infinite"
    }
  ];

  return (
    <section className={styles.section}>
      <div className={styles.container}>
        <h2 className={styles.title}>Our Pricing</h2>
        <p className={styles.subtitle}>Choose the most suitable plan for your studies with us.</p>
        
        <div className={styles.toggle}>
          <span className={isYearly ? styles.inactive : styles.active}>Monthly</span>
          <button 
            className={`${styles.toggleButton} ${isYearly ? styles.active : ''}`}
            onClick={() => setIsYearly(!isYearly)}
            aria-label="Toggle pricing period"
          >
            <div className={styles.toggleCircle} />
          </button>
          <span className={isYearly ? styles.active : styles.inactive}>
            Yearly
            <span className={styles.discount}>-20% off</span>
          </span>
        </div>

        <div className={styles.grid}>
          {pricingPlans.map((plan, index) => (
            <PricingCard
              key={index}
              {...plan}
              price={isYearly ? plan.price.yearly : plan.price.monthly}
              isYearly={isYearly}
            />
          ))}
        </div>
      </div>
    </section>
  );
};

export default PricingSection;