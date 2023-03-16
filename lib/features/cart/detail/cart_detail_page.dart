import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:my_shopping_cart/features/cart/detail/cart_detail_controller.dart';

class CartDetailPage extends GetView<CartDetailController> {
  const CartDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Obx(() {
          final cart = controller.cart.value;
          if (cart == null) return const SizedBox.shrink();
          final itemCount =
              cart.items.isNotEmpty ? '(${cart.items.length})' : '';
          final title = cart.title.isNotEmpty ? cart.title : 'Cart';
          return Text('$title $itemCount');
        }),
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        final cartItems = controller.cart.value?.items ?? [];

        // TODO: show you already finish shopping or something
        if (cartItems.isEmpty) return const SizedBox.shrink();

        return ListView.builder(
          itemCount: cartItems.length,
          itemBuilder: (context, i) {
            return Text(cartItems[i].text);
          },
        );
      }),
    );
  }
}
