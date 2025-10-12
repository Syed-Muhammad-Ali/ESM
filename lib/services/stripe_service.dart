import 'dart:convert';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripeService {
  // final String? secretKey = dotenv.env['STRIPE_SECRET_KEY'];
  final String? secretKey =
      'sk_test_51QDKC1CdCbJv0pMUo9jEbVqJvTKShcpCPdlqObLI6HbcnAEBiP6m3vXojN5YOlzDHnTFXwK0xIIzdC9SzpBcQfhZ002iya9y6W';

  Future<bool> makePayment({
    required int amount,
    required String currency,
  }) async {
    try {
      // 1️⃣ Create PaymentIntent via Stripe API
      final int finalAmount = amount * 100;
      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'amount': finalAmount.toString(),
          'currency': currency,
          'payment_method_types[]': 'card',
        },
      );

      if (response.statusCode != 200) {
        print('Failed to create PaymentIntent: ${response.body}');
        return false;
      }

      final paymentIntent = jsonDecode(response.body);

      // 2️⃣ Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          merchantDisplayName: 'european_single_marriage',
          // style: ThemeMode.light,
        ),
      );

      // 3️⃣ Present Payment Sheet
      await Stripe.instance.presentPaymentSheet();

      return true;
    } catch (e) {
      print("Payment failed: $e");
      return false;
    }
  }
}
