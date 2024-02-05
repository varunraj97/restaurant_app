import 'package:get/get.dart';

import '../controllers/opt_controller.dart';

class OptBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OptController>(
      () => OptController(),
    );
  }
}
