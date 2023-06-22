import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controllers/order_controller.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/utils/styles.dart';
import 'package:get/get.dart';

class DeliveryOptions extends StatelessWidget {
  final String value;
  final String title;
  final double amount;
  final bool isFree;
  const DeliveryOptions({Key? key,
    required this.value,
    required this.title,
    required this.amount,
    required this.isFree}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController){
      return Row(
        children: [
          Radio(
            onChanged: (String? value)=>orderController.setDeliveryType(value!),
            groupValue: orderController.orderType,
            value: value,
            activeColor: Theme.of(context).primaryColor,
          ),
          SizedBox(width: Dimensions.width10/2,),
          Text(title, style: TextStyle(fontWeight: FontWeight.w400, fontSize: Dimensions.font20),),
          SizedBox(width: Dimensions.width10/2,),
          Text(
            '(${(value == 'take away' || isFree) ? 'Free' : '\$${amount/10}'})',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: Dimensions.font20),
          )
        ],
      );
    });
  }
}
