import 'package:cravex/screens/login.dart';
import 'package:cravex/screens/signup.dart';
import 'package:flutter/material.dart';
import '../widgets/content_model.dart';

class Onboarding extends StatefulWidget {
  @override
  State<Onboarding> createState() => _Onboarding();
}

class _Onboarding extends State<Onboarding> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: content.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.asset(content[index].image, height: 300),
                      ),
                      SizedBox(height: 20),
                      Text(
                        content[index].title,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        content[index].subtitle,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          content.length,
                          (dotIndex) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            width: _currentPage == dotIndex ? 12 : 8,
                            height: _currentPage == dotIndex ? 12 : 8,
                            decoration: BoxDecoration(
                              color: _currentPage == dotIndex
                                  ? Colors.orange
                                  : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_currentPage < content.length - 1) {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => signup()),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFff5c30),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
            child: Text(
              _currentPage == content.length - 1 ? "Get Started" : "Next",
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
