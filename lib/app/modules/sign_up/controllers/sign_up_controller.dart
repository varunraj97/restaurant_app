import 'package:cart_app/app/utils/helper_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/common_function.dart';
import '../../../utils/key_constatnt.dart';
import '../../../utils/services.dart';

class SignUpController extends GetxController {
  //TODO: Implement SignUpController
  RxBool isLoading = true.obs;
  @override
  void onInit() {
    isLoged();
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

  isLoged(){
    Future.delayed(const Duration(seconds: 3),(){
      if(getToken().toString()=="null"){
        return   isLoading.value = false;
      }
      else{
        return Get.offAllNamed(Routes.HOME);
      }
    });

  }
}
