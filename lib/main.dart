import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'auth_service.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
      const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? widget) {
        return GetMaterialApp(
          title: "GoSmart Employe App",
          defaultTransition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 200),
          home: AuthService().handleAuthState(),
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: false),
        );
      },
    );
  }
}
