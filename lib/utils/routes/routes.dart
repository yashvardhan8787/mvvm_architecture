import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_architecture/utils/routes/routes_names.dart';
import 'package:mvvm_architecture/view/home_screen.dart';
import 'package:mvvm_architecture/view/login_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings){

    switch(settings.name){
      case RoutesNames.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen(),);

      case RoutesNames.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen(),);


      default:
        return MaterialPageRoute(builder: (context) {
          return const  Scaffold(
            body: Center(
              child: Text("No route defined"),
            ),
          );
        },);
    }


  }

}