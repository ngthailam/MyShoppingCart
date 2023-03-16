import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:my_shopping_cart/data/cart/entity/cart_item.dart';
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

        return Column(
          children: [
            Expanded(child: _itemList(cartItems)),
            _finishFab(context),
          ],
        );
      }),
    );
  }

  Widget _itemList(List<CartItem> cartItems) {
    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, i) {
        return _CartDetailItem(
          item: cartItems[i],
          onChecked: (bool isChecked) {
            controller.onItemChecked(cartItems[i], isChecked);
          },
        );
      },
    );
  }

  Widget _finishFab(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: FloatingActionButton.extended(
          heroTag: 'Fab',
          backgroundColor: controller.isFinished.value
              ? Theme.of(context).floatingActionButtonTheme.backgroundColor
              : Colors.grey,
          onPressed: () {
            controller.confirmFinish();
          },
          label: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.done),
              SizedBox(width: 8),
              Text('Confirm Finish'),
            ],
          ),
        ),
      );
    });
  }
}

class _CartDetailItem extends StatefulWidget {
  const _CartDetailItem({
    Key? key,
    required this.item,
    required this.onChecked,
  }) : super(key: key);

  final CartItem item;
  final Function(bool isChecked) onChecked;

  @override
  State<_CartDetailItem> createState() => _CartDetailItemState();
}

class _CartDetailItemState extends State<_CartDetailItem> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.item.text,
              style: TextStyle(color: _isChecked ? Colors.grey : Colors.black),
            ),
          ),
          const SizedBox(width: 16),
          _checkBox(),
        ],
      ),
    );
  }

  Widget _checkBox() {
    return IconButton(
      constraints: const BoxConstraints(),
      onPressed: () {
        setState(() {
          _isChecked = !_isChecked;
          widget.onChecked(_isChecked);
        });
      },
      icon: _isChecked
          ? Icon(
              Icons.check_box_rounded,
              color: Colors.grey,
            )
          : Icon(Icons.check_box_outline_blank_rounded),
    );
  }
}
