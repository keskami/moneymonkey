'use client';

import React, { useState, useEffect } from 'react';
import Image from 'next/image';
import { Clock } from 'lucide-react';
import styles from './BudgetingSimulator.module.css';

const CountdownTimer = () => {
  const [timeLeft, setTimeLeft] = useState({
    days: 0,
    hours: 0,
    minutes: 0,
    seconds: 0
  });

  useEffect(() => {
    const calculateTimeLeft = () => {
      const launchDate = new Date('2025-03-01T00:00:00');
      const now = new Date();
      const difference = launchDate - now;

      if (difference > 0) {
        setTimeLeft({
          days: Math.floor(difference / (1000 * 60 * 60 * 24)),
          hours: Math.floor((difference / (1000 * 60 * 60)) % 24),
          minutes: Math.floor((difference / 1000 / 60) % 60),
          seconds: Math.floor((difference / 1000) % 60)
        });
      }
    };

    const timer = setInterval(calculateTimeLeft, 1000);
    return () => clearInterval(timer);
  }, []);

  return (
    <div className={styles.countdownGrid}>
      {Object.entries(timeLeft).map(([unit, value]) => (
        <div key={unit} className={styles.countdownItem}>
          <div className={styles.countdownValue}>{value}</div>
          <div className={styles.countdownUnit}>{unit}</div>
        </div>
      ))}
    </div>
  );
};

const BudgetingSimulator = () => {
  return (
    <div className={styles.comingSoonContainer}>
      {/* Title */}
      <div className={styles.titleSection}>
        <h1>Budgeting Simulator</h1>
      </div>

      {/* Main Content Section */}
      <div className={styles.mainSection}>
        {/* Main Image */}
        <div className={styles.simulatorPreview}>
          <Image
            src="/simulator-images/budgeting.png" // Add your actual image path
            alt="Budgeting Simulator Preview"
            fill
            priority
            className="object-cover"
          />
          <div className={styles.overlay}></div>
        </div>

        <div className={styles.contentWrapper}>
          {/* Countdown Timer */}
          <CountdownTimer />

          {/* Launch Date */}
          <div className={styles.launchDate}>
            <Clock className={styles.clockIcon} />
            <span>Launching March 2025</span>
          </div>
        </div>
      </div>
    </div>
  );
};

export default BudgetingSimulator;