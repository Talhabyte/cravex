import 'package:flutter/material.dart';
import 'package:cravex/screens/hompage.dart';
import 'package:cravex/screens/order.dart';
import 'package:cravex/screens/profile.dart';
import 'package:cravex/screens/wallet.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Bottomnavigation extends StatefulWidget {
  @override
  State<Bottomnavigation> createState() => _BottomNavigation();
}

class _BottomNavigation extends State<Bottomnavigation> {
  int currenttabindex = 0;
  late List<Widget> pages;
  late Widget currentpage;
  late MyHomePage home;
  late Order order;
  late Wallet wallet;
  late Profile profile;
  @override
  void initState() {
    home = MyHomePage();
    order = Order();
    wallet = Wallet();
    profile = Profile();
    pages = [home, order, wallet, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.black,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currenttabindex = index;
          });
        },
        items: [
          Icon(Icons.home_outlined, color: Colors.black),
          Icon(Icons.shopping_bag_outlined, color: Colors.black),
          Icon(Icons.wallet_outlined, color: Colors.black),
          Icon(Icons.person_outline, color: Colors.black),
        ],
      ),
      body: pages[currenttabindex],
    );
  }
}
