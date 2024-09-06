

import 'package:flutter/cupertino.dart';
import 'package:mvvm_architecture/repository/auth_repository.dart';
import 'package:mvvm_architecture/utils/routes/routes_names.dart';
import 'package:mvvm_architecture/utils/utils.dart';
import 'package:mvvm_architecture/view_model/secrvices/SplashServices.dart';
import 'package:mvvm_architecture/view_model/user_view_model.dart';

import '../model/UserModel.dart';

class AuthViewModel with ChangeNotifier{

  final _myRepo = AuthRepository();
  SplashServices splashservices = SplashServices();


  bool _signuploading = false;
  bool get signuploading => _signuploading;

  void setSignUpLoading( bool value ){
    _signuploading = value ;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  void setLoading( bool value ){
    _loading = value ;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.loginApi(data).then((value) {
      setLoading(false);

      // Assuming the response contains the token
      UserModel user = UserModel.fromJson(value);

      // Save the token in SharedPreferences using UserViewModel
      UserViewModel().saveUser(user);

      Utils.flushBarErrorMessage("Login successful", context);
      print("runing login api in auth view model");
      splashservices.checkAuthentication(context);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }



  Future<void>  signupApi(dynamic data , BuildContext context)async {
    setSignUpLoading(true);
    _myRepo.registerApi(data).then((value){
      setLoading(false);
      Utils.flushBarErrorMessage("registered successfully", context);
      Navigator.pushNamed(context,RoutesNames.signup );
    }).onError((error,stackTrace){
      setSignUpLoading(false);
      print(error.toString());
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

}