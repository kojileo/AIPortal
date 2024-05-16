const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { logger } = require("firebase-functions/logger"); // logger imported

// Firebaseの設定情報
const firebaseConfig = {
  apiKey: "AIzaSyBGCZs5404t_sQKhApV2gb-6hCUSxMHCvs",
  authDomain: "aibase-be441.firebaseapp.com",
  projectId: "aibase-be441",
  storageBucket: "aibase-be441.appspot.com",
  messagingSenderId: "977511628724",
  appId: "1:977511628724:web:3b1124290ea8f348aefce1",
  measurementId: "G-GR7HCSBE0V",
};

// Firebase Admin SDKの初期化
admin.initializeApp({
  credential: admin.credential.applicationDefault(),
  ...firebaseConfig,
});

// サンプルのHTTP関数
exports.helloWorld = functions.https.onRequest((request, response) => {
  logger.info("Hello logs!", { structuredData: true });
  response.send("Hello from Firebase using Config!");
});
