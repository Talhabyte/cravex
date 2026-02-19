import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Adminhomepage extends StatefulWidget {
  @override
  State<Adminhomepage> createState() => _adminhome();
}

class _adminhome extends State<Adminhomepage> {
  String? selectedcategory;
  File? selectedimage;
  final ImagePicker picker = ImagePicker();
  List<String> categories = ["Pizza", "Burger", "Icecream", "Salad"];
  TextEditingController itemcontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController detailcontroller = TextEditingController();
  @override
  void initState() {}

  @override
  dispose() {
    itemcontroller.dispose();
    pricecontroller.dispose();
    detailcontroller.dispose();
  }

  Future<void> PickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedimage = File(image.path);
      });
    }
  }

  Future<void> uploadItem() async {
    if (selectedimage == null ||
        itemcontroller.text.isEmpty ||
        pricecontroller.text.isEmpty ||
        detailcontroller.text.isEmpty ||
        selectedcategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields and select image")),
      );
      return;
    }

    try {
      // 1. Prepare image file
      String fileName = selectedimage!.path.split("/").last;
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://cravex-backend-krd3.onrender.com/upload'),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          'file', // field name expected in backend
          selectedimage!.path,
          filename: fileName,
        ),
      );

      // 2. Send the request to Render backend
      var response = await request.send();

      if (response.statusCode == 200) {
        var respStr = await response.stream.bytesToString();
        var imageUrl = jsonDecode(respStr)['url'];

        // 3. Save item to Firestore
        await FirebaseFirestore.instance.collection(selectedcategory!).add({
          'name': itemcontroller.text,
          'price': pricecontroller.text,
          'details': detailcontroller.text,
          'image': imageUrl,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // 4. Success message
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Item added successfully!")));

        // 5. Clear fields
        setState(() {
          selectedimage = null;
          itemcontroller.clear();
          pricecontroller.clear();
          detailcontroller.clear();
          selectedcategory = null;
        });
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Upload failed")));
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went wrong")));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text(
          "Add Item",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Upload the Item Picture",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Center(
                child: GestureDetector(
                  onTap: () {
                    PickImage();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.black, width: 3),
                    ),
                    width: 100,
                    height: 100,
                    child: selectedimage == null
                        ? Center(child: Icon(Icons.camera_alt_outlined))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              selectedimage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Item Name",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: itemcontroller,

                decoration: InputDecoration(
                  hint: Text("Enter item Name"),
                  filled: true,
                  fillColor: Colors.blueGrey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Item Price",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: pricecontroller,

                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blueGrey.shade100,
                  hint: Text("Enter item Price"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Text(
                "Item Details",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: TextField(
                  maxLines: 5,
                  controller: detailcontroller,

                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blueGrey.shade100,
                    hint: Text("Enter item Details"),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                initialValue: selectedcategory,
                hint: Text("Select Category"),
                items: categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedcategory = value;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blueGrey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.blueGrey.shade100,
                  ),
                  onPressed: () {
                    uploadItem();
                  },
                  child: Text(
                    "Add Item",
                    style: TextStyle(fontFamily: "Poppins"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
