import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage2 extends StatefulWidget {
  const SettingsPage2({Key? key}) : super(key: key);

  @override
  State<SettingsPage2> createState() => _SettingsPage2State();
}

class _SettingsPage2State extends State<SettingsPage2> {
  bool _isDark = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              _CustomListTile(
                  title: "Help & Feedback",
                  icon: Icons.help_outline_rounded),
              _CustomListTile(
                  title: "About", icon: Icons.info_outline_rounded),
              _CustomListTile(
                  title: "Sign out", icon: Icons.exit_to_app_rounded,onTap:  () { 
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to log out?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Add your logout logic here
                              // For example, you might call a function to sign out the user
                              // AuthProvider.signOut();
                              FirebaseAuth.instance.signOut();
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: const Text('Logout'),
                          ),
                        ],
                      );
                    });
              },),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final onTap;
  const _CustomListTile(
      {Key? key, required this.title, required this.icon, this.trailing , this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

// class _SingleSection extends StatelessWidget {
//   final String? title;
//   final List<Widget> children;
//   const _SingleSection({
//     Key? key,
//     this.title,
//     required this.children,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (title != null)
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               title!,
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           ),
//         Column(
//           children: children,
//         ),
//       ],
//     );
//   }
// }