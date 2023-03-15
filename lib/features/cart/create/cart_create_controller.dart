import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:my_shopping_cart/core/navigation/app_routes.dart';
import 'package:my_shopping_cart/data/cart/cart_repo.dart';
import 'package:my_shopping_cart/data/cart/entity/cart.dart';

class CartCreateBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CartCreateController(
      CartRepo(),
    ));
  }
}

class CartCreateController extends GetxController {
  final CartRepo _cartRepo;

  CartCreateController(this._cartRepo);

  final currentTime = DateTime.now().millisecondsSinceEpoch;
  final TextEditingController titleEdtCtrl = TextEditingController();
  final TextEditingController itemEdtCtrl = TextEditingController();

  final RxList<String> items = RxList([]);
  final RxBool showBeginShopping = RxBool(false);

  Future<Cart?> saveCart() async {
    if (itemEdtCtrl.text.isNotEmpty) {
      onSubmitCartItem(itemEdtCtrl.text);
    }

    if (items.isNotEmpty) {
      return _cartRepo.create(
        title: titleEdtCtrl.text,
        items: items,
      );
    }

    return null;
  }

  Future saveCartAndExit() async {
    await saveCart();
    Get.back();
  }

  Future saveCartAndBeginShopping() async {
    final cart = await saveCart();
    if (cart != null) {
      Get.back();
      Get.toNamed(AppRoutes.cartDetail, arguments: cart.id);
    } else {
      Get.back();
    }
  }

  onSubmitCartItem(String text, {String? textId}) {
    // Add new item
    if (textId == null) {
      items.add(text);
      itemEdtCtrl.clear();
    } else {
      if (textId.isEmpty) {
        items.remove(textId);
      } else {
        items[items.indexOf(textId)] = text;
      }
    }

    if (items.isEmpty == showBeginShopping.value) {
      showBeginShopping.value = items.isNotEmpty;
    }
  }
}
