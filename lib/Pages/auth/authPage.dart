import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'signUp.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
   void toggleScreens(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  bool showLoginPage = true;
  @override
  Widget build(BuildContext context) {
     if (showLoginPage){
      return Login(showRegisterPage: toggleScreens);
    } else{
      return SignUp(showLoginPage: toggleScreens );
    }
  }
}