import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_architecture/utils/utils.dart';
import 'package:provider/provider.dart';

import '../res/components/round_buttons.dart';
import '../utils/routes/routes_names.dart';
import '../view_model/auth_view_model.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupScreen> {

  ValueNotifier<bool> _obsecurePassWord = ValueNotifier<bool>(true);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode= FocusNode();
  FocusNode passwordFocusNode= FocusNode();

  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _obsecurePassWord.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    final height = MediaQuery.of(context).size.height * 1.0 ;
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:  CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            focusNode:emailFocusNode,
            decoration: InputDecoration(
                hintText:"Email" ,
                labelText:"Email" ,
                prefixIcon: Icon(Icons.alternate_email_rounded)
            ),
            onFieldSubmitted: (value){
              Utils.filedFocusChange(context, emailFocusNode, passwordFocusNode);
            },
          ),
          ValueListenableBuilder(
              valueListenable: _obsecurePassWord,
              builder: (context, value , child) {
                return TextFormField(
                  controller: passwordController,
                  obscureText:_obsecurePassWord.value,
                  focusNode: passwordFocusNode,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                      hintText: "Password",
                      labelText: "Password",
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: InkWell(
                          onTap: (){
                            _obsecurePassWord.value = !_obsecurePassWord.value;
                          },
                          child:_obsecurePassWord.value? Icon(Icons.visibility_off):Icon(Icons.visibility))
                  ),
                );
              }
          ),
          SizedBox(height: height * .1,),
          RoundButtons(
            title: "Login",
            loading: authViewModel.signuploading,
            onPress: () {
              if (emailController.text.isEmpty) {
                Utils.flushBarErrorMessage("Email is required", context);
              } else if (passwordController.text.isEmpty) {
                Utils.flushBarErrorMessage("Password is required", context);
              } else if (passwordController.text.length < 6) { // Corrected condition
                Utils.flushBarErrorMessage("Password is too short", context);
              } else {
                Map<String, String> data = {
                  'email': emailController.text, // Corrected text extraction
                  'password': passwordController.text, // Corrected text extraction
                };

                authViewModel.signupApi(data, context);
              }
            },
          ),
          SizedBox( height: height * 0.002,),
          InkWell(
              onTap:(){
                Navigator.pushNamed(context, RoutesNames.login);
              },
              child: Text("Already have an account? login"))
        ],
      ),
    );
  }
}
