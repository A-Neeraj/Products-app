import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:products_task/main.dart';

import '../helpers/operations.dart';

class editProduct extends StatefulWidget {
  final String imgURL;
  final String productName;
  final String productDesc;
  final String prodID;
  const editProduct({
    Key key,
    this.imgURL,
    this.productName,
    this.productDesc,
    this.prodID,
  }) : super(key: key);

  @override
  _editProductState createState() => _editProductState();
}

class _editProductState extends State<editProduct> {
  TextEditingController productNameInputController =
      new TextEditingController();
  TextEditingController productDescInputController =
      new TextEditingController();
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
  initState() {
    productNameInputController.text = widget.productName;
    productDescInputController.text = widget.productDesc;
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: new LinearGradient(colors: [
              Color.fromARGB(255, 255, 136, 34),
              Color.fromARGB(255, 255, 177, 41)
            ])),
          ),
          title: Text("Edit Product"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product Name',
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 15,
                  ),
                ),
                TextField(
                    controller: productNameInputController,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                    )),
                Text(
                  'Product Description',
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 15,
                  ),
                ),
                TextField(
                    maxLines: null,
                    controller: productDescInputController,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                    )),
                Center(
                  child: Padding(
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
                          ? GestureDetector(
                              onTap: () async {
                                pickImage();
                              },
                              child: Container(
                                child: Image.network(widget.imgURL),
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                pickImage();
                              },
                              child: Container(
                                child: Image.file(_imageFile),
                              ),
                            ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    // alignment: Alignment.centerRight,
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_imageFile != null) {
                          await uploadImageToFirebase(context);
                          imgpath = imgpath.toString();
                        } else
                          imgpath = widget.imgURL;
                        await editProductInfo(
                            productNameInputController.text,
                            productDescInputController.text,
                            imgpath,
                            widget.prodID);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => MyHomePage()));
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
                          "Update",
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
        ),
      ),
    );
  }
}
