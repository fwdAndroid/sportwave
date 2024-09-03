import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:sportwave/const/constant_key.dart';

class StripeService {
  StripeService._();
  static final StripeService instance = StripeService._();
  Future<void> makePayment(int amount) async {
    try {
      String? result = await createPaymentIntent(amount, "usd");
      print("sdd$result");
      if (result == null) return;
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: result,
              merchantDisplayName: "The Game Before The Game"));
      await _paymentProcess();
      print(result);
    } catch (E) {
      print(E);
    }
  }

  Future<String?> createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": _calculateAmount(amount),
        "currency": currency
      };
      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $secretKey",
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
      );
      print(response.data);
      if (response.data != null) {
        print("response.data");
        //  print("Payment Response: " + response.data);
        return response.data["client_secret"];
      }
      return null;
    } catch (E) {
      print(E);
    }
    return null;
  }

  String _calculateAmount(int amount) {
    final calculateAmount = amount * 100;
    return calculateAmount.toString();
  }

  Future<void> _paymentProcess() async {
    try {
      print("Payment Called");
      await Stripe.instance.presentPaymentSheet();
      print("Open");
      // Stripe.instance.confirmPaymentSheetPayment();
      print("DOne");
    } catch (e) {
      print(e);
    }
  }
}
