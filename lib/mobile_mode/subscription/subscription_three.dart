import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sportwave/mobile_mode/colors.dart';
import 'package:sportwave/mobile_mode/main/home_page_mobile.dart';
import 'package:sportwave/mobile_mode/main/main_dashboard.dart';
import 'package:sportwave/services/stripe_service.dart';
import 'package:sportwave/utils/colors.dart';

class SubscriptionThree extends StatefulWidget {
  const SubscriptionThree({super.key});

  @override
  State<SubscriptionThree> createState() => _SubscriptionThreeState();
}

class _SubscriptionThreeState extends State<SubscriptionThree> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          isLoading
              ? CircularProgressIndicator(color: colorwhite)
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainBtnColor,
                    fixedSize: Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await StripeService.instance.makePayment(50);
                    setState(() {
                      isLoading = false;
                    });
                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update({"isPaid": true}).then((onValue) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => MainDashboard()));
                    });
                  },
                  child: Text(
                    "Pay \$50",
                    style: TextStyle(color: colorwhite),
                  ),
                ),
        ],
      ),
    );
  }
}
