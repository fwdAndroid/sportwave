import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sportwave/mobile_mode/colors.dart';
import 'package:sportwave/mobile_mode/main/main_dashboard.dart';
import 'package:sportwave/services/stripe_service.dart';
import 'package:sportwave/utils/colors.dart';

class SubscriptionOne extends StatefulWidget {
  const SubscriptionOne({super.key});

  @override
  State<SubscriptionOne> createState() => _SubscriptionOneState();
}

class _SubscriptionOneState extends State<SubscriptionOne> {
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
          const Padding(
            padding: EdgeInsets.all(8.0),
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
                    fixedSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });

                    // Attempt to process the payment
                    bool isPaymentSuccessful =
                        await StripeService.instance.makePayment(20);

                    if (isPaymentSuccessful) {
                      // Payment successful, update Firebase and navigate to MainDashboard
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({"isPaid": true}).then((onValue) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => MainDashboard()));
                      });
                    } else {
                      // Payment failed or canceled, show a message or handle accordingly
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Payment was canceled or failed")),
                      );
                    }

                    setState(() {
                      isLoading = false;
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
