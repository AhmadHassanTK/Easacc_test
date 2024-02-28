import 'package:easacc_test/LoginPage/Widget/LoginView.dart';
import 'package:easacc_test/SettingsPage/Controller/SettingsController.dart';
import 'package:easacc_test/WebPage/WebView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthRepo extends GetxController {
  static AuthRepo get instance => Get.find();

  final auth = FirebaseAuth.instance;
  User? get authuser => auth.currentUser;
  final localstorage = GetStorage();
  final controller = Get.put(SettingsController());

  @override
  void onReady() {
    localstorage.read('LoggedIn') != true
        ? Get.offAll(() => const LoginView())
        : Get.offAll(() => WebViewScreen(userUrl: controller.globalUrl.value));
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await account?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      return await auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
      Get.offAll(() => const LoginView());
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<UserCredential> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.status == LoginStatus.success) {
        final AccessToken accessToken = loginResult.accessToken!;
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);

        return await auth.signInWithCredential(credential);
      } else {
        throw FirebaseAuthException(
          code: 'Facebook Login Failed',
          message: 'The Facebook login was not successful.',
        );
      }
    } on FirebaseAuthException catch (e) {
      throw 'Firebase Auth Exception: ${e.message}';
    } catch (e) {
      throw 'Other Exception: $e';
    }
  }
}
