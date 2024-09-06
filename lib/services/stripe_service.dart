import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:sportwave/const/constant_key.dart';

class StripeService {
  StripeService._();
  static final StripeService instance = StripeService._();

  Future<bool> makePayment(int amount) async {
    try {
      String? result = await createPaymentIntent(amount, "usd");
      if (result == null) return false;

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: result,
              merchantDisplayName: "The Game Before The Game"));

      // Process the payment and return the result
      return await _paymentProcess();
    } catch (e) {
      print("Error during payment: $e");
      return false; // Handle errors and return failure
    }
  }

  Future<String?> createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": _calculateAmount(amount),
        "currency": currency,
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
      return response.data != null ? response.data["client_secret"] : null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  String _calculateAmount(int amount) {
    final calculateAmount = amount * 100;
    return calculateAmount.toString();
  }

  Future<bool> _paymentProcess() async {
    try {
      print("Payment Called");
      await Stripe.instance.presentPaymentSheet();
      print("Payment Successful");
      return true; // Payment succeeded
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        print("Payment Canceled");
      } else {
        print("Payment Failed: $e");
      }
      return false; // Payment failed or canceled
    } catch (e) {
      print("Payment Error: $e");
      return false; // Any other errors
    }
  }
}
