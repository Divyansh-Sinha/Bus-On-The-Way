import 'package:bus_on_the_way/Constants/Constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';




class InputFields extends StatefulWidget {
  final Widget icon;
  final String text;
  final String hintText;
  late bool isobscure;
  final TextEditingController? controller;


  InputFields({required this.icon , required this.text , required this.hintText , this.isobscure = false , this.controller});

  @override
  _InputFieldsState createState() => _InputFieldsState();
}

class _InputFieldsState extends State<InputFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: widget.icon,
              ),
              Text(
                '${widget.text}',
                style: const TextStyle(color: Colors.black54 , fontSize: 20.0),
              )
            ],
          ),
          margin: EdgeInsets.only(left: 20.0, top: 10.0),
        ),
        Container(
          // padding: EdgeInsets.all(20.0),
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextFormField(
              
              controller: widget.controller,
              obscureText: widget.isobscure,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: widget.hintText,
                
                hintStyle: TextStyle(color: Color(0xff2E5C50)),
                focusedBorder: KOUtlineInputBorderFocus,
                enabledBorder: KOutlineInputBorderEnalbe,
                suffixIcon: widget.hintText == "Password"
                    ? IconButton(
                  onPressed: () {
                    setState(() {
                      widget.isobscure = !widget.isobscure;
                    });
                  },
                  icon: Icon(
                    widget.isobscure
                        ? FontAwesomeIcons.eyeSlash
                        : FontAwesomeIcons.eye,
                    size: 19.0,
                  ),
                )
                    : null,
              ),

            )),
      ],
    );
  }
}
