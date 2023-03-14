import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class CartDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CartDetailController());
  }
}

class CartDetailController extends GetxController {}
