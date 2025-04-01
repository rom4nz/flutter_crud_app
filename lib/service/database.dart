import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  //CREATE
  Future addData(Map<String, dynamic> dataInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Data")
        .doc(id)
        .set(dataInfoMap);
  }

  //READ
  Future<Stream<QuerySnapshot>> getData() async {
    return await FirebaseFirestore.instance.collection("Data").snapshots();
  }

  //UPDATE
  Future updateData(String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("Data")
        .doc(id)
        .update(updateInfo);
  }

  //DELETE
  Future deleteData(String id) async {
    return await FirebaseFirestore.instance.collection("Data").doc(id).delete();
  }
}
