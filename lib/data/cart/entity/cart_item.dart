import 'package:hive_flutter/hive_flutter.dart';

part 'cart_item.g.dart';

@HiveType(typeId: 1)
class CartItem extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String text;

  CartItem({
    required this.id,
    required this.text,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(id: json['id'] as int, text: json['text'] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    return data;
  }

  CartItem copyWith({
    int? id,
    String? text,
  }) {
    return CartItem(
      id: id ?? this.id,
      text: text ?? this.text,
    );
  }
}
