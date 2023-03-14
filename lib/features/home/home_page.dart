import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:my_shopping_list/core/navigation/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        _header(),
        _body(),
      ]),
      floatingActionButton: _cartCreateFab(),
    );
  }

  Widget _header() {
    return Row(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              //
            },
          ),
        )
      ],
    );
  }

  Widget _body() {
    return Container();
  }

  Widget _cartCreateFab() {
    return FloatingActionButton.extended(
      onPressed: () {
        Get.toNamed(AppRoutes.cartCreate);
      },
      label: Row(
        children: [
          Icon(Icons.shopping_bag),
          Text('Make Shopping list'),
        ],
      ),
    );
  }
}
