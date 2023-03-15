import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:my_shopping_cart/data/cart/cart_repo.dart';
import 'package:my_shopping_cart/data/cart/entity/cart.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(CartRepo()));
  }
}

class HomeController extends GetxController {
  final CartRepo _cartRepo;

  HomeController(this._cartRepo);

  final RxList<Cart> carts = RxList([]);
  final RxString greeting = RxString('');

  @override
  void onReady() {
    super.onReady();
    fetchGreetings();
    fetchAllCarts();
  }

  void fetchGreetings() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      greeting.value = 'Morning';
      return;
    }
    if (hour < 17) {
      greeting.value = 'Afternoon';
      return;
    }
    greeting.value = 'Evening';
  }

  Future fetchAllCarts() async {
    carts.value = await _cartRepo.getAll();
  }
}
