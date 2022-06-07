import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);
  static const spinkit = SpinKitThreeBounce(
    color: Colors.white,
    size: 50.0,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xFF3383CD),
          Color(0xFF11249F),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: Center(
        child: spinkit,
      ),
    );
  }
}
