import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen(this.getStartedBtn, {super.key});

  final void Function() getStartedBtn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Travel Companion',
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              const Image(image: AssetImage('assets/images/Group_1.png')),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton.icon(
                onPressed: getStartedBtn,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(999, 45),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  //padding: const EdgeInsets.symmetric(horizontal: 120),
                  backgroundColor: const Color.fromARGB(255, 22, 181, 177),
                  foregroundColor: Colors.white,
                ),
                label: const Text(
                  'Let\'s Get Started',
                  style: TextStyle(fontSize: 18),
                ),
                icon: const Icon(Icons.arrow_forward_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
