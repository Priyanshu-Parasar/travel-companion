import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/utils/widgets/loading.dart';
// import 'package:login/loading.dart';
//import 'package:google_fonts/google_fonts.dart';

final _firebaseAuth = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen(this.signupBtn, this.forgetPassBtn, {super.key});

  final void Function() signupBtn;
  final void Function() forgetPassBtn;
  //final void Function() _saveData;

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String pass = '';
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  RegExp emailPattern = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      //authentication will be done here
      //     @override
      // Widget build(BuildContext context){
      //   return const LoadingScreen();
      // }

      try {
        setState(() {
          isLoading = true;
        });

        final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: pass);

        //print(userCredential);
      } on FirebaseAuthException catch (error) {
        //print('------------------------here-----------------\n$error\n');
        if (error.code == 'wrong-password') {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.message ?? 'Authentication Failed'),
            ),
          );

          await Future.delayed(const Duration(milliseconds: 500));
          setState(() {
            isLoading = false;
          });
        } else if (error.code == 'user-not-found') {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
           const  SnackBar(
              content: Text('Authentication Failed : user does not exist'),
            ),
          );
          await Future.delayed(const Duration(milliseconds: 500));
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (isLoading)
            const Expanded(
              child: LoadingScreen(),
            )
          else
            Card(
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
                      'Login',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 40,
                          decoration: TextDecoration.underline),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            onSaved: (newValue) {
                              email = newValue!;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email cannot be empty!';
                              } else if (!emailPattern.hasMatch(value)) {
                                return 'Invalid email!';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 255, 255, 255),
                              hintText: 'Email',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                gapPadding: 10,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                            ),
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            onSaved: (newValue) {
                              pass = newValue!;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'password can not be empty!';
                              } else if (value.trim().length > 10 ||
                                  value.trim().length < 4) {
                                return 'password should be between 4-10 characters';
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 255, 255, 255),
                              hintText: 'Password',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                gapPadding: 10,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                            ),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: _saveData,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(999, 45),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        //padding: const EdgeInsets.symmetric(horizontal: 120),
                        backgroundColor:
                            const Color.fromARGB(255, 22, 181, 177),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Login',
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
                          onPressed: widget.signupBtn,
                          child: const Text(
                            'SignUp',
                            style:
                                TextStyle(color: Color.fromARGB(235, 0, 0, 0)),
                          ),
                        ),
                        TextButton(
                          onPressed: widget.forgetPassBtn,
                          child: const Text(
                            'Forgot Password ?',
                            style:
                                TextStyle(color: Color.fromARGB(235, 0, 0, 0)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
