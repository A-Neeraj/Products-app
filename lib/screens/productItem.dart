import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:products_task/screens/editProduct.dart';

import '../helpers/operations.dart';

class ProductItem extends StatefulWidget {
  final String productName;
  final String productDesc;
  final String imageUrl;
  final String id;
  final DocumentSnapshot documentSnapshot;
  ProductItem({
    @required this.imageUrl,
    @required this.documentSnapshot,
    @required this.id,
    @required this.productName,
    @required this.productDesc,
  });

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            widget.productName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 25),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            "${widget.productDesc}",
                            maxLines: null,
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => editProduct(
                                            productName: widget.productName,
                                            productDesc: widget.productDesc,
                                            prodID: widget.id,
                                            imgURL: widget.imageUrl,
                                          )));
                                }),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                deleteProduct(widget.documentSnapshot);
                              },
                            )
                          ],
                        ),
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // gradient: new LinearGradient(colors: [
            //   Color.fromARGB(255, 255, 136, 34),
            //   Color.fromARGB(255, 255, 177, 41)
            // ]),
            gradient: new LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [
                  0.2,
                  0.5,
                  0.8,
                  0.7
                ],
                colors: [
                  Colors.blue[100],
                  Colors.blue[200],
                  Colors.blue[300],
                  Colors.blue[400]
                ])),
      ),
    );
  }
}
