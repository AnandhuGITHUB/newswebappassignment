import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/theme/theme.dart';
import 'features/auth/bindings/auth_binding.dart';
import 'features/auth/pages/login_page.dart';
import 'features/auth/pages/signup_page.dart';
import 'features/home/controller/home_controller.dart';
import 'features/home/pages/home_page.dart';
import 'features/home/pages/post_creation_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AuthBinding().dependencies();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyCCpgFNm1WWzmoHBUuk7IVI9CyqJr9yUtw",
    appId: "1:853950773631:web:1f58baeff296231ef6c24a",
    messagingSenderId: "853950773631",
    projectId: "news-app-83ab4",
  ));
  runApp(const NewsFeedWebApp());
}

class NewsFeedWebApp extends StatelessWidget {
  const NewsFeedWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return GetMaterialApp(
      title: 'News Feed Web App',
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkThemeMode,
      theme: AppTheme.lightThemeMode,
      themeMode: homeController.themeMode,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const LoginPage()),
        GetPage(name: '/signup', page: () => const SignUpPage()),
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/create_post', page: () => const PostCreationPage()),
      ],
    );
  }
}
