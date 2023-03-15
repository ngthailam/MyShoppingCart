import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class OnboardBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(OnboardController());
  }
}

class OnboardController extends GetxController {

}
