import 'package:easacc_test/LoginPage/Controller/LoginInController.dart';
import 'package:easacc_test/SettingsPage/Widget/SettingView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  WebViewScreen({super.key, required this.userUrl});

  final String userUrl;

  late final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.disabled)
    ..loadRequest(Uri.parse(userUrl));

  @override
  Widget build(BuildContext context) {
    final logInController = LogInController.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Web Page',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.to(() => const SettingsView()),
            icon: const Icon(Iconsax.setting_21),
          ),
          IconButton(
            onPressed: () async {
              await logInController.logout();
            },
            icon: const Icon(Iconsax.logout),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
