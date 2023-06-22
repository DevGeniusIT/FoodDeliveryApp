import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/custom_loader.dart';
import 'package:food_app/controllers/order_controller.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/utils/styles.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;
  const ViewOrder({Key? key, required this.isCurrent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(builder: (orderController){
        if(orderController.isLoading==false){
          List<OrderModel> orderList = [];
          if(orderController.currentOrderList.isNotEmpty){
            orderList = isCurrent?orderController.currentOrderList.reversed.toList():
            orderController.historyOrderList.reversed.toList();
          }
          return SizedBox(
            width: Dimensions.screenWidth,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width10/2, vertical: Dimensions.height10/2),
              child: ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, index){
                    return InkWell(
                      onTap: ()=>null,
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text("Order ID:", style: robotoRegular.copyWith(
                                      fontSize: Dimensions.font12
                                    ),),
                                    SizedBox(width: Dimensions.width10/2,),
                                    Text('#${orderList[index].id.toString()}'),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.mainColor,
                                        borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                                      ),
                                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.width10/2),
                                        child: Text('${orderList[index].orderStatus}',
                                        style: robotoMedium.copyWith(
                                          fontSize: Dimensions.font12,
                                          color: Theme.of(context).cardColor
                                        )
                                        ),
                                    ),
                                    SizedBox(height: Dimensions.height10/2,),
                                    InkWell(
                                      onTap: ()=>null,
                                      child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.width10/2),
                                          decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                                          border: Border.all(width: 1, color: Theme.of(context).primaryColor)
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset("assets/image/tracking.png",height: 15, width: 15, color: Theme.of(context).primaryColor,),
                                            SizedBox(width: Dimensions.width10/2,),
                                            Text(
                                              "Track order",
                                              style: robotoMedium.copyWith(
                                                  fontSize: Dimensions.font12,
                                                  color: Theme.of(context).primaryColor),
                                            )
                                          ],
                                        )
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: Dimensions.height10,)
                        ],
                      ),
                    );
                  }),
            )
          );
        }else{
          return CustomLoader();
        }
      }),
    );
  }
}
