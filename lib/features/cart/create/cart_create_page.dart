import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:my_shopping_cart/features/cart/create/cart_create_controller.dart';

class CartCreatePage extends GetView<CartCreateController> {
  const CartCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.saveCartAndExit();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () async {
              controller.saveCartAndExit();
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: PaddedColumn(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _title(),
                    const SizedBox(height: 8),
                    _subtitle(),
                    const SizedBox(height: 16),
                    _items(),
                    const SizedBox(height: 8),
                    _content(),
                  ],
                ),
              ),
            ),
            Align(alignment: Alignment.bottomCenter, child: _saveFab()),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return TextField(
      controller: controller.titleEdtCtrl,
      decoration: const InputDecoration.collapsed(hintText: 'Title'),
    );
  }

  Widget _items() {
    return Obx(() {
      final cartItems = controller.items;

      if (cartItems.isEmpty) return const SizedBox.shrink();

      return ListView(
        shrinkWrap: true,
        children: cartItems.map((element) => _item(element)).toList(),
      );
    });
  }

  Widget _item(String element) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8), child: Text(element));
  }

  Widget _subtitle() {
    return Row(
      children: [
        Text(
          DateFormat('MMM dd, HH:mm').format(
            DateTime.fromMillisecondsSinceEpoch(controller.currentTime),
          ),
        ),
        const Text(' | 0 items'),
      ],
    );
  }

  Widget _content() {
    return TextField(
      controller: controller.itemEdtCtrl,
      onEditingComplete: () {}, // this prevents keyboard from closing
      onSubmitted: (text) => controller.onSubmitCartItem(text),
      decoration: const InputDecoration.collapsed(hintText: 'Shopping item'),
    );
  }

  Widget _saveFab() {
    return Obx(() {
      return Visibility(
        visible: controller.showBeginShopping.value,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: FloatingActionButton.extended(
            onPressed: () {
              // TODO: save
            },
            label: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.shopping_cart),
                SizedBox(width: 8),
                Text('Begin Shopping'),
              ],
            ),
          ),
        ),
      );
    });
  }
}
