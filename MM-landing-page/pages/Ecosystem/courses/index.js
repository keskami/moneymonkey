import Navbar from "../../../components/layout/Navbar";
import CourseHero from "../../../components/Ecosystem/courses/CourseHeroSection";
import CourseGrid from "../../../components/Ecosystem/courses/CourseGrid";
import CourseFeature1 from "../../../components/Ecosystem/courses/FeatureSection/Feature1";
import CourseFeature2 from "../../../components/Ecosystem/courses/FeatureSection/Feature2";
import CourseFeature3 from "../../../components/Ecosystem/courses/FeatureSection/Feature3";

export default function CoursesPage() {
    return (
      <>
        <CourseHero />
        <CourseGrid />
        <CourseFeature1 />
        <CourseFeature2 />
        <CourseFeature3 />
      </>
    );
  }