
import 'package:bus_on_the_way/CustomComponents/labeled_text.dart';
import 'package:bus_on_the_way/CustomComponents/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:bus_on_the_way/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bus_on_the_way/screens/studentHome/try.dart';


 final CollectionReference busUserCollection = FirebaseFirestore.instance.collection('bus');

String role = '';

List studentList=[];
 getData() async {
   print("In getData");
    try {
      //to get data from a single/particular document alone.
      // var temp = await collectionRef.doc("<your document ID here>").get();

      // to get data from all documents sequentially
      await busUserCollection.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          studentList.add(result.data());
          
          
        }
      });
    } catch (e) {
       print("Error - ${e}");
    }
  }

class StudentProfile extends StatefulWidget {
  List  dataList;
  StudentProfile({required this.dataList});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  @override
  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(4, 9, 35, 1),
                Color.fromRGBO(39, 105, 171, 1),
              ],
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
            ),
          ),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Student Profile",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: 'OleoScript'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: height * 0.72,
                        // color: Colors.black,
                        child: LayoutBuilder(builder: (context, constraints) {
                          double innerHeight = constraints.maxHeight;
                          double innerWidth = constraints.maxWidth;
                          return Stack(
                            children: [
                              Positioned(
                                top: 90,
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  height: innerHeight,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: AssetImage('images/bgImage.png'),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 50,
                                      ),
                                      LabeledText(
                                        label: "Full Name",
                                         text: "ANki"
                                      ),
                                      LabeledText(
                                        label: "Email",
                                         text: "ANki@gmail.com"
                                      ),
                                      LabeledText(
                                          label: "Route",
                                          text:
                                              "Sakchi <--> Dimna <--> College"),
                                      LabeledText(
                                          label: "Fee status", 
                                          text: "Paid")
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 4,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          color: Colors.black.withOpacity(0.5),
                                          offset: Offset(0, 7),
                                        ),
                                      ],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            AssetImage('images/userLogo.jpg'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ],
    );
  }
}