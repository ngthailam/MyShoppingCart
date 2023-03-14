import 'package:get/route_manager.dart';
import 'package:my_shopping_list/features/cart/create/cart_create_controller.dart';
import 'package:my_shopping_list/features/cart/create/cart_create_page.dart';
import 'package:my_shopping_list/features/cart/detail/cart_detail_controller.dart';
import 'package:my_shopping_list/features/cart/detail/cart_detail_page.dart';
import 'package:my_shopping_list/features/home/home_page.dart';
import 'package:my_shopping_list/features/onboarding/onboard_page.dart';
import 'package:my_shopping_list/features/splash/splash_controller.dart';
import 'package:my_shopping_list/features/splash/splash_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String onboard = '/onboard';
  static const String cartDetail = '/cart/detail';
  static const String cartCreate = '/cart/create';

  static List<GetPage> generatePages() {
    return [
      GetPage(
        name: AppRoutes.splash,
        page: () => const SplashPage(),
        binding: SplashBindings(),
      ),
      GetPage(
          name: AppRoutes.home,
          page: () => const HomePage(),
          transition: Transition.fadeIn),
      GetPage(
        name: AppRoutes.onboard,
        page: () => const OnboardPage(),
        // binding: SignalFilterBindings(),
        // transition: Transition.rightToLeft,
      ),
      GetPage(
        name: AppRoutes.cartDetail,
        page: () => const CartDetailPage(),
        binding: CartDetailBindings(),
        // transition: Transition.rightToLeft,
      ),
      GetPage(
        name: AppRoutes.cartCreate,
        page: () => const CartCreatePage(),
        binding: CartCreateBindings(),
        // transition: Transition.rightToLeft,
      ),
    ];
  }
}
