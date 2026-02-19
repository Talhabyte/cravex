import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> createPaymentIntent(int amount) async {
  final response = await http.post(
    Uri.parse("https://stripe-backend-p481.onrender.com/create-payment-intent"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"amount": amount}),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to create PaymentIntent: ${response.body}');
  }

  return jsonDecode(response.body)["clientSecret"];
}
