import Navbar from '../components/layout/Navbar';
import HeroSection from '../components/home/HeroSection/HeroSection';
import FinancialStats from '../components/home/StatSection/FinancialStats';
import Feature1 from '../components/home/FeatureSection/Feature1';
import Feature2 from '../components/home/FeatureSection/Feature2';
import Feature3 from '../components/home/FeatureSection/Feature3';
import CallToAction from '../components/common/CallToAction';

export default function Home() {
  return (
    <>
      <Navbar />
      <HeroSection />
      <FinancialStats />
      <Feature1 />
      <Feature2 />
      <Feature3 />
      <CallToAction />
    </>
  );
}