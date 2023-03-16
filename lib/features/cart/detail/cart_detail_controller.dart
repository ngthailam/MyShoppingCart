import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:my_shopping_cart/data/cart/cart_repo.dart';
import 'package:my_shopping_cart/data/cart/entity/cart.dart';
import 'package:my_shopping_cart/data/cart/entity/cart_item.dart';

class CartDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CartDetailController(CartRepo()));
  }
}

class CartDetailController extends GetxController {
  final CartRepo _cartRepo;

  CartDetailController(this._cartRepo);

  String cartId = '';

  Rx<Cart?> cart = Rx(null);

  // key: cartItem id
  // value: is checked
  Map<int, bool> itemCheckMap = {};

  RxBool isFinished = RxBool(false);

  @override
  void onReady() {
    super.onReady();
    cartId = Get.arguments as String;
    fetchCart();
  }

  Future fetchCart() async {
    cart.value = await _cartRepo.getOne(cartId);
    for (var element in cart.value?.items ?? []) {
      itemCheckMap[element.id] = false;
    }
  }

  void onItemChecked(CartItem cartItem, bool isChecked) {
    itemCheckMap[cartItem.id] = isChecked;
    resolveFinish();
  }

  void resolveFinish() {
    final isNotFinished = itemCheckMap.values.any((element) => !element);

    if (isFinished.value == isNotFinished) {
      isFinished.value = !isNotFinished;
    }
  }

  void confirmFinish() async {
    await _cartRepo.delete(cartId);
    Get.back();
  }
}
