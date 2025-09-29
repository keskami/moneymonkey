// pages/index.js
import Head from 'next/head';
import styles from './CommingSoon.module.css'

export default function LaunchSoon() {
  return (
    <div className={styles.container}>
      <Head>
        <title>Launching to the Public April 2025</title>
        <meta name="description" content="Coming Soon Page" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main className={styles.main}>
        <h1 className={styles.title}>
        Launching to the Public April 2025
        </h1>
      </main>
    </div>
  );
}