import 'package:bus_on_the_way/screens/studentHome/studentProfile.dart';
import 'package:bus_on_the_way/services/database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Try extends StatefulWidget {
  const Try({Key? key}) : super(key: key);

  @override
  State<Try> createState() => _TryState();
}
List dataList = [];
class _TryState extends State<Try> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: DatabaseService().getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              "Something went wrong",
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            dataList = snapshot.data as List;
            print(FirebaseAuth.instance.currentUser!.email);
            return StudentProfile(dataList: dataList,);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
