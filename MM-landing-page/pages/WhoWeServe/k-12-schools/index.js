import Feature1 from '../../../components/home/FeatureSection/Feature1';
import Feature2 from '../../../components/home/FeatureSection/Feature2';
import Feature3 from '../../../components/home/FeatureSection/Feature3';
import Feature4 from '../../../components/home/FeatureSection/Feature4';
import K12Hero from '../../../components/WhoWeServe/k-12-schools/K-12-HeroSection';

export default function Home() {
  return (
    <>
      <K12Hero />
      <Feature1 />
      <Feature2 />
      <Feature3 />
      <Feature4 />
    </>
  );
}