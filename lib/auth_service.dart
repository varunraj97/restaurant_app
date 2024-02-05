import 'package:cart_app/app/modules/home/views/home_view.dart';
import 'package:cart_app/app/modules/sign_up/views/sign_up_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'app/routes/app_pages.dart';

class AuthService{
RxBool isLoading = false.obs;
  handleAuthState(){
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(BuildContext context, snapshot){
          if(snapshot.hasData){
            return HomView();
          }
          else{
            return  SignUpView();
          }
        });
  }

  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: <String>["email"]).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signInWithPhone(String number)async{
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91$number',
      verificationCompleted: (PhoneAuthCredential credential) {
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {

        Get.toNamed(Routes.OPT,arguments:verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  signInWithPhoneStage2(String verificationId,String otp)async{
    try{
      PhoneAuthCredential credential = await PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp);
      await FirebaseAuth.instance.signInWithCredential(credential).then((value){
        Get.toNamed(Routes.HOME);
      });
    }
    catch(e){
      debugPrint(e.toString());
    }
  }


//Sign out
  signOut()async{
    await GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
  }
}