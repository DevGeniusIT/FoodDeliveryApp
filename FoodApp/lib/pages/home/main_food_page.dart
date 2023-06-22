import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/small_text.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../utils/dimensions.dart';
import 'food_page_body.dart';
import 'package:get/get.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  bool isSearch = false;

  void onSearch() {
    setState(() {
      isSearch = !isSearch;
    });
  }

  @override
  Widget build(BuildContext context) {
    //print("abc" +MediaQuery.of(context).size.height.toString());
    return RefreshIndicator(
        child: Column(
          children: [
            //showing the header
            Container(
              child: Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height45, bottom: Dimensions.height15),
                padding: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    !isSearch
                        ? Column(
                            children: [
                              BigText(
                                  text: "VietNam",
                                  color: AppColors.mainColor,
                                  size: 25),
                              Row(
                                children: [
                                  SmallText(
                                    text: "DaNang",
                                    color: Colors.black54,
                                  ),
                                  Icon(Icons.arrow_drop_down_rounded)
                                ],
                              )
                            ],
                          )
                        : Expanded(
                            child: TextField(
                            onChanged: Get.find<RecommendedProductController>()
                                .onSearch,
                            decoration: InputDecoration(
                                hintText: 'Nhập để tìm kiếm',
                                filled: true,
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)))),
                          )),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: onSearch,
                      child: Center(
                        child: Container(
                          width: Dimensions.height45,
                          height: Dimensions.height45,
                          child: Icon(Icons.search,
                              color: Colors.white, size: Dimensions.iconSize24),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius15),
                            color: AppColors.mainColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            //showing the body
            Expanded(
                child: SingleChildScrollView(
              child: FoodPageBody(
                isSearch: isSearch,
              ),
            )),
          ],
        ),
        onRefresh: _loadResource);
  }
}
