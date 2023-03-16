import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_shopping_cart/data/cart/entity/cart.dart';
import 'package:my_shopping_cart/data/cart/entity/cart_item.dart';

class CartRepo {
  Future<Cart> create({
    String? title,
    required List<CartItem> items,
  }) async {
    final box = await cartBox();
    final cart = Cart(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title ?? '',
      items: items,
    );
    await box.put(cart.id, cart);
    return cart;
  }

  Future delete(String cartId) async {
    final box = await cartBox();
    return box.delete(cartId);
  }

  Stream<BoxEvent> listenAll() {
    return Hive.box<Cart>(Cart.boxName).watch();
  }

  Future<List<Cart>> getAll() async {
    final box = await cartBox();
    return box.values.toList();
  }

  Future<Cart?> getOne(String cartId) async {
    final box = await cartBox();
    return box.get(cartId);
  }

  Future<Box<Cart>> cartBox() async {
    if (Hive.isBoxOpen(Cart.boxName)) {
      return Hive.box<Cart>(Cart.boxName);
    } else {
      return Hive.openBox<Cart>(Cart.boxName);
    }
  }
}
