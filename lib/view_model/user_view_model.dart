import 'package:flutter/widgets.dart';
import 'package:mvvm_architecture/model/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier{

   Future<bool> saveUser(UserModel user) async{

     final SharedPreferences sp = await SharedPreferences.getInstance();
     sp.setString("token", user.token.toString());
     notifyListeners();
     return true;

   }

   Future<UserModel> getUser()async{

     final SharedPreferences sp = await SharedPreferences.getInstance();
     final String? token  = sp.getString("token");

     return UserModel(
       token: token.toString()
     );
   }

   Future<bool> remove() async{
     final SharedPreferences sp = await SharedPreferences.getInstance();
     sp.clear();
     notifyListeners();
     return true;
   }
}