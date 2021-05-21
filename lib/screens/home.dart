import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:products_task/screens/productItem.dart';

import 'addProduct.dart';
import 'login.dart';

class products extends StatefulWidget {
  @override
  _productsState createState() => _productsState();
}

class _productsState extends State<products> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.blue,
                height: 80,
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 30),
                      child: Icon(
                        Icons.list,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, left: 30),
                      child: Text(
                        "Drawer",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.orangeAccent,
                ),
                title: Text(
                  "Home Page",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // Navigator.of(context).pushReplacement(
                  //     MaterialPageRoute(builder: (context) => products()));
                },
              ),
              Divider(
                height: 10,
                color: Colors.black,
                indent: 65,
              ),
              ListTile(
                leading: Icon(
                  Icons.add_box,
                  color: Colors.orangeAccent,
                ),
                title: Text(
                  "Add Products ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => AddUser()));
                },
              ),
              Divider(
                height: 10,
                indent: 65,
                color: Colors.black,
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("GADGETS LIST"),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                GoogleSignIn().signOut().then((value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                  FirebaseAuth.instance.signOut();
                });
              },
            )
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: new LinearGradient(colors: [
              Color.fromARGB(255, 255, 136, 34),
              Color.fromARGB(255, 255, 177, 41)
            ])),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("products").snapshots(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot data = snapshot.data.docs[index];
                      return ProductItem(
                        documentSnapshot: data,
                        id: data.id,
                        imageUrl: data['imageUrl'],
                        productName: data['productName'],
                        productDesc: data['productDesc'],
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
