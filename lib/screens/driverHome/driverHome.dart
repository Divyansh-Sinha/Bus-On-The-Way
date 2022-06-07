import 'package:bus_on_the_way/Constants/Constants.dart';
import 'package:bus_on_the_way/screens/driverProfile/profile_page.dart';
import 'package:bus_on_the_way/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bus_on_the_way/LocationServices/mymap.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:bus_on_the_way/LocationServices/addLocation.dart';

class DriverHome extends StatefulWidget {
  @override
  final double? height;
  State<DriverHome> createState() => _DriverHomeState();
  DriverHome({this.height});
}

class _DriverHomeState extends State<DriverHome> with TickerProviderStateMixin {
  late Animation<double> animation, delayedAnimation, muchDelayedAnimation;
  late AnimationController animationController, animContrroller;
  final AuthService _auth = AuthService();
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;
  LocationService locService = new LocationService();


//To get Permission for location at the start of the app
  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

//get location and store it in the Firestore database
  _getLocation() async {
    try {
      final loc.LocationData _locationResult = await location.getLocation();
      await FirebaseFirestore.instance.collection('location').doc('Driver1').set({
        'latitude': _locationResult.latitude,
        'longitude': _locationResult.longitude,
        'name': 'Ankit'
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

//continuously listen to location changes for Live location sharing 
  Future<void> _listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      await FirebaseFirestore.instance.collection('location').doc('Driver1').set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'name': 'Ankit'
      }, SetOptions(merge: true));
    });
  }

//kill the location listening process
  _stopListening() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }


  @override
  void initState() {
    super.initState();
    _requestPermission();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);

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
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    }),
                IconButton(
                    icon: Icon(FontAwesomeIcons.rightFromBracket),
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await preferences.clear();
                      Navigator.pop(context);
                    }),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('location').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              MyMap(snapshot.data!.docs[0].id)));
                    },
                    icon: Icon(FontAwesomeIcons.bus));
              }),
          onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

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
                                            'Driver Home',
                                            style: TextStyle(
                                                fontSize: 40.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.5),
                                          ),
                                        ),
                                        KDivider,
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Card(
                                          elevation: 10,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.all(20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 100,
                                                      width: 100,
                                                      child: Image(
                                                        image: AssetImage(
                                                            'images/profile.jpg'),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              StreamBuilder(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection('location')
                                                    .snapshots(),
                                                builder: (context,
                                                    AsyncSnapshot<QuerySnapshot>
                                                        snapshot) {
                                                  if (!snapshot.hasData) {
                                                    return Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  }
                                                  return Container(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                                "Driver Name: "),
                                                            Text(snapshot.data!
                                                                .docs[0]['name']
                                                                .toString()),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text("Latitude: "),
                                                            Text(snapshot
                                                                .data!
                                                                .docs[0]
                                                                    ['latitude']
                                                                .toString()),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text("Longitude: "),
                                                            Text(snapshot
                                                                .data!
                                                                .docs[0][
                                                                    'longitude']
                                                                .toString()),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        TextButton.icon(
                                                  label: Text(
                                                      "Add my location",
                                                    style: TextStyle(fontSize: 12),),
                                                  icon: Icon(
                                                      Icons.add_location_alt_outlined),
                                                      onPressed: () =>[
                                                        Fluttertoast.showToast(
                                                          msg:
                                                              "Location Added",
                                                          fontSize: 15,
                                                        ),
                                                        _getLocation()
                                                  ],
                                                    ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextButton.icon(
                                                label: Text(
                                                    "Enable Live location",
                                                    style: TextStyle(fontSize: 12),),
                                                icon: Icon(
                                                    Icons.share_location_sharp),
                                                    onPressed: () => [
                                                      Fluttertoast.showToast(
                                                        msg:
                                                            "Location Sharing Started!",
                                                        fontSize: 15,
                                                      ),
                                                      _listenLocation()
                                                    ],
                                                  ),
                                                  TextButton.icon(
                                                label: Text(
                                                    "Stop Live location",
                                                    style: TextStyle(fontSize: 12),),
                                                icon: Icon(
                                                    Icons.location_off_sharp),
                                                onPressed: () => [
                                                      Fluttertoast.showToast(
                                                        msg:
                                                            "Location Sharing Stopped!",
                                                        fontSize: 15,
                                                      ),
                                                      _stopListening()
                                                    ]),
                                                ],
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
      // appBar: AppBar(
      //   title: const Text('Welcome to Bus on the Way!'),
      //   backgroundColor: Colors.pink,
      //   elevation: 10.0,
      //   actions: <Widget>[
      //
      //
      //   ],
      // ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    //_controller.dispose();
    animationController.dispose();
    animContrroller.dispose();
    _stopListening();
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
              "Driver  location",
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
