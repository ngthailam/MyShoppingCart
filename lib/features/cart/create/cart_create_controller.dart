import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:my_shopping_cart/core/navigation/app_routes.dart';
import 'package:my_shopping_cart/data/cart/cart_repo.dart';
import 'package:my_shopping_cart/data/cart/entity/cart.dart';
import 'package:my_shopping_cart/data/cart/entity/cart_item.dart';

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

  final FocusNode titleFocusNode = FocusNode();

  final ScrollController scrollController = ScrollController();

  final Map<int, CartItem> items = {};
  final RxMap<int, int> displayItemBlocks = RxMap();
  final RxBool showBeginShopping = RxBool(false);
  final RxInt itemCount = RxInt(0);

  int currentFocusItemId = 0;

  @override
  void onInit() {
    super.onInit();
    items[0] = CartItem(id: 0, text: '');
    displayItemBlocks[0] = 0;

    itemCount.listen((int count) {
      showBeginShopping.value = count != 0;
    });
  }

  Future<Cart?> saveCart() async {
    if (itemEdtCtrl.text.isNotEmpty) {
      // onSubmitCartItem(itemEdtCtrl.text);
    }

    if (items.isNotEmpty) {
      return _cartRepo.create(
        title: titleEdtCtrl.text.isNotEmpty ? titleEdtCtrl.text : 'No Title',
        items: items.values.toList(),
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

  // onSubmitCartItem(String text, {int? itemId}) {
  //   // Add new item
  //   if (itemId == null) {
  //     final generatedId = items.length;
  //     items[generatedId] = CartItem(id: generatedId, text: text);
  //     itemEdtCtrl.clear();
  //   } else {
  //     // Edit and already exist item
  //   }

  //   if (items.isEmpty == showBeginShopping.value) {
  //     showBeginShopping.value = items.isNotEmpty;
  //   }

  //   itemCount.value = items.length;

  //   Future.delayed(const Duration(milliseconds: 150), () {
  //     scrollToBottom();
  //   });
  // }

  void onItemSubmit({
    required int itemId,
  }) {
    // If no item has bigger id -> this is the last item
    final isLastItem = !items.keys.any((element) => element > itemId);
    if (isLastItem) {
      final newIndex = items.length;
      items[newIndex] = CartItem(id: newIndex, text: '');
      displayItemBlocks[newIndex] = newIndex;
    }
  }

  void onItemTextChanged({
    required int itemId,
    required String text,
  }) {
    items[itemId] = items[itemId]!.copyWith(text: text);

    itemCount.value =
        items.values.where((element) => element.text.isNotEmpty).length;
  }

  void onItemFocus({required int itemId}) {
    if (itemId != currentFocusItemId) {
      if (items[itemId] != null && items[itemId]?.text.isEmpty == true) {
        items.remove(itemId);
        displayItemBlocks.remove(itemId);
      }
    }

    currentFocusItemId = itemId;
  }

  void scrollToBottom() {
    scrollController.jumpTo(
      scrollController.position.maxScrollExtent,
    );
  }
}
