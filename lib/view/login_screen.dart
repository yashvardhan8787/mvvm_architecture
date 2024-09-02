import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:mvvm_architecture/res/components/round_buttons.dart";
import "package:mvvm_architecture/utils/routes/routes_names.dart";
import "package:mvvm_architecture/utils/utils.dart";
import "package:mvvm_architecture/view_model/auth_view_model.dart";
import "package:provider/provider.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

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
        title: Text("Login"),
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
            loading: authViewModel.loading,
            onPress: (){
              if(emailController.text.isEmpty){
                Utils.flushBarErrorMessage("email is required ", context);
              }else if(passwordController.text.isEmpty){
                Utils.flushBarErrorMessage("password is required ", context);
              }else if(passwordController.text.length > 6){
                Utils.flushBarErrorMessage("password is to short", context);
              }else{
               Map data ={
                 'email':emailController.toString(),
                 'password':passwordController.toString()
               };

               authViewModel.loginApi(data, context);
              }
            },
          )
        ],
      ),
    );
  }
}
