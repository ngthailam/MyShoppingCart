import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:my_shopping_list/core/navigation/app_routes.dart';
import 'package:my_shopping_list/data/settings/uset_settings_repo.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController(
      UserSettingsRepo(),
    ));
  }
}

class SplashController extends GetxController {
  final UserSettingsRepo _userSettingsRepo;

  SplashController(this._userSettingsRepo);

  @override
  void onReady() async {
    super.onReady();
    final isShowOnboard = await _userSettingsRepo.getIsShowOnboard();
    if (isShowOnboard) {
      Get.toNamed(AppRoutes.onboard);
    } else {
      Get.toNamed(AppRoutes.home);
    }
  }
}
