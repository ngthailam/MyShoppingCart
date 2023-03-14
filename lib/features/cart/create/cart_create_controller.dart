import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class CartCreateBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CartCreateController());
  }
}

class CartCreateController extends GetxController {}
