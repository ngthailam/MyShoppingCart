import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:my_shopping_list/core/navigation/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Shopping List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: AppRoutes.generatePages(),
      scrollBehavior: NoGlowScrollBehaviour(),
      initialRoute: AppRoutes.onboard,
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
