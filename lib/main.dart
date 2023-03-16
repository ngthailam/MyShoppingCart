import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_shopping_cart/core/navigation/app_routes.dart';
import 'package:my_shopping_cart/data/cart/entity/cart.dart';
import 'package:my_shopping_cart/data/cart/entity/cart_item.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();

  runApp(const MyApp());
}

initHive() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter(CartAdapter())
    ..registerAdapter(CartItemAdapter());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Shopping Cart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      getPages: AppRoutes.generatePages(),
      scrollBehavior: NoGlowScrollBehaviour(),
      initialRoute: AppRoutes.home,
      navigatorKey: Get.key,
    );
  }
}

class NoGlowScrollBehaviour extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
