import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:hive/hive.dart';
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
  void onReady() async {
    super.onReady();
    fetchGreetings();
    await fetchAllCarts();
    _cartRepo.listenAll().listen((BoxEvent event) {
      if (carts.where((p0) => event.key == p0.id).isNotEmpty) {
        carts.removeWhere((element) => element.id == event.key);
      } else {
        carts.add(event.value as Cart);
      }
    });
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
