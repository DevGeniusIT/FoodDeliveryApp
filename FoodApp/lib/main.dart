import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_app/auth/sign_up_page.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/pages/cart/cart_page.dart';
import 'package:food_app/pages/chat/chatbot.dart';
import 'package:food_app/pages/food/popular_food_detail.dart';
import 'package:food_app/pages/food/recommended_food_detail.dart';
import 'package:food_app/pages/home/food_page_body.dart';
import 'package:food_app/pages/home/main_food_page.dart';
import 'package:food_app/pages/splash/splash_page.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:url_strategy/url_strategy.dart';
import 'auth/sign_in_page.dart';
import 'controllers/popular_product_controller.dart';
import 'controllers/recommended_product_controller.dart';
import 'helper/dependencies.dart' as dep;

import 'package:get/get.dart';

import 'helper/notification_helper.dart';


Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_){
     return GetBuilder<RecommendedProductController>(builder: (_){
       return GetMaterialApp(
         debugShowCheckedModeBanner: false,
         title: 'Flutter Demo',
         //home: SignInPage(),
         //home: SplashScreen(),
         //home: ChatBot(),
         initialRoute: RouteHelper.getSplashPgae(),
         getPages: RouteHelper.routes,
         theme: ThemeData(
           primaryColor: AppColors.mainColor,
           fontFamily: "Lato"
         ),
       );
     });
    });
  }
}
