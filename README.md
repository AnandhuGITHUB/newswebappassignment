# Flutter Web News Feed Application

This is a Flutter web application that allows users to create and manage a news feed. It integrates with Firebase Cloud Firestore for data storage and Firebase Cloud Messaging (FCM) for sending real-time notifications when new articles are posted.

## Features

- **Real-time News Feed**: Fetches and displays news articles from Firestore in real-time.
- **Post Creation**: Allows users to create new articles with title, content, and author name.
- **Real-time Notifications**: Sends push notifications to users when new articles are posted using Firebase Cloud Messaging.
- **Edit/Delete Posts**: Users can edit or delete their own posts.
- **Dark/Light Mode**: Users can switch dark mode and light mode

## Technologies Used

- Flutter
- Firebase (Firestore and Cloud Messaging)
- GetX for State Management
- HTTP package for making API calls
- Firebase Auth


## Setting up Firebase Credentials

To run this project, you need a Firebase service account JSON file for authentication.

1. Go to the Firebase Console and navigate to your project.
2. Under **Settings > Service Accounts**, generate a new private key and download the JSON file.
3. Rename the downloaded file to `serviceAccount.json`.
4. Place the file in the lib/core/secrets/ folder of the project (or specify the correct path if it's different).

Make sure to keep this file secure and do not commit it to version control.


## Setup

1. **Clone the Repository**

   ```bash
   git clone https://github.com/yourusername/news_feed_app.git
   cd news_feed_app

2. **Install Dependency**
   Run 
    - flutter pub get
    - npm install firebase




## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
#   n e w s w e b a p p a s s i g n m e n t  
 