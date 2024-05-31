import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen(this.loginScreen, this.signUpScreen, {super.key});

  final void Function() loginScreen;

  final void Function() signUpScreen;

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _firebaseAuth = FirebaseAuth.instance;

  RegExp emailPattern = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  var email = '';

  final _formKey = GlobalKey<FormState>();

  Future sendResetPassLink() async {
    var user = _firebaseAuth.currentUser;

    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reset Email has been sent!')));
          await Future.delayed(const Duration(seconds: 1));
          widget.loginScreen();
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? "Error sending mail !")),);
    }
  }

  @override
  Widget build(context) {
    return Center(
      child: Card(
        color: const Color.fromARGB(160, 228, 236, 255),
        elevation: 10,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Forgot Password ?',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 30,
                    decoration: TextDecoration.underline),
              ),
              const SizedBox(
                height: 30,
              ),
              // const TextField(
              //   decoration: InputDecoration(
              //     filled: true,
              //     fillColor: Color.fromARGB(255, 255, 255, 255),
              //     hintText: 'Username',
              //     prefixIcon: Icon(Icons.person),
              //     contentPadding: EdgeInsets.symmetric(horizontal: 20),
              //     border: OutlineInputBorder(
              //       borderSide: BorderSide.none,
              //       gapPadding: 10,
              //       borderRadius: BorderRadius.all(Radius.circular(50)),
              //     ),
              //   ),
              //   maxLines: 1,
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
              Form(
                key: _formKey,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email cannot be empty!';
                    } else if (!emailPattern.hasMatch(value)) {
                      return 'Invalid email!';
                    }
                  },
                  onSaved: (newValue) {
                    email = newValue!;
                  },
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 255, 255, 255),
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email_sharp),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      gapPadding: 10,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // TextFormField(
              //   keyboardType: TextInputType.phone,
              //   decoration: const InputDecoration(
              //     filled: true,
              //     fillColor: Color.fromARGB(255, 255, 255, 255),
              //     hintText: 'Mobile',
              //     prefixIcon: Icon(Icons.phone_android_sharp),
              //     contentPadding: EdgeInsets.symmetric(horizontal: 20),
              //     border: OutlineInputBorder(
              //       borderSide: BorderSide.none,
              //       gapPadding: 10,
              //       borderRadius: BorderRadius.all(Radius.circular(50)),
              //     ),
              //   ),
              //   maxLines: 1,
              // ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: sendResetPassLink,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(999, 45),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  //padding: const EdgeInsets.symmetric(horizontal: 120),
                  backgroundColor: const Color.fromARGB(255, 22, 181, 177),
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Reset',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: widget.signUpScreen,
                    child: const Text(
                      'SignUp',
                      style: TextStyle(color: Color.fromARGB(235, 0, 0, 0)),
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  TextButton(
                    onPressed: widget.loginScreen,
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Color.fromARGB(235, 0, 0, 0)),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
