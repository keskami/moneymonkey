// pages/index.js
import Head from 'next/head';
import styles from './CommingSoon.module.css'

export default function Home() {
  return (
    <div className={styles.container}>
      <Head>
        <title>Coming Soon</title>
        <meta name="description" content="Coming Soon Page" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main className={styles.main}>
        <h1 className={styles.title}>
          Coming Soon
        </h1>
      </main>
    </div>
  );
}