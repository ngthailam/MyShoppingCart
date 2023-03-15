import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:my_shopping_cart/data/cart/cart_repo.dart';
import 'package:my_shopping_cart/data/cart/entity/cart.dart';

class CartDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CartDetailController(
      CartRepo()
    ));
  }
}

class CartDetailController extends GetxController {
  final CartRepo _cartRepo;

  CartDetailController(this._cartRepo);

  String cartId = '';

  Rx<Cart?> cart = Rx(null);

  @override
  void onReady() {
    super.onReady();
    cartId = Get.arguments as String;
    fetchCart();
  }

  Future fetchCart() async {
    cart.value = await _cartRepo.getOne(cartId);
  }
}
