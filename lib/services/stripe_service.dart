// import 'dart:convert';

// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:http/http.dart' as http;

// class StripeService {
//   /// Replace with your Stripe secret key on your backend (never hardcode in client)
//   final String backendUrl =
//       "https://console.cloud.google.com/iam-admin/iam?project=eourpean-single-muslilm";

//   Future<bool> makePayment({
//     required int amount,
//     required String currency,
//   }) async {
//     try {
//       final paymentIntent = await _createPaymentIntent(amount, currency);

//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: paymentIntent['client_secret'],
//           merchantDisplayName: 'european_single_marriage',
//         ),
//       );

//       await Stripe.instance.presentPaymentSheet();

//       return true;
//     } catch (e) {
//       print("Stripe Payment Error: $e");
//       return false;
//     }
//   }

//   Future<Map<String, dynamic>> _createPaymentIntent(
//     int amount,
//     String currency,
//   ) async {
//     final response = await http.post(
//       Uri.parse(backendUrl),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'amount': amount * 100, 'currency': currency}),
//     );
//     return jsonDecode(response.body);
//   }
// }


import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripeService {
  final String secretKey =
      "sk_test_51QDKC1CdCbJv0pMUo9jEbVqJvTKShcpCPdlqObLI6HbcnAEBiP6m3vXojN5YOlzDHnTFXwK0xIIzdC9SzpBcQfhZ002iya9y6W";

  Future<bool> makePayment({
    required int amount,
    required String currency,
  }) async {
    try {
      // 1️⃣ Create PaymentIntent via Stripe API
      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'amount': (amount * 100).toString(), // cents
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
