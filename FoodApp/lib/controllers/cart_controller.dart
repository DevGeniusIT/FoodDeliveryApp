import 'package:flutter/material.dart';
import 'package:food_app/data/repository/cart_repo.dart';
import 'package:food_app/models/cart_model.dart';
import 'package:food_app/models/products_model.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';

class CartController extends GetxController{
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;
  //only for storage and sharedpreferences
  List<CartModel> storageItems=[];

  //thêm sp vào giỏ hàng
  void addItem(ProductModel product, int quantity){
    var totalQuantity=0;
    if(_items.containsKey(product.id!)){
      _items.update(product.id!, (value){
        totalQuantity = value.quantity!+quantity;
        return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantity:value.quantity!+quantity,
            isExist:true,
            time:DateTime.now().toString(),
            product: product,
        );
      });
      if(totalQuantity<=0){
        _items.remove(product.id);
      }
    }else{
      if(quantity>0){
        //print("length of the item is "+_items.toString());
        _items.putIfAbsent(product.id!, () {
          /*print("add item to the cart" + "id "+ product.id!.toString() + "quantity "+quantity.toString());
      _items.forEach((key, value) {
        print("quantity is "+ value.quantity.toString());
      });*/
          return CartModel(
              id: product.id,
              name: product.name,
              price: product.price,
              img: product.img,
              quantity:quantity,
              isExist:true,
              time:DateTime.now().toString(),
              product: product,
          );
        });
      }else{
        Get.snackbar("Item count", "You should at least add an item in the cart!",
            backgroundColor: AppColors.mainColor,
            colorText: Colors.white);
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  //kiểm tra sp đã có trong giỏ hàng chưa
  bool existInCart(ProductModel product){
    if(_items.containsKey(product.id)){
    return true;
  }
    return false;
  }

  //lấy số lượng sp nếu no tồn tại trong giỏ hàng
  int getQuantity(ProductModel product){
    var quantity = 0;
    if(_items.containsKey(product.id)){
      _items.forEach((key, value) {
        if(key==product.id){
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  //trả lại số lượng sản phẩm thêm vào giỏ hàng
  int get totalItems{
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems{
    return _items.entries.map((e){
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, value) {
      total += value.quantity!*value.price!;
    });
    return total;
  }

  List<CartModel> getCartData(){
    setCart = cartRepo.getCartList();
    return storageItems;
  }
  set setCart(List<CartModel> items){
    storageItems = items;
    //print("Length of cart items "+storageItems.length.toString());
    for(int i=0; i<storageItems.length; i++){
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory(){
    cartRepo.addToCartHistoryList();
    clear();
  }
  void clear(){
    _items={};
    update();
  }

  List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }

  set setItems(Map<int, CartModel> setItems){
    _items = {};
    _items = setItems;
  }

  void addToCartList(){
    cartRepo.addToCartList(getItems);
    update();
  }

  void clearCartHistory(){
    cartRepo.clearCartHistory();
    update();
  }

  void removeCartSharedPreference(){
    cartRepo.removeCartSharedPreference();
  }
}