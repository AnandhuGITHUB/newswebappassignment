import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:news_feed_web_app/features/auth/pages/login_page.dart';
import 'package:news_feed_web_app/features/home/pages/home_page.dart';

import '../../../core/common/widgets/snackbar.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  var isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginPage());
    } else {
      Get.offAll(() => const HomePage());
    }
  }

  void register(String email, String password) async {
    try {
      isLoading(true);
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      isLoading(false);
    } on FirebaseAuthException catch (e) {
      isLoading(false);
      String errorMsg = handleAuthError(e);

      showCustomSnackbar(title: "Registration Error", message: errorMsg);
    }
  }

  void login(String email, String password) async {
    try {
      isLoading(true);
      await auth.signInWithEmailAndPassword(email: email, password: password);
      isLoading(false);
    } on FirebaseAuthException catch (e) {
      isLoading(false);
      String errorMsg = handleAuthError(e);
      showCustomSnackbar(title: "Login Error", message: errorMsg);
    }
  }

  void signOut() async {
    await auth.signOut();
  }

  String handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This user has been disabled.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'user-token-expired':
        return 'User session has expired. Please log in again.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';
      case 'invalid-credential':
        return 'Invalid login credentials.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled. Please contact support.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
