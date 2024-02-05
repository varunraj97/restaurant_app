import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OptController extends GetxController {
  //TODO: Implement OptController
String? VerificationId;
TextEditingController otpController = TextEditingController();
  final count = 0.obs;
  @override
  void onInit() {
    VerificationId = Get.arguments;
    debugPrint(VerificationId);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
