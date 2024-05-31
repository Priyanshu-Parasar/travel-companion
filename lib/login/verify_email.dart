import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../main_dashboard/main_dashboard.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<StatefulWidget> createState() {
    return VerifyEmailState();
  }
}

class VerifyEmailState extends State<VerifyEmail> {
  var _isEmailVerified;
  final _user = FirebaseAuth.instance;
  var timer;

  @override
  void initState() {
    _isEmailVerified = _user.currentUser!.emailVerified;

    if (!_isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerified());
    }
    super.initState();
  }

  checkEmailVerified() async {


    await _user.currentUser!.reload();
    
    setState(() {
      _isEmailVerified = _user.currentUser!.emailVerified;
      //print(_isEmailVerified);
    });

    if (_isEmailVerified) {
      timer?.cancel();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  sendVerificationEmail() async {
    try {
      await _user.currentUser!.sendEmailVerification();

      setState(() {
        canResendEmail = false;
      });

      await Future.delayed(const Duration(seconds: 5));

      setState(() {
        canResendEmail = true;
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Authentication Failed'),
        ),
      );
    }
  }

  var canResendEmail = false;

  @override
  Widget build(BuildContext context) => _isEmailVerified
      ? const Home()
      : Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Email Verification is pending !"),
                const Text("Email verification link has been sent"),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: canResendEmail ? sendVerificationEmail : null,
                  child: const Text("Resend Email"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: sendToLoginPage, child: Text("cancel")),
              ],
            ),
          ),
        );

  void sendToLoginPage() {
    FirebaseAuth.instance.signOut();
  }
}
