import 'package:flutter/cupertino.dart';
import 'package:mvvm_architecture/data/response/api_response.dart';
import 'package:mvvm_architecture/model/productModel.dart';
import 'package:mvvm_architecture/repository/home_repository.dart';

class HomeViewModel with ChangeNotifier {
  final _myRepo = HomeRepository() ;

  ApiResponse<ProductModel> productList = ApiResponse.loading();

  setProductList(ApiResponse<ProductModel> response){
    productList = response;
    notifyListeners();
  }


  Future<void> fetchProductsListApi() async{
    setProductList(ApiResponse.loading());
    _myRepo.fetchProductsList().then((value){
      setProductList(ApiResponse.completed(value));
    }).onError((error ,stackTrace){
      setProductList(ApiResponse.error(error.toString()));
    });
  }

}