import 'package:flutter/material.dart';
import 'package:cravex/screens/fooddetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cravex/services/database.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedCategory = "Pizza";
  bool icecream = false, pizza = true, salad = false, burger = false;
  Stream? fooditemStream;

  Future<void> loadFood(String category) async {
    fooditemStream = await DatabaseMethods().getFoodItem(category);
    setState(() {});
  }

  @override
  void initState() {
    loadFood("Pizza");
    super.initState();
  }

  Widget allItems() {
    return StreamBuilder(
      stream: fooditemStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => fooddetails(
                      image: ds["image"],
                      name: ds["name"],
                      details: ds["details"],
                      price: ds["price"],
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 5,
                margin: EdgeInsets.only(right: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Container(
                  width: 200,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          child: Image.network(
                            ds["image"],
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        ds["name"],
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        ds["details"],
                        style: TextStyle(fontFamily: "Poppins"),
                      ),
                      Text(
                        "\$${ds["price"]}",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget verticalItems() {
    return StreamBuilder(
      stream: fooditemStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];

            return Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 15),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          ds["image"],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ds["name"],
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(ds["details"]),
                            Text(
                              "\$${ds["price"]}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.only(left: 20, top: 10),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Hello Talha,",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Icon(Icons.shopping_cart_rounded),
              ),
            ],
          ),

          SizedBox(height: 20),

          Text(
            "Delicious Food",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),

          Text(
            "Discover and Get Great Food",
            style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
          ),

          SizedBox(height: 15),

          showselecetedscreen(),

          SizedBox(height: 20),

          SizedBox(height: 270, child: allItems()),

          SizedBox(height: 20),

          verticalItems(),
        ],
      ),
    );
  }

  Widget showselecetedscreen() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        categoryButton("Icecream", "assets/Images/cone.png", icecream),
        categoryButton("Pizza", "assets/Images/pitza.png", pizza),
        categoryButton("Salad", "assets/Images/salads.png", salad),
        categoryButton("Burger", "assets/Images/b4burger.png", burger),
      ],
    );
  }

  Widget categoryButton(String category, String image, bool active) {
    return GestureDetector(
      onTap: () async {
        icecream = pizza = salad = burger = false;
        if (category == "Icecream") icecream = true;
        if (category == "Pizza") pizza = true;
        if (category == "Salad") salad = true;
        if (category == "Burger") burger = true;

        await loadFood(category);
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: active ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(child: Image.asset(image, width: 35, height: 35)),
        ),
      ),
    );
  }
}
