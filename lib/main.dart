import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:login/login/verify_email.dart';
import 'package:login/main_dashboard/main_dashboard.dart';
import 'package:login/utils/widgets/loading.dart';
import 'firebase_options.dart';
import 'package:login/login/login.dart';

void main() async {

  WidgetsBinding widgetBindings = WidgetsFlutterBinding.ensureInitialized();
 

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.preserve(widgetsBinding: widgetBindings);
  
  runApp(const App());
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Companion',
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapShot) {
            Widget screenWidget = const Login();

            if (snapShot.connectionState == ConnectionState.waiting) {
              screenWidget = const LoadingScreen();
            }

            if (snapShot.hasData) {
              Future.delayed(const Duration(seconds: 2));
              return const VerifyEmail();
            }

            return screenWidget; //
          }),
    );
  }
}
