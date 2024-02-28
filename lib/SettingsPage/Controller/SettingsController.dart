import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  final localstorage = GetStorage();
  final urlcontroller = TextEditingController();
  RxString globalUrl = ''.obs;

  @override
  void onInit() {
    globalUrl.value = localstorage.read('URL') ?? 'http://google.com';
    urlcontroller.text = localstorage.read('URL') ?? 'http://google.com';
    print(globalUrl.value);
    super.onInit();
  }

  void setUrl() {
    localstorage.write('URL', urlcontroller.text.trim());
    globalUrl.value = urlcontroller.text.trim();
  }
}
