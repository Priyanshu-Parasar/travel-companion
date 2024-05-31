import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_fonts/google_fonts.dart';

final _firebaseAuth = FirebaseAuth.instance;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen(this.loginScreen, {super.key});

  final void Function() loginScreen;

  @override
  State<SignUpScreen> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  String uname = '';
  String name = '';
  String email = '';
  String pass = '';
  String cnfpass = '';
  String mobile = '';

  RegExp emailPattern = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  final _formKey = GlobalKey<FormState>();

  Future<void> _saveState() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final userCredentials = await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: pass);
        //print(userCredentials);
        final _userId = userCredentials.user!.uid;
      
        Map<String, String> userData = {
        "userId": _userId,
        "userName": uname,
        "email": email,
        "name": name,
        "mobile": mobile,
        "pass": pass,
        };

        FirebaseFirestore.instance.collection("users")
          .doc(_userId)
          .set(userData)
          .catchError((e) {
        print(e);
      });


      } on FirebaseAuthException catch (error) {
        if (error.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(error.message ?? 'Authentication Failed')));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                'Sign Up',
                style: TextStyle(
                    fontSize: 40,
                    decoration: TextDecoration.underline),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        onSaved: (newValue) {
                          uname = newValue!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'username can not be empty!';
                          } else if (value.trim().length > 20) {
                            return 'username too long';
                          } else if (value.trim().length < 3) {
                            return 'username too short';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                          hintText: 'Username',
                          prefixIcon: Icon(Icons.person),
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
                          name = newValue!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'name can not be empty!';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                          hintText: 'Name',
                          prefixIcon: Icon(Icons.abc_rounded),
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
                          prefixIcon: Icon(Icons.email_sharp),
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
                          mobile = newValue!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'mobile can not be empty!';
                          } else if (value.trim().length != 10) {
                            return 'mobile no. should be between 10 digits';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                          hintText: 'Mobile',
                          prefixIcon: Icon(Icons.phone_android_sharp),
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
                          prefixIcon: Icon(Icons.lock),
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
                          cnfpass = newValue!;
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
                          hintText: 'Confirm Password',
                          prefixIcon: Icon(Icons.lock),
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
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _saveState,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(999, 45),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  //padding: const EdgeInsets.symmetric(horizontal: 120),
                  backgroundColor: const Color.fromARGB(255, 22, 181, 177),
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: widget.loginScreen,
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
