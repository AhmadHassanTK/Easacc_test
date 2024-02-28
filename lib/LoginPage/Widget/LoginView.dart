import 'package:easacc_test/LoginPage/Controller/LoginInController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final logInController = Get.put(LogInController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Welcome back!',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 60),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        await logInController.signInWithGoogle();
                      },
                      icon: const Image(
                        width: 60,
                        height: 60,
                        image: AssetImage('assets/google-icon.png'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'sign in with Google',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(height: 16),
                  const Divider(thickness: 3),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        await logInController.signInWithFacebook();
                      },
                      icon: const Image(
                        width: 60,
                        height: 60,
                        image: AssetImage('assets/facebook-icon.png'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'sign in with Facebook',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
