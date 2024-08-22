import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sportwave/mobile_mode/auth/login_screen.dart';
import 'package:sportwave/mobile_mode/colors.dart';
import 'package:sportwave/mobile_mode/main/main_dashboard.dart';
import 'package:sportwave/mobile_mode/subscription/subscription_one.dart';
import 'package:sportwave/mobile_mode/subscription/subscription_three.dart';

class SubscriptionPageMobile extends StatefulWidget {
  const SubscriptionPageMobile({super.key});

  @override
  State<SubscriptionPageMobile> createState() => _SubscriptionPageMobileState();
}

class _SubscriptionPageMobileState extends State<SubscriptionPageMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 300,
              width: 300,
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logo.png",
                      height: 150,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "One Month Subscription to get free access of Subscription in just 20 Euro",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => SubscriptionOne()));
                        // await FirebaseFirestore.instance
                        //     .collection("users")
                        //     .doc(FirebaseAuth.instance.currentUser!.uid)
                        //     .update({"isPaid": true});
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //     content: Text(
                        //         "You Just Paid 20 euro for one month Subscription")));
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (builder) => MainDashboard()));
                      },
                      child: Text(
                        "Pay",
                        style: TextStyle(color: colorWhite),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: mainBtnColor),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 300,
              width: 300,
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logo.png",
                      height: 150,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Three Month Subscription to get free access of Subscription in just 50 Euro",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => SubscriptionThree()));
                      },
                      child: Text(
                        "Pay",
                        style: TextStyle(color: colorWhite),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: mainBtnColor),
                    )
                  ],
                ),
              ),
            ),
          ),
          Center(
              child:
                  TextButton(onPressed: _showMyDialog, child: Text("Cancel"))),
        ],
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('If you wont subscribe you are unable to use the website'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (builder) => LoginScreen()));
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
