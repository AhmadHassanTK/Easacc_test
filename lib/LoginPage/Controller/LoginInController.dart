import 'package:easacc_test/Auth/AuthRepo.dart';
import 'package:easacc_test/LoginPage/Widget/LoginView.dart';
import 'package:easacc_test/SettingsPage/Controller/SettingsController.dart';
import 'package:easacc_test/WebPage/WebView.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LogInController extends GetxController {
  static LogInController get instance => Get.find();

  final localstorage = GetStorage();

  final authrepo = AuthRepo.instance;
  final settingscontroller = SettingsController.instance;

  Future<void> signInWithGoogle() async {
    try {
      await authrepo.signInWithGoogle();

      localstorage.write('LoggedIn', true);
      Get.offAll(
          () => WebViewScreen(userUrl: settingscontroller.globalUrl.value));
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      await authrepo.signInWithFacebook();
      localstorage.write('LoggedIn', true);
      Get.offAll(
          () => WebViewScreen(userUrl: settingscontroller.globalUrl.value));
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<void> logout() async {
    try {
      await authrepo.logout();
      localstorage.write('LoggedIn', false);
      Get.offAll(() => const LoginView());
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }
}
