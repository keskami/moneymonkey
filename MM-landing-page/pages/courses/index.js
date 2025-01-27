import Navbar from "../../components/layout/Navbar";
import CourseHero from "../../components/courses/CourseHeroSection";
import CourseGrid from "../../components/courses/CourseGrid";
import CourseFeature1 from "../../components/courses/FeatureSection/Feature1";
import CourseFeature2 from "../../components/courses/FeatureSection/Feature2";
import CourseFeature3 from "../../components/courses/FeatureSection/Feature3";

export default function CoursesPage() {
    return (
      <>
        <Navbar />
        <CourseHero />
        <CourseGrid />
        <CourseFeature1 />
        <CourseFeature2 />
        <CourseFeature3 />
      </>
    );
  }