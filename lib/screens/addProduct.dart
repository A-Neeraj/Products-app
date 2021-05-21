import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:products_task/main.dart';

import '../helpers/operations.dart';

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  String id;
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescController = TextEditingController();
  String productName;
  String productDesc;
  String imageUrl;

  final picker = ImagePicker();

  var imgpath;
  File _imageFile;

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_imageFile.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    await taskSnapshot.ref.getDownloadURL().then((value) {
      imgpath = value;
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: new LinearGradient(colors: [
            Color.fromARGB(255, 255, 136, 34),
            Color.fromARGB(255, 255, 177, 41)
          ])),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  focusedBorder: new UnderlineInputBorder(
                      borderSide: new BorderSide(
                          color: Colors.blue,
                          width: 2,
                          style: BorderStyle.solid)),
                  labelText: "Product Name",
                  icon: Icon(
                    Icons.assignment,
                    color: Colors.orangeAccent,
                  ),
                  fillColor: Colors.white,
                  labelStyle: TextStyle(
                    color: Colors.blue,
                  )),
              onChanged: (value) {
                productName = value;
              },
              controller: productNameController,
            ),
            TextField(
              maxLines: null,
              decoration: InputDecoration(
                  focusedBorder: new UnderlineInputBorder(
                      borderSide: new BorderSide(
                          color: Colors.blue,
                          width: 2,
                          style: BorderStyle.solid)),
                  labelText: "Product Description",
                  icon: Icon(
                    Icons.assignment,
                    color: Colors.orangeAccent,
                  ),
                  fillColor: Colors.white,
                  labelStyle: TextStyle(
                    color: Colors.blue,
                  )),
              onChanged: (value) {
                productDesc = value;
              },
              controller: productDescController,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                    color: Colors.black26,
                    border: Border.all(
                        width: 2.0,
                        color: Colors.black,
                        style: BorderStyle.solid)),
                child: _imageFile == null
                    ? Center(
                        child: Text(
                        'Choose \nProduct \n Image',
                        style: TextStyle(fontSize: 20),
                      ))
                    : Container(
                        child: Image.file(_imageFile),
                      ),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  pickImage();
                },
                child: Text('Upload Image')),
            Center(
              child: Container(
                // alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: ElevatedButton(
                  onPressed: () async {
                    await uploadImageToFirebase(context);
                    imageUrl = imgpath.toString();
                    await uploadingData(productName, productDesc, imageUrl);
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: const EdgeInsets.all(0),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0),
                        gradient: new LinearGradient(colors: [
                          Color.fromARGB(255, 255, 136, 34),
                          Color.fromARGB(255, 255, 177, 41)
                        ])),
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      "Add Product",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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
