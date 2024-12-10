// pages/index.js
import HeroSection from '../components/home/HeroSection/HeroSection';
import FinancialStats from '../components/home/StatSection/FinancialStats';
import Feature1 from '../components/home/FeatureSection/Feature1';
import Feature2 from '../components/home/FeatureSection/Feature2';
import Feature3 from '../components/home/FeatureSection/Feature3';
import CallToAction from '../components/common/CallToAction';
import Feature4 from '../components/home/FeatureSection/Feature4';

export default function Home() {
  return (
    <>
      <HeroSection />
      <FinancialStats />
      <Feature1 />
      <Feature2 />
      <Feature3 />
      <Feature4 />
    </>
  );
}