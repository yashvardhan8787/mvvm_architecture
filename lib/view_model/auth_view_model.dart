

import 'package:flutter/cupertino.dart';
import 'package:mvvm_architecture/repository/auth_repository.dart';
import 'package:mvvm_architecture/utils/routes/routes_names.dart';
import 'package:mvvm_architecture/utils/utils.dart';

class AuthViewModel with ChangeNotifier{

  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;
  void setLoading( bool value ){
    _loading = value ;
    notifyListeners();
  }

  Future<void>  loginApi(dynamic data , BuildContext context)async {
    setLoading(true);
    _myRepo.loginApi(data).then((value){
      setLoading(false);
      Utils.flushBarErrorMessage("login successful", context);
       Navigator.pushNamed(context,RoutesNames.home );
    }).onError((error,stackTrace){
      setLoading(false);
      print(error.toString());
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

}