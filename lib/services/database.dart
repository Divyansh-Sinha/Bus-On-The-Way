import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String? uid;
  
  List studentsList = [];
  
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference busUserCollection =
      FirebaseFirestore.instance.collection('Bus Users');

  Future updateUserData(String name, String email,String password,
  String busStop, String payment) async {
    return await busUserCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'Bus Stop': busStop, 'Email': email, 'Password': password, 'Full Name': name, 'Payment': payment});
  }

  //get users data stream
  Stream<QuerySnapshot> get users {
    return busUserCollection.snapshots();
  }

  Future getData() async {
    try {
      //to get data from a single/particular document alone.
      // var temp = await collectionRef.doc("<your document ID here>").get();

      // to get data from all documents sequentially
      await busUserCollection.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          studentsList.add(result.data());
        }
      });

      return studentsList;
    } catch (e) {
      print("Error - $e");
      return e;
    }
  }
  
}
