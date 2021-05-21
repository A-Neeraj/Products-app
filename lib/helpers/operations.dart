import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadingData(
    String _productName, String _productDesc, String _imageUrl) async {
  await FirebaseFirestore.instance.collection("products").add({
    'productName': _productName,
    'productDesc': _productDesc,
    'imageUrl': _imageUrl,
  });
}

Future<void> editProductInfo(
    String prodName, String prodDesc, String imgURL, String id) async {
  await FirebaseFirestore.instance.collection("products").doc(id).update({
    'productName': prodName,
    'productDesc': prodDesc,
    'imageUrl': imgURL,
  });
}

Future<void> deleteProduct(DocumentSnapshot doc) async {
  await FirebaseFirestore.instance.collection("products").doc(doc.id).delete();
}
