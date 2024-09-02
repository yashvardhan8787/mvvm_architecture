
import 'package:mvvm_architecture/data/network/BaseApiServices.dart';
import 'package:mvvm_architecture/data/network/NetworkApiServices.dart';
import 'package:mvvm_architecture/res/app_urls.dart';

class AuthRepository{

  BaseApiServices _apiServices = NetworkApiServices();



  Future<dynamic>  loginApi(dynamic data) async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrls.loginEndPnt, data) ;
      return  response;
    }catch(e){
      throw e;
    }
  }



  Future<dynamic>  registerApi(dynamic data) async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrls.registerEndPnt, data) ;
      return  response;
    }catch(e){
      throw e;
    }
  }
}