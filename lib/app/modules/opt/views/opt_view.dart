import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../auth_service.dart';
import '../../../utils/ColorRes.dart';
import '../../../utils/helper_widget.dart';
import '../controllers/opt_controller.dart';

class OptView extends GetView<OptController> {
  const OptView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 60),
                  child: const Center(
                    child: Text(
                      'OTP Verification',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40, right: 10, left: 10),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Otp',
                      counterText: "",
                    ),
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    controller: controller.otpController,

                  ),
                )
              ]),
          SizedBox(height: 100,),
          GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (controller.otpController.text.isEmpty) {
                debugPrint("${controller.otpController.text}===otp=====");
                showToast(context,'invalid otp');
              }else{
                debugPrint("${controller.otpController.text}====otp====");
                AuthService().signInWithPhoneStage2(controller.VerificationId!,controller.otpController.text);
              }

            },
            child: Container(
              height: 60,
              margin: const EdgeInsets.symmetric(vertical: 40,horizontal: 20),

              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.green,
              ),
              child: const Center(
                child: Text(
                  'Next',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
