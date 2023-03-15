import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:my_shopping_cart/core/navigation/app_routes.dart';
import 'package:my_shopping_cart/features/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _welcomeText(),
            _carts(),
          ],
        ),
      ),
      floatingActionButton: _cartCreateFab(),
    );
  }

  Widget _welcomeText() {
    return PaddedColumn(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return Text('Good ${controller.greeting.value}');
        }),
        const Text('Welcome'),
      ],
    );
  }

  Widget _carts() {
    return Expanded(
      child: Obx(() {
        final carts = controller.carts;

        if (carts.isEmpty) return Container(); // TODO: add empty state

        return ListView.builder(
          itemCount: carts.length,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.cartDetail, arguments: carts[i].id);
              },
              child: Text(carts[i].title));
          },
        );
      }),
    );
  }

  Widget _cartCreateFab() {
    return FloatingActionButton.extended(
      onPressed: () {
        Get.toNamed(AppRoutes.cartCreate);
      },
      label: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.shopping_bag),
          SizedBox(width: 8),
          Text('Make Shopping list'),
        ],
      ),
    );
  }
}
