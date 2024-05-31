import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(120, 100, 100, 100),
            Color.fromARGB(120, 100, 100, 100),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
                color: Color.fromARGB(255, 255, 255, 255)),
            Center(
              child: Text(
                'Loading',
                style: TextStyle(color: Color.fromARGB(255, 186, 186, 186)),
              ),
            ),
          ]),
    );
  }
}
