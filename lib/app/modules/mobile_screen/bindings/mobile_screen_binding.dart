import 'package:get/get.dart';

import '../controllers/mobile_screen_controller.dart';

class MobileScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MobileScreenController>(
      () => MobileScreenController(),
    );
  }
}
