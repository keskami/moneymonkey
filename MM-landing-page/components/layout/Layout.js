// components/layout/Layout.js
import Navbar from './Navbar'
import Footer from '../common/Footer'
import CallToAction from '../common/CallToAction'

export default function Layout({ children }) {
  return (
    <div className="w-full min-h-screen flex flex-col">
      <Navbar />
      <main className="w-full flex-grow">
        {children}
      </main>
      <CallToAction />
      <Footer />
    </div>
  )
}