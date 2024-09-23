import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:news_feed_web_app/core/common/widgets/snackbar.dart';
import '../models/article_model.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var isLoading = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final _themeMode = ThemeMode.dark.obs;
  ThemeMode get themeMode => _themeMode.value;

  RxList<Article> articles = <Article>[].obs;

  @override
  void onInit() {
    super.onInit();
    _setupFirebaseListeners();
    _initFCM();
  }

  void toggleThemeMode() {
    _themeMode.value =
        _themeMode.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    Get.changeThemeMode(_themeMode.value);
  }

  // Firestore real-time listener for posts for getting leatest news
  void _setupFirebaseListeners() {
    _firestore
        .collection('posts')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      articles.value =
          snapshot.docs.map((doc) => Article.fromDocument(doc)).toList();
    });
  }

  Future<void> createPost(String title, String content, String author) async {
    try {
      isLoading(true);
      String? token = await _firebaseMessaging.getToken();

      await _firestore.collection('posts').add({
        'title': title,
        'content': content,
        'author': author,
        'timestamp': FieldValue.serverTimestamp(),
      });
      isLoading(false);
      await _sendNotification(title, author, token ?? "");
      Get.back();
      showCustomSnackbar(
          title: 'Success', message: 'Post created successfully!');
    } catch (e) {
      isLoading(false);
      showCustomSnackbar(title: 'Error', message: 'Failed to create post: $e');
    }
  }

  Future<void> editPost(String postId, String title, String content) async {
    try {
      isLoading(true);
      await _firestore.collection('posts').doc(postId).update({
        'title': title,
        'content': content,
      });
      isLoading(false);
      Get.back();
      showCustomSnackbar(
          title: 'Success', message: 'Post updated successfully!');
    } catch (e) {
      isLoading(false);
      showCustomSnackbar(title: 'Error', message: 'Failed to update post: $e');
    }
  }

  Future<void> deletePost(String postId) async {
    isLoading(true);
    try {
      await _firestore.collection('posts').doc(postId).delete();
      isLoading(false);
      showCustomSnackbar(
          title: 'Success', message: 'Post deleted successfully!');
    } catch (e) {
      isLoading(false);
      showCustomSnackbar(title: 'Error', message: 'Failed to delete post: $e');
    }
  }

  void _initFCM() async {
    try {
      NotificationSettings settings =
          await _firebaseMessaging.requestPermission();
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        ('User granted permission');
      } else {
        debugPrint('User declined or has not accepted permission');
      }

      // Get the FCM token
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        _saveTokenToFirestore(token);
      }

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (message.notification != null) {
          debugPrint(
              'Received foreground notification: ${message.notification!.title}');
          showCustomSnackbar(
              title: 'New Post', message: message.notification!.title ?? '');
        }
      });

      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
    } catch (e) {
      debugPrint('fail $e');
      showCustomSnackbar(
          title: 'Error', message: 'Failed to initialize FCM: $e');
    }
  }

  void _saveTokenToFirestore(String token) async {
    try {
      await _firestore.collection('fcm_tokens').doc('web_user_token').set({
        'token': token,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      showCustomSnackbar(
          title: 'Error', message: 'Failed to save FCM token: $e');
    }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    showCustomSnackbar(
      title: 'New Post',
      message: message.notification!.title ?? '',
      duration: const Duration(days: 1),
    );
    debugPrint('Handling a background message: ${message.messageId}');
  }

  _getServerToken() async {
    final String jsonString =
        await rootBundle.loadString('lib/core/secrets/serviceAccount.json');
    final serviceAccountJson = jsonDecode(jsonString);
    List<String> scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.messaging',
      'https://www.googleapis.com/auth/firebase.database',
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(
        (serviceAccountJson),
      ),
      scopes,
    );

    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(
        (serviceAccountJson),
      ),
      scopes,
      client,
    );
    client.close();
    return credentials.accessToken.data;
  }

  // Send notification using FCM
  Future<void> _sendNotification(
      String title, String author, String webToken) async {
    final String serverToken = await _getServerToken();

    final Map<String, dynamic> notificationData = {
      "message": {
        'token': webToken,
        "notification": {
          "title": "New Article Posted",
          "body": "$title by $author",
        },
      },
    };

    try {
      final response = await http.post(
        Uri.parse(
            'https://fcm.googleapis.com/v1/projects/news-app-83ab4/messages:send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $serverToken',
        },
        body: jsonEncode(notificationData),
      );

      if (response.statusCode == 200) {
        debugPrint('Notification sent successfully.');
      } else {
        debugPrint('Failed to send notification: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error sending notification: $e');
    }
  }
}
