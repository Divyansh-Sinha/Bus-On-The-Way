import 'package:flutter/material.dart';

class LabeledText extends StatelessWidget {
  final String label;
  final String text;

  LabeledText({required this.label, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w900,
                color: Colors.blue),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 25.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.black,
            thickness: 1,
            height: 10,
          ),
        ],
      ),
    );
  }
}
