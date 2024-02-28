import 'package:app_settings/app_settings.dart';
import 'package:easacc_test/SettingsPage/Controller/SettingsController.dart';
import 'package:easacc_test/WebPage/WebView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Wifi and Bluetooth',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 5),
              DropdownButtonFormField(
                value: 'Wifi',
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.sort),
                ),
                items: [
                  'Wifi',
                  'Bluetooth',
                ]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) async {
                  if (value == 'Wifi') {
                    await AppSettings.openAppSettings(
                        type: AppSettingsType.wifi);
                  } else if (value == 'Bluetooth') {
                    await AppSettings.openAppSettings(
                        type: AppSettingsType.bluetooth);
                  }
                },
              ),
              const SizedBox(height: 2),
              const Text(
                'select to access your device network',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 70),
              const Text(
                'Web page ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.urlcontroller,
                decoration: InputDecoration(
                  hintText: 'Enter your Url',
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.8)),
                  label: const Text(
                    'Website Url',
                    style: TextStyle(color: Colors.black),
                  ),
                  border: const OutlineInputBorder().copyWith(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(width: 1, color: Color(0xFFE0E0E0)),
                  ),
                  focusedBorder: const OutlineInputBorder().copyWith(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(width: 1, color: Color(0xFF272727)),
                  ),
                  errorBorder: const OutlineInputBorder().copyWith(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(width: 1, color: Color(0xFFF57C00)),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.setUrl();
                    Get.offAll(() =>
                        WebViewScreen(userUrl: controller.globalUrl.value));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue[400]),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Launch',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
