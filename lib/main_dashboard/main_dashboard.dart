import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/main_dashboard/blog_home.dart';
import 'package:login/main_dashboard/home_dashboard.dart';
import 'package:login/main_dashboard/settings.dart';
import 'package:login/utils/widgets/loading.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var _selectedIndex = 0;
  Widget widgetScreen = const Dashboard();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // widgetScreen = const LoadingScreen();
    // Future.delayed(const Duration(milliseconds: 400));

    if (_selectedIndex == 2) {
      widgetScreen = const SettingsPage2();
    } else if (_selectedIndex == 1) {
      widgetScreen = const BlogHomePage();
    } else {
      widgetScreen = const Dashboard();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Companion'),
        // actions: [
        //   IconButton(

        //       icon: const Icon(Icons.logout_sharp))
        // ],
      ),
      body: WillPopScope(
          onWillPop: () async {
            bool willLeave = false;
            // show the confirm dialog
            await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: const Text('Are you sure want to Exit the app?'),
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
          child: widgetScreen),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.messenger_rounded),
          label: 'Blog',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ], currentIndex: _selectedIndex, onTap: _onItemTapped),
    );
  }
}
