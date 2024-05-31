// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';

import 'package:login/login/login_screen.dart';
import 'package:login/login/sign_up_screen.dart';
import 'package:login/login/forget_pass_screen.dart';
import 'package:login/login/welcome_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  var _activeScreen = 'welcome-screen';

/**void _switchScreen() {

  //if(username == "Admin" && password == "Admin123"){
    setState(() {
      _activeScreen = 'main-app-screen';
    });
  //}
}**/
  void _forgotPasswordScreen() {
    setState(() {
      _activeScreen = 'forgot-password-screen';
    });
  }

  void _signUpScreen() {
    setState(() {
      _activeScreen = 'sign-up-screen';
    });
  }

  void _loginScreen() {
    setState(() {
      _activeScreen = 'login-screen';      
    });
  }


  @override
  Widget build(context) {
    Widget screenWidget =
        LoginScreen(_signUpScreen, _forgotPasswordScreen,);
    String img = 'assets/images/unsplash_hpTH5b6mo2s.png';

    if (_activeScreen == 'sign-up-screen') {
      screenWidget = SignUpScreen(_loginScreen,);
    }

    if (_activeScreen == 'login-screen') {
      screenWidget =
          LoginScreen(_signUpScreen, _forgotPasswordScreen,);
    }

    if (_activeScreen == 'forgot-password-screen') {
      screenWidget = ForgotPasswordScreen(_loginScreen, _signUpScreen,);
    }

    if(_activeScreen == 'welcome-screen'){
      screenWidget = WelcomeScreen(_loginScreen);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: WillPopScope(
          onWillPop: () async {
          bool willLeave = false;
          // show the confirm dialog
          await showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: const Text('Are you sure want to Exit?'),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            willLeave = true;
                            Navigator.of(context).pop();
                          },
                          child: const Text('Yes')),
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('No'))
                    ],
                  ));
          return willLeave;
        },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(img),fit: BoxFit.fill),
            ),
            child: screenWidget,
          ),
        ),
      );
    
  }
}
