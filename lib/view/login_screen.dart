import "package:flutter/material.dart";
import "package:mvvm_architecture/utils/routes/routes_names.dart";
import "package:mvvm_architecture/utils/utils.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:  CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap:(){
            Utils.toastMessage('no internet');
            Utils.flushBarErrorMessage("your bro yash is here", context);
            },
            child:const  Text("toast Message"),
          ),
          InkWell(
            onTap:(){
             Navigator.pushNamed(context,RoutesNames.home);
            },
            child:const  Text("go to home screen"),
          )
        ],
      ),
    );
  }
}
