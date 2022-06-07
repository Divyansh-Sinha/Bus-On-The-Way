import 'package:bus_on_the_way/Constants/Constants.dart';
import 'package:bus_on_the_way/LocationServices/mymap.dart';
import 'package:bus_on_the_way/screens/driverProfile/profile_page.dart';
import 'package:bus_on_the_way/screens/studentHome/studentProfile.dart';
import 'package:bus_on_the_way/screens/studentHome/try.dart';
import 'package:bus_on_the_way/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart' as loc;
import 'package:bus_on_the_way/LocationServices/addLocation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StudentHome extends StatefulWidget {
  @override
  final double? height;
  State<StudentHome> createState() => _StudentHomeState();
  StudentHome({this.height});
}

class _StudentHomeState extends State<StudentHome>
    with TickerProviderStateMixin {
  late Animation<double> animation, delayedAnimation, muchDelayedAnimation;
  late AnimationController animationController, animContrroller;
  final AuthService _auth = AuthService();
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;
  LocationService locService = new LocationService();

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    animContrroller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    delayedAnimation = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1, curve: Curves.fastOutSlowIn)));
    muchDelayedAnimation = Tween<double>(begin: 1.0, end: 0).animate(
        CurvedAnimation(
            parent: animContrroller,
            curve: Interval(0.7, 1, curve: Curves.fastOutSlowIn)));

    animation = Tween<double>(begin: 0, end: widget.height).animate(
        CurvedAnimation(
            parent: animContrroller,
            curve: Interval(0.5, 1, curve: Curves.fastOutSlowIn)))
      ..addListener(() {
        setState(() {});
      });

    animationController.forward();
    animContrroller.forward();
  }

  @override
  Widget build(BuildContext context) {
    print(animation.value);
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.black12,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(FontAwesomeIcons.idBadge),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Try()),
                      );
                    }),
                IconButton(
                    icon: Icon(FontAwesomeIcons.rightFromBracket),
                    onPressed: () async {
                      // SharedPreferences preferences =
                      //     await SharedPreferences.getInstance();
                      // await preferences.clear();
                      // Navigator.pop(context);
                      await FirebaseAuth.instance.signOut();
                    }),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     child: Icon(FontAwesomeIcons.bus), onPressed: () {}),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: AnimatedBuilder(
                animation: animationController,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.translationValues(
                        delayedAnimation.value *
                            MediaQuery.of(context).size.width,
                        0.0,
                        0.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          color: Colors.blue),
                      height: animation.value * 0.75,
                      width: MediaQuery.of(context).size.width,
                      child: AnimatedBuilder(
                          animation: animContrroller,
                          builder: (context, child) {
                            return Transform(
                              transform: Matrix4.translationValues(
                                  muchDelayedAnimation.value *
                                      MediaQuery.of(context).size.width,
                                  0.0,
                                  0.0),
                              child: Container(
                                margin: EdgeInsets.only(top: 50),
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: const Text(
                                            'Student Home',
                                            style: TextStyle(
                                                fontSize: 40.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.5),
                                          ),
                                        ),
                                        Divider(
                                          height: 60,
                                          thickness: 2,
                                          indent: 90,
                                          endIndent: 90,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        Card(
                                          elevation: 10,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      left: 20,
                                                      top: 10,
                                                      bottom: 5,
                                                    ),
                                                    child: Text(
                                                      'Driver Details:',
                                                      style: TextStyle(
                                                        color: Colors
                                                            .blue.shade900,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                              'Name - Ankit'),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                              'Bus Stop - Sakchi'),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                  right: 20,
                                                ),
                                                child: StreamBuilder(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection('location')
                                                        .snapshots(),
                                                    builder: (context,
                                                        AsyncSnapshot<
                                                                QuerySnapshot>
                                                            snapshot) {
                                                      return IconButton(
                                                          onPressed: () {
                                                            Navigator.of(context).push(MaterialPageRoute(
                                                                builder: (context) =>
                                                                    MyMap(snapshot
                                                                        .data!
                                                                        .docs[0]
                                                                        .id)));
                                                          },
                                                          icon: Icon(
                                                              FontAwesomeIcons
                                                                  .bus));
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 50,
                                        ),
                                        Card(
                                          elevation: 10,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      left: 20,
                                                      top: 10,
                                                      bottom: 5,
                                                    ),
                                                    child: Text(
                                                      'Driver Details:',
                                                      style: TextStyle(
                                                        color: Colors
                                                            .blue.shade900,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                              'Name - John'),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                              'Bus Stop - Mango'),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                  right: 20,
                                                ),
                                                child: StreamBuilder(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection('location')
                                                        .snapshots(),
                                                    builder: (context,
                                                        AsyncSnapshot<
                                                                QuerySnapshot>
                                                            snapshot) {
                                                      return IconButton(
                                                          onPressed: () {
                                                            Navigator.of(context).push(MaterialPageRoute(
                                                                builder: (context) =>
                                                                    MyMap(snapshot
                                                                        .data!
                                                                        .docs[1]
                                                                        .id)));
                                                          },
                                                          icon: Icon(
                                                              FontAwesomeIcons
                                                                  .bus));
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    //_controller.dispose();
    animationController.dispose();
    animContrroller.dispose();
  }
}

class Button extends StatelessWidget {
  const Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: Stack(
        children: [
          Container(
            child: Text(
              "driver  location",
              style: TextStyle(color: Colors.black, fontSize: 32),
            ),
          ),
          Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.5),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                    ),
                  )
                ],
              ))
        ],
      ),
    ));
  }
}
