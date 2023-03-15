import 'package:hive/hive.dart';

part 'cart.g.dart';

@HiveType(typeId: 0)
class Cart extends HiveObject {
  static const String boxName = 'cartBox';

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final List<String> items;

  Cart({
    required this.id,
    required this.title,
    required this.items,
  });
}
