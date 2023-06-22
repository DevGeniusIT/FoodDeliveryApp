import 'package:food_app/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';

import '../data/repository/recommended_product_repo.dart';
import '../models/products_model.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<ProductModel> _recommendedProductList=[];
  List<ProductModel> get recommendedProductList => _recommendedProductList;
  List<ProductModel> _recommendedProductListtmp=[];

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList()async {
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode==200){
      //print("get products recommended");
      _recommendedProductListtmp = []
;      _recommendedProductList=[];
      _recommendedProductListtmp.addAll(Product.fromJson(response.body).products);
      //print(_popularProductList);
      _recommendedProductList = _recommendedProductListtmp;
      _isLoaded=true;
      update();
    }
    else{
      print("could not get products recommended");
    }
  }
  onSearch(String value){
    _recommendedProductList = _recommendedProductListtmp.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
    update();
  }
}