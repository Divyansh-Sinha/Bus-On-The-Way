import 'package:flutter/material.dart';

class ButtonContainer extends StatelessWidget {
  final String btnName;
  final VoidCallback? onpressed;
  ButtonContainer({required this.btnName, this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      margin: EdgeInsets.all(10),
      child: RaisedButton(
        onPressed: this.onpressed,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF04B2D9),
                  Color.fromARGB(255, 153, 235, 253),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 180.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              btnName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Courgette',
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
