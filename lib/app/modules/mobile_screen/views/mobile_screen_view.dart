import 'package:cart_app/app/routes/app_pages.dart';
import 'package:cart_app/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../utils/ColorRes.dart';
import '../../../utils/helper_widget.dart';
import '../controllers/mobile_screen_controller.dart';

class MobileScreenView extends GetView<MobileScreenController> {
  const MobileScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(children: [
                Container(
                  margin: const EdgeInsets.only(top: 60),
                  child: const Center(
                    child: Text(
                      'Mobile Authentication',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40, right: 10, left: 10),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Phone Number',
                      counterText: "",
                      prefix: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          '+91',
                          style: TextStyle(
                              color: ColorRes.textColor, fontSize: 16),
                        ),
                      ),
                    ),
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    controller: controller.mobielController,
                  ),
                )
              ]),
              SizedBox(
                height: 100,
              ),
              GestureDetector(
                  onTap: () {
                    if (controller.mobielController.text.length != 10) {
                      debugPrint("${controller.mobielController.text}========");
                      controller.mobielController.clear();
                      showToast(context, 'Invalid Phone Number');
                    } else {
                      debugPrint("${controller.mobielController.text}========");
                      AuthService().signInWithPhone(
                          controller.mobielController.text);
                      controller.mobielController.clear();
                    }
                  },
                  child: Container(
                      height: 60,
                      margin: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.green,
                      ),
                      child: Center(
                        child: Obx(
                              () =>
                          AuthService().isLoading.value == true
                              ? CircularProgressIndicator(color: ColorRes.white)
                              : Text(
                            'Next',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                  )
              )
            ]
        )
    );
  }}
