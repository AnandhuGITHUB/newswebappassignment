// Please see this file for the latest firebase-js-sdk version:
// https://github.com/firebase/flutterfire/blob/master/packages/firebase_core/firebase_core_web/lib/src/firebase_sdk_version.dart
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js");

const firebaseConfig = {
    apiKey: "AIzaSyCCpgFNm1WWzmoHBUuk7IVI9CyqJr9yUtw",
    authDomain: "news-app-83ab4.firebaseapp.com",
    projectId: "news-app-83ab4",
    storageBucket: "news-app-83ab4.appspot.com",
    messagingSenderId: "853950773631",
    appId: "1:853950773631:web:1f58baeff296231ef6c24a",
    measurementId: "G-8C4HDW2X2B"
  };

firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});