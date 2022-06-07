import 'package:bus_on_the_way/Constants/Constants.dart';
import 'package:bus_on_the_way/CustomComponents/InputFields.dart';
import 'package:bus_on_the_way/services/auth.dart';
import 'package:bus_on_the_way/shared/constants.dart';
import 'package:bus_on_the_way/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Register extends StatefulWidget {
  final Function toogleView;
  final double? height;
  Register({required this.toogleView, this.height});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> with TickerProviderStateMixin {
  late Animation<double> animation, delayedAnimation;
  late AnimationController animationController, animContrroller;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));

    animContrroller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    delayedAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: animContrroller,
            curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));

    animation =
        Tween<double>(begin: 0, end: widget.height).animate(animationController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              animationController.reverse();
            }
          });

    animationController.forward();
    animContrroller.forward();
  }

  final _controller = {
    'email': TextEditingController(),
    'password': TextEditingController()
  };

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  //text field state
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            floatingActionButton: animationController.isDismissed
                ? FloatingActionButton(
                    child: Icon(FontAwesomeIcons.homeLg),
                    backgroundColor: Colors.blue,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                : Container(),
            body: Stack(
              children: [
                AnimatedBuilder(
                    animation: animContrroller,
                    builder: (context, child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            delayedAnimation.value *
                                MediaQuery.of(context).size.width,
                            0.0,
                            0.0),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 50.0),
                            child: Form(
                              key:
                                  _formKey, //state of our form for form validation
                              child: Column(
                                children: <Widget>[
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.08,
                                    ),
                                    child: const Text(
                                      'Register',
                                      style: TextStyle(
                                          fontSize: 40.0,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5),
                                    ),
                                  ),
                                  KDivider,
                                  TextFormField(
                                      decoration: textInputDecoration.copyWith(
                                          prefixIcon: Icon(
                                              FontAwesomeIcons.user,
                                              color: Color(0xffC7C7C7)),
                                          hintText: 'Email or Username'),
                                      validator: (value) => value!.isEmpty
                                          ? 'Enter a valid email or username'
                                          : null,
                                      onChanged: (value) {
                                        setState(() {
                                          email = value;
                                        });
                                      }),
                                  // InputFields(
                                  //   icon: Icon(FontAwesomeIcons.user,
                                  //       color: Color(0xffC7C7C7)),
                                  //   text: 'Email',
                                  //   hintText: 'Enter Email',

                                  //   controller: _controller['email'],
                                  // ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  // InputFields(
                                  //   icon: Icon(FontAwesomeIcons.lock,
                                  //       color: Color(0xffC7C7C7)),
                                  //   text: 'Password',
                                  //   hintText: 'Password',
                                  //   isobscure: true,
                                  //   controller: _controller['password'],
                                  // ),

                                  TextFormField(
                                      decoration: textInputDecoration.copyWith(
                                        prefixIcon: Icon(FontAwesomeIcons.lock, color: Color(0xffC7C7C7)),
                                          hintText: 'Password'),
                                      validator: (value) => value!.length < 6
                                          ? 'Password must be atleast 6 characters long'
                                          : null,
                                      obscureText: true,
                                      onChanged: (value) {
                                        setState(() {
                                          password = value;
                                        });
                                      }),

                                  const SizedBox(height: 20.0),
                                  
                                  ElevatedButton(
                                    child: const Text('Register'),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.teal,
                                      onPrimary: Colors.white,
                                      shadowColor: Colors.blueAccent,
                                      elevation: 5,
                                    ),
                                    onPressed: () async {
                                      if ((_formKey.currentState?.validate()) !=
                                          null) {
                                        setState(() {
                                          loading = true;
                                        });
                                        dynamic result = await _auth
                                            .registerWithEmailAndPassword(
                                                'ankit', email, password, 'sakchi', 'onlineee' );
                                        if (result == null) {
                                          setState(() {
                                            error =
                                                'Invalid email format. Please supply a valid email';
                                            loading = false;
                                          });
                                        }
                                        // print(email);
                                        // print(password);
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 20.0),
                                  
                                  const Text('Already have an account?'),
                                  
                                  TextButton(
                                    child: const Text(
                                      'Sign In',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    onPressed: () {
                                      {
                                        widget.toogleView();
                                      }
                                    },
                                  ),
                                  SizedBox(height: 20.0),
                                  Text(error,
                                      style: TextStyle(
                                          color: Colors.red[500],
                                          fontSize: 15.0)),
                                ],
                              ),
                            )),
                      );
                    }),
                Positioned(
                  bottom: 0,
                  child: Container(
                    color: Colors.blue,
                    width: MediaQuery.of(context).size.width,
                    height: animation.value,
                  ),
                )
              ],
            ));
  }

  @override
  void dispose() {
    super.dispose();
    //_controller.dispose();
    animationController.dispose();
    animContrroller.dispose();
  }
}
