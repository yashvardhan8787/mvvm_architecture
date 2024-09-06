import 'dart:convert';

import 'package:mvvm_architecture/model/productModel.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_urls.dart';

class HomeRepository{

  BaseApiServices _apiServices = NetworkApiServices();


  Future<ProductModel> fetchProductsList() async {
    try {
      // Fetch the API response
      dynamic response = await _apiServices.getGetApiResponse(AppUrls.productsEndPnt);

      // Parse the response to ProductModel
      final responseJson = ProductModel.fromJson(response);

      return responseJson;
    } catch (e) {
      // Log the error for better debugging
      print("Error fetching products: $e");

      // Re-throw the error to be handled by the calling function
      throw Exception("Failed to fetch products list: $e");
    }
  }


}