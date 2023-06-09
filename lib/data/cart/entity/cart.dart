import 'package:hive/hive.dart';
import 'package:my_shopping_cart/data/cart/entity/cart_item.dart';

part 'cart.g.dart';

@HiveType(typeId: 0)
class Cart extends HiveObject {
  static const String boxName = 'cartBox';

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final List<CartItem> items;

  Cart({
    required this.id,
    required this.title,
    required this.items,
  });
}
