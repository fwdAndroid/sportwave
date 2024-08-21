import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sportwave/mobile_mode/auth/login_screen.dart';

class SettingMobilePage extends StatefulWidget {
  const SettingMobilePage({super.key});

  @override
  State<SettingMobilePage> createState() => _SettingMobilePageState();
}

class _SettingMobilePageState extends State<SettingMobilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset("assets/logo.png"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              onTap: () async {
                await FirebaseAuth.instance.signOut();

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (builder) => LoginScreen()));
              },
              title: Text("Logout"),
              leading: Icon(Icons.logout),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          )
        ],
      ),
    );
  }
}
