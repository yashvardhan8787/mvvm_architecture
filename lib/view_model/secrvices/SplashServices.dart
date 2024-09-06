import 'package:flutter/cupertino.dart';
import 'package:mvvm_architecture/view_model/user_view_model.dart';

import '../../model/UserModel.dart';
import '../../utils/routes/routes_names.dart';

class SplashServices{
  Future<UserModel> getUserDate()=>UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    try {
      // Get user data from SharedPreferences
      UserModel user = await getUserDate();

      // Debugging: Log the token for confirmation
      print("Debug: User token received - ${user.token}");

      // Check if the token is null or empty
      if (user.token == "null" || user.token!.isEmpty) {
        print("Debug: Token is null or empty. Navigating to Login.");

        // Simulate loading time before navigation
        await Future.delayed(Duration(seconds: 3));

        // Navigate to login screen
        Navigator.pushNamed(context, RoutesNames.login);
      } else {
        print("Debug: Token is valid. Navigating to Home.");

        // Simulate loading time before navigation
        await Future.delayed(Duration(seconds: 3));

        // Navigate to home screen
        Navigator.pushNamed(context, RoutesNames.home);
      }
    } catch (error, stackTrace) {
      // Error handling: Log the error and stack trace
      print("Error during authentication check: $error");
      print("StackTrace: $stackTrace");
    }
  }


}