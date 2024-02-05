import 'package:cart_app/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class CartPageController extends GetxController {
  //TODO: Implement CartPageController
  HomeController homeController = Get.find<HomeController>();

  final count = 0.obs;
  @override
  void onInit() {
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
