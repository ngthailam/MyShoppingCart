import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:my_shopping_cart/core/navigation/app_routes.dart';
import 'package:my_shopping_cart/features/home/home_controller.dart';
import 'package:my_shopping_cart/features/home/widgets/home_cart_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollController = ScrollController();
  final HomeController controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.extentBefore < 120) {
        controller.toggleFabVisibility(true);
        return;
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        controller.toggleFabVisibility(false);
      } else {
        controller.toggleFabVisibility(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _welcomeText(),
            _carts(scrollController),
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
          return Text(
            'Good ${controller.greeting.value}',
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
          );
        }),
        Text(
          'Let\'s do some shopping',
          style: TextStyle(color: Colors.grey.shade800),
        ),
      ],
    );
  }

  Widget _carts(ScrollController scrollController) {
    return Expanded(
      child: Obx(() {
        final carts = controller.carts;
        // TODO: add empty state
        if (carts.isEmpty) return Container();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            itemCount: carts.length,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemBuilder: (context, i) {
              return HomeCartItem(cart: carts[i]);
            },
          ),
        );
      }),
    );
  }

  Widget _cartCreateFab() {
    return Obx(() {
      final isVisible = controller.isFabVisible.value;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: isVisible ? 200 : 0,
        curve: Curves.easeOut,
        child: FloatingActionButton.extended(
          heroTag: 'Fab',
          onPressed: () {
            Get.toNamed(AppRoutes.cartCreate);
          },
          label: isVisible
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.shopping_bag),
                    SizedBox(width: 8),
                    Text('Make Shopping list'),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      );
    });
  }
}
