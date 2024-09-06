import 'package:flutter/material.dart';
import 'package:mvvm_architecture/view_model/secrvices/SplashServices.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splash = SplashServices();
  @override
  void initState(){
   super.initState();
   splash.checkAuthentication(context);
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("is working"),
          ]
        )
      ),
    );
  }
}
