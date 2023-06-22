import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/custom_app_bar.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/pages/order/view_order.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:get/get.dart';

import '../../base/custom_loader.dart';
import '../../base/no_data_page.dart';
import '../../controllers/order_controller.dart';
import '../../controllers/user_controller.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin{

  late TabController _tabController;
  late bool _isLoggedIn;

  @override
  void initState(){
    super.initState();
    _isLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_isLoggedIn){
      _tabController = TabController(length: 2, vsync: this);
      Get.find<OrderController>().getOrderList();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: "My orders",),
      body:GetBuilder<UserController>(builder: (userController){
        return _isLoggedIn ? (userController.isLoading ? Column(
          children: [
            Container(
              width: Dimensions.screenWidth,
              child: TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                indicatorWeight: 3,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Theme.of(context).disabledColor,
                controller: _tabController,
                tabs: const [
                  Tab(text: "Current",),
                  Tab(text: "History"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  ViewOrder(isCurrent: true),
                  ViewOrder(isCurrent: false),
                ],
              ),
            )
          ],
        ): CustomLoader())
            : SizedBox(
            height: MediaQuery.of(context).size.height/1.5,
            child: const Center(
                child: NoDataPage(
                  text: "You can't track your order because you aren't logged in!",
                  imgPath: "assets/image/onboard_2.png",
                )
            )
        );
      }),
    );
  }
}
