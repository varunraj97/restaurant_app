import 'package:get/get.dart';
import '../modules/cart_page/bindings/cart_page_binding.dart';
import '../modules/cart_page/views/cart_page_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/mobile_screen/bindings/mobile_screen_binding.dart';
import '../modules/mobile_screen/views/mobile_screen_view.dart';
import '../modules/opt/bindings/opt_binding.dart';
import '../modules/opt/views/opt_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SIGN_UP;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomView(),
      binding: HomeBinding(),

    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.CART_PAGE,
      page: () => const CartPageView(),
      binding: CartPageBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.MOBILE_SCREEN,
      page: () => const MobileScreenView(),
      binding: MobileScreenBinding(),
    ),
    GetPage(
      name: _Paths.OPT,
      page: () => const OptView(),
      binding: OptBinding(),
    ),
  ];
}
