import 'package:get/get.dart';
class Dimensions{
  static double screenHight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageView = screenHight/2.56;
  static double pageViewContainer = screenHight/3.73;
  static double pageViewTextContainer = screenHight/6.83;

  //dynamic height padding and margin
  static double height10 = screenHight/82.0;
  static double height15 = screenHight/54.67;
  static double height20 = screenHight/41.0;
  static double height30 = screenHight/27.33;
  static double height45 = screenHight/18.22;


  //dynamic width padding and margin
  static double width10 = screenHight/82.0;
  static double width15 = screenHight/54.67;
  static double width20 = screenHight/41.0;
  static double width30 = screenHight/27.33;

  //font size 820/size
  static double font12 = screenHight/68.33;
  static double font16 = screenHight/51.25;
  static double font20 = screenHight/41.0;
  static double font26 = screenHight/31.54;

  //radius
  static double radius15 = screenHight/54.67;
  static double radius20 = screenHight/41.0;
  static double radius30 = screenHight/27.33;

  //icon Size
  static double iconSize24 = screenHight/34.17;
  static double iconSize16 = screenHight/51.25;

  //list view size
  static double listViewImageSize = screenWidth/3.25; /*390/120*/
  static double listViewTextContSize = screenWidth/3.9; /*390/100*/

  //popular food 820/350(chieu cao vung chua anh)
  static double popularFoodImgSize = screenHight/2.34;

  //
  static double bottomHeightBar = screenHight/6.83;

  //splash
  static double splashImg = screenHight/3.28;

}