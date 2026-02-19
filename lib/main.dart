import 'package:cravex/admin/adminhomepage.dart';
import 'package:cravex/screens/bottomvav.dart';
import 'package:cravex/screens/login.dart';
import 'package:cravex/screens/onboarding.dart';
import 'package:cravex/screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/hompage.dart';
import 'widgets/app_constant.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import "package:cravex/admin/adminlogin.dart";

import "package:cravex/admin/additemscreen.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishedkey;
  Stripe.merchantIdentifier = 'merchant.com.yourapp';
  Stripe.instance.applySettings();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CraveX',
      debugShowCheckedModeBanner: false,
      home: Onboarding(),
    );
  }
}
