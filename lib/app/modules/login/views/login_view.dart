import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/log.png", height: 200,),
            const SizedBox(height: 30,),
            InkWell(
              onTap: () {
                // AuthService().signInWithGoogle();
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.lightBlue
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 20,),
                    Image.asset("assets/icons/google.png", width: 25,),
                    const SizedBox(width: 20,),
                    const Text("Sign in with google", style: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.white),)
                  ],
                ),
              ),
            ),
            SizedBox(height: 30,),
            InkWell(
              onTap: () {
                // AuthService().signinwithph();
                // Get.to(()=>MobileScreen());
                // Navigator.push(context,MaterialPageRoute(builder:(context)=>MobileScreen()));
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.green
                ),
                child: Row(
                  children: const[
                    SizedBox(width: 20,),
                    Icon(Icons.phone, color: Colors.white,),
                    SizedBox(width: 20,),
                    Text("Sign in with Phone", style: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.white),)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
