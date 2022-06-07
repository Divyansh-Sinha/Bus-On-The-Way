import 'package:bus_on_the_way/screens/splashScreen/SplashScreen.dart';
import 'package:bus_on_the_way/screens/startScreen/startScreen.dart';
import 'package:bus_on_the_way/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:bus_on_the_way/screens/home/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bus_on_the_way/models/newUser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  MyApp();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<newUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
