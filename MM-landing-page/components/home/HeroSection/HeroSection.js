'use client';
import React, { useEffect, useState } from 'react';

const HeroSection = () => {
  const primaryBlue = '#38A4D8';
  const primaryGreen = '#89DC8E';
  const [isVisible, setIsVisible] = useState(false);

  useEffect(() => {
    setIsVisible(true);
  }, []);

  return (
    <>
      <style jsx global>{`
        @import url('https://fonts.googleapis.com/css2?family=Baloo+2:wght@400..800&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=Handlee&display=swap');

        @keyframes fadeSlideUp {
          from {
            opacity: 0;
            transform: translateY(30px);
          }
          to {
            opacity: 1;
            transform: translateY(0);
          }
        }

        @keyframes fadeSlideIn {
          from {
            opacity: 0;
            transform: translateX(-30px);
          }
          to {
            opacity: 1;
            transform: translateX(0);
          }
        }

        @keyframes fadeIn {
          from {
            opacity: 0;
          }
          to {
            opacity: 1;
          }
        }

        @keyframes scaleIn {
          from {
            opacity: 0;
            transform: scale(0.8);
          }
          to {
            opacity: 1;
            transform: scale(1);
          }
        }

        @keyframes drawUnderline {
          from {
            opacity: 0;
            clip-path: inset(0 100% 0 0);
          }
          to {
            opacity: 1;
            clip-path: inset(0 0 0 0);
          }
        }
      `}</style>

      <style jsx>{`
        .hero {
          margin-bottom: 3rem;
          position: relative;
          width: 100%;
          background-color: white;
          padding: 2rem 0;
          overflow: visible;
          font-family: 'Baloo 2', cursive;
        }

        .content {
          max-width: 90%;
          margin: 0 auto;
          padding: 0 1rem;
          padding-top: 2rem;
          opacity: 0;
          animation: fadeIn 0.5s ease-out forwards;
          animation-delay: 0.2s;
        }

        .title {
          font-size: 2rem;
          font-weight: 420;
          text-align: center;
          margin-bottom: 1.5rem;
          line-height: 1.1;
        }

        .title-line {
          opacity: 0;
          transform: translateY(30px);
          animation: fadeSlideUp 0.7s ease-out forwards;
        }

        .title-line:nth-child(1) {
          animation-delay: 0.3s;
        }

        .title-line:nth-child(2) {
          animation-delay: 0.5s;
        }

        .title-line:nth-child(3) {
          animation-delay: 0.7s;
        }

        .highlight {
          display: inline-block;
          position: relative;
          font-family: 'Handlee';
          font-weight: 500;
        }

        .squiggle {
          transform-origin: left;
          position: absolute;
          width: 100%;
          pointer-events: none;
          animation: drawUnderline 0.6s ease-out forwards;
          opacity: 0;
        }

        .learn-squiggle {
          left: 30px;
          height: 30px;
          bottom: -10px;
          width: 100%;
          animation-delay: 1s;
        }
        
        .learn-squiggle img {
          transform: translateY(-15px); 
        }

        .play-squiggle {
          left: 30px;
          width: 100%;
          bottom: -30px;
          height: 50px;
          animation-delay: 1.5s;
          clip-path: inset(0 100% 0 0);
        }

        .squiggle img {
          width: 100%;
          height: 100%;
          object-fit: contain;
        }

        .subtitle {
          color: #4B5563;
          text-align: center;
          font-size: 1rem;
          margin-bottom: 2rem;
          max-width: 100%;
          margin-left: auto;
          margin-right: auto;
          padding: 0 1rem;
          opacity: 0;
          animation: fadeSlideUp 0.7s ease-out forwards;
          animation-delay: 0.9s;
        }

        .button-container {
          text-align: center;
          opacity: 0;
          animation: scaleIn 0.5s ease-out forwards;
          animation-delay: 1.1s;
        }

        .button {
          display: inline-flex;
          align-items: center;
          gap: 0.75rem;
          color: white;
          padding: 0.875rem 2rem;
          border-radius: 9999px;
          font-size: 1rem;
          font-weight: 500;
          background-color: ${primaryBlue};
          border: none;
          cursor: pointer;
          box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
          transition: all 0.2s ease;
        }

        .button:hover {
          box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
          transform: translateY(-2px);
        }

        .button svg {
          width: 1.25rem;
          height: 1.25rem;
        }

        .image {
          position: absolute;
          opacity: 0;
        }

        .image img {
          width: 100%;
          height: 100%;
          object-fit: cover;
        }

        /* Mobile First Approach - Base Styles */
        .top-left-image {
          left: 1rem;
          top: 5rem;
          width: 8rem;
          height: 8rem;
          animation: fadeSlideIn 0.8s ease-out forwards;
          animation-delay: 1.3s;
        }

        .bottom-right-image {
          right: 1rem;
          bottom: 2rem;
          width: 6rem;
          height: 6rem;
          animation: fadeSlideIn 0.8s ease-out forwards;
          animation-delay: 1.5s;
        }

        .top-right-image {
          right: 1rem;
          top: 6rem;
          width: 6rem;
          height: 6rem;
          animation: fadeSlideIn 0.8s ease-out forwards;
          animation-delay: 1.4s;
        }

        .bottom-left-image {
          left: 1rem;
          bottom: 3rem;
          width: 4rem;
          height: 4rem;
          animation: fadeSlideIn 0.8s ease-out forwards;
          animation-delay: 1.6s;
        }

        @media (min-width: 480px) {
          .hero {
            padding: 2.5rem 0;
          }

          .content {
            padding-top: 5rem;
            max-width: 85%;
          }

          .title {
            font-size: 2.5rem;
          }

          .subtitle {
            font-size: 1.05rem;
          }

          .top-right-image {
            top: 7rem;
          }

          .top-left-image {
            left: -1rem;
            top: 7rem;
            width: 9rem;
            height: 9rem;
          }

          .bottom-right-image {
            width: 7rem;
            height: 7rem;
          }

          .learn-squiggle {
            height: 40px;
            left: 0px;
            bottom: -34px;
          }

          .play-squiggle {
            left: 10px;
            bottom: -38px;
            height: 70px;
          }
        }

        /* Medium tablets (600px) - New */
        @media (min-width: 600px) {
          .hero {
            padding: 2.75rem 0;
          }

          .content {
            padding-top: 4rem;
          }

          .title {
            font-size: 3rem;
          }

          .subtitle {
            font-size: 1.1rem;
            max-width: 28rem;
          }

          .top-left-image {
            width: 10rem;
            height: 10rem;
            top: 6rem;
            left: 0rem;
          }

          .bottom-left-image {
            left: 5rem;
          }

          .bottom-right-image {
            right: 2rem;
            width: 7.5rem;
            height: 7.5rem;
          }

          .top-right-image {
            right: 2rem;
            width: 7rem;
            height: 7rem;
          }
        }

        /* Tablet (768px) */
        @media (min-width: 768px) {
          .hero {
            padding: 3rem 0;
          }

          .content {
            padding-top: 6rem;
            max-width: 80%;
          }

          .title {
            font-size: 4rem;
          }

          .subtitle {
            font-size: 1.125rem;
            max-width: 32rem;
          }

          .top-left-image {
            left: 0rem;
            top: 8rem;
            width: 12rem;
            height: 12rem;
          }

          .bottom-right-image {
            right: 3rem;
            bottom: 3rem;
            width: 8rem;
            height: 8rem;
          }

          .top-right-image {
            right: 3rem;
            top: 8rem;
            width: 8rem;
            height: 8rem;
          }

          .bottom-left-image {
            left: 6rem;
            bottom: 2rem;
            width: 5rem;
            height: 5rem;
          }

          .learn-squiggle {
            height: 40px;
            bottom: -22px;
          }

          .play-squiggle {
            bottom: -40px;
            height: 70px;
          }
        }

        /* Small Desktop (1024px) */
        @media (min-width: 1024px) {
          .hero {
            padding: 4rem 0;
          }

          .content {
            padding-top: 5rem;
            max-width: 64rem;
          }

          .title {
            font-size: 5.5rem;
          }

          .subtitle {
            font-size: 1.25rem;
            max-width: 36rem;
          }

          .learn-squiggle {
            height: 50px;
            bottom: -14px;
          }

          .play-squiggle {
            bottom: -50px;
            height: 90px;
          }

          .top-left-image {
            left: -1rem;
            top: 9rem;
            width: 16rem;
            height: 16rem;
          }

          .bottom-right-image {
            right: 5rem;
            bottom: 4rem;
            width: 10rem;
            height: 10rem;
          }

          .top-right-image {
            right: 3rem;
            top: 10rem;
            width: 10rem;
            height: 10rem;
          }

          .bottom-left-image {
            left: 7rem;
            bottom: 5rem;
            width: 6rem;
            height: 6rem;
          }
        }
        
        /* Medium Desktop (1200px) - New */
        @media (min-width: 1200px) {
          .hero {
            padding: 4.5rem 0;
          }

          .title {
            font-size: 6rem;
          }

          .top-left-image {
            width: 18rem;
            height: 18rem;
          }

          .learn-squiggle {
            height: 50px;
            bottom: -10px;
          }

          .play-squiggle {
            bottom: -50px;
            height: 90px;
          }

          .bottom-right-image {
            right: 10rem;
            width: 11rem;
            height: 11rem;
          }
        }

        /* Large Desktop (1440px and above) - Original Dimensions */
        @media (min-width: 1440px) {
          .hero {
            padding: 5rem 0;
          }

          .content {
            padding-top: 5rem;
          }

          .title {
            font-size: 7rem;
          }

          .top-left-image {
            left: 4rem;
            top: 10rem;
            width: 20rem;
            height: 20rem;
          }

          .bottom-right-image {
            right: 13rem;
            bottom: 4rem;
            width: 12rem;
            height: 12rem;
          }

          .top-right-image {
            right: 9rem;
            top: 12rem;
            width: 12rem;
            height: 12rem;
          }

          .bottom-left-image {
            left: 13rem;
            bottom: 7rem;
            width: 7rem;
            height: 7rem;
          }

          .learn-squiggle {
            height: 50px;
            bottom: -17px;
          }

          .learn-squiggle img {
            transform: translateY(-30px); 
          }

          .play-squiggle {
            bottom: -52px;
            height: 90px;
          }
        }

        .animated {
          opacity: 1;
        }
      `}</style>

      {/* JSX remains exactly the same */}
      <div className={`hero ${isVisible ? 'animated' : ''}`}>
        <div className="content">
          <h1 className="title">
            <div className="title-line">The best way to</div>
            <div className="title-line">
              <span className="highlight">
                <span style={{ color: primaryBlue }}>learn</span>
                <div className="squiggle learn-squiggle">
                  <img
                    src="/home-hero-section/learn-squiggle.png"
                    alt="Learn decoration"
                  />
                </div>
              </span>
              {' '}and{' '}
              <span className="highlight">
                <span style={{ color: primaryGreen }}>play</span>
                <div className="squiggle play-squiggle">
                  <img
                    src="/home-hero-section/play-squiggle.png"
                    alt="Play decoration"
                  />
                </div>
              </span>
            </div>
            <div className="title-line">personal finance</div>
          </h1>

          <p className="subtitle">
            AI-powered financial education through application-based learning and gamification for K-12 schools, colleges, and banks
          </p>

          <div className="button-container">
            <button className="button">
              Get started
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
          </div>
        </div>

        <div className="image top-left-image">
          <img src="/home-hero-section/collegestudent.png" alt="Top left decoration" />
        </div>

        <div className="image bottom-right-image">
          <img src="/home-hero-section/highschooler.png" alt="Bottom right decoration" />
        </div>

        <div className="image top-right-image">
          <img src="/home-hero-section/logocircle.png" alt="Top right decoration" />
        </div>

        <div className="image bottom-left-image">
          <img src="/home-hero-section/circledecoration.png" alt="Bottom left decoration" />
        </div>
      </div>
    </>
  );
};

export default HeroSection;