import 'package:flutter/material.dart';
import 'package:cravex/services/stripe_service.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;

class Wallet extends StatefulWidget {
  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  int walletBalance = 100; // current wallet balance
  int selectedAmount = 100; // amount user wants to add

  @override
  void initState() {
    super.initState();
    // Make sure Stripe publishableKey is already set in main.dart
  }

  @override
  Widget build(BuildContext context) {
    List<int> options = [100, 1000, 1500, 2000];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Wallet",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Wallet Card
            Card(
              child: ListTile(
                leading: Icon(Icons.wallet, color: Colors.green, size: 30),
                title: Text(
                  "Your Wallet",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 18,
                    fontFamily: "Poppins",
                  ),
                ),
                subtitle: Text(
                  "\$$walletBalance",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Add Money",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  fontFamily: "Poppins",
                ),
              ),
            ),
            SizedBox(height: 10),

            // Amount Selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: options.map((amt) {
                bool isSelected = selectedAmount == amt;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAmount = amt;
                    });
                  },
                  child: Card(
                    child: Container(
                      height: 40,
                      width: 50,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.green
                            : Colors.blueGrey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "\$$amt",
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 40),

            // Add Money Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    // 1️⃣ Get PaymentIntent client secret from backend
                    final clientSecret = await createPaymentIntent(
                      selectedAmount,
                    );

                    // 2️⃣ Initialize the PaymentSheet
                    await Stripe.instance.initPaymentSheet(
                      paymentSheetParameters: SetupPaymentSheetParameters(
                        paymentIntentClientSecret: clientSecret,
                        merchantDisplayName: "Food Delivery App",
                        style: ThemeMode.light,
                      ),
                    );

                    // 3️⃣ Present the PaymentSheet
                    await Stripe.instance.presentPaymentSheet();

                    // ✅ Payment Success
                    setState(() {
                      walletBalance += selectedAmount;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Payment Successful")),
                    );
                  } on StripeException catch (e) {
                    // Payment failed or canceled by user
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Payment Cancelled")),
                    );
                  } catch (e) {
                    // Other errors
                    print(e);
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Payment Failed")));
                  } finally {
                    // Optional: reset customer/payment session if needed
                    // Stripe.instance.resetPaymentSheetCustomer(); // uncomment if multiple payments for same customer
                  }
                },
                child: Text("Add Money"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
