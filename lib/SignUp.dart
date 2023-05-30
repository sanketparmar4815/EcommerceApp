import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();

  String imagepaty = "";

  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Page"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          InkWell(
              onTap: () {
                final ImagePicker picker = ImagePicker();

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      actions: [
                        IconButton(
                            onPressed: () async {
                              Navigator.pop(context);

                              final XFile? photo = await picker.pickImage(
                                  source: ImageSource.camera, imageQuality: 30);

                              setState(() {
                                imagepaty = photo!.path;
                                status = true;
                              });
                            },
                            icon: Icon(Icons.camera)),
                        IconButton(
                            onPressed: () async {
                              Navigator.pop(context);

                              final XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery,
                                  imageQuality: 20);

                              setState(() {
                                imagepaty = image!.path;
                                status = true;
                              });
                            },
                            icon: Icon(Icons.browse_gallery))
                      ],
                    );
                  },
                );

// Pick an image.

// Capture a photo.
              },
              child: imagepaty != ""
                  ? CircleAvatar(
                      maxRadius: 80,
                      child: Text("IMG"),
                      backgroundImage: FileImage(File(imagepaty)),
                    )
                  : CircularProgressIndicator()),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: name,
              )),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: email,
              )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              controller: number,
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: password,
              )),
          ElevatedButton(
              onPressed: () async {
                List<int> imgbyte = File(imagepaty).readAsBytesSync();
                String imagedadta = base64Encode(imgbyte);

                print("===$imagedadta");

                Map map = {
                  "name": name.text,
                  "email": email.text,
                  "number": number.text,
                  "password": password.text,
                  "imagedata": imagedadta
                };

                var url = Uri.parse(
                    'https://fluttersanket.000webhostapp.com/EcommerceApp/register.php');
                var response = await http.post(url, body: map);
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');
              },
              child: Text("Sign UP"))
        ],
      )),
    );
  }
}
