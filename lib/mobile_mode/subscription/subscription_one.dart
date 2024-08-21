import 'package:flutter/material.dart';
import 'package:sportwave/mobile_mode/colors.dart';
import 'package:sportwave/services/stripe_service.dart';
import 'package:sportwave/utils/colors.dart';

class SubscriptionOne extends StatefulWidget {
  const SubscriptionOne({super.key});

  @override
  State<SubscriptionOne> createState() => _SubscriptionOneState();
}

class _SubscriptionOneState extends State<SubscriptionOne> {
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
              "One Month Subscription to get free access of Subscription in just 20 Euro",
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: mainBtnColor,
                  fixedSize: Size(200, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              onPressed: () {
                StripeService.instance.makePayment(20);
              },
              child: Text(
                "Pay \$20",
                style: TextStyle(color: colorwhite),
              ))
        ],
      ),
    );
  }
}
