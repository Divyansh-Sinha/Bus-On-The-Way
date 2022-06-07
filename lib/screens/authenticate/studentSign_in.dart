import 'package:bus_on_the_way/Constants/Constants.dart';
import 'package:bus_on_the_way/CustomComponents/InputFields.dart';
import 'package:bus_on_the_way/models/model.dart';
import 'package:bus_on_the_way/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../shared/loading.dart';
UserModel loggedInUser = UserModel();

// ankit@gmail.com
// ankit12

class SignIn extends StatefulWidget {
  _SignInState createState() => _SignInState();

  final Function toogleView;
  final String text='fhdf';
  final double? height;
  SignIn({required this.toogleView, this.height});
}

class _SignInState extends State<SignIn> with TickerProviderStateMixin {
  late Animation<double> animation, delayedAnimation;
  late AnimationController animationController, animContrroller;

  final _controller = {
    'email': TextEditingController(),
    'password': TextEditingController()
  };

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

  String? id1;
  var role;
  var name;

 getData() async{
    String userId = await FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance.collection('bus').doc(userId).get()..then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    }).whenComplete(() {
      CircularProgressIndicator();
      setState(() {
        name = loggedInUser.name.toString();
        role = loggedInUser.role.toString();
        id1 = loggedInUser.uid.toString();
      });
    });
    
    
  }

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  //text field state
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    // print(FirebaseFirestore.instance.collection('bus').where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid));
    // CollectionReference bus = FirebaseFirestore.instance.collection('bus');
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
            body: Stack(children: [
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
                          key: _formKey, //state of our form for form validation
                          child: Form(
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
                                    'Sign In',
                                    style: TextStyle(
                                      fontSize: 40.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Lobster',
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                KDivider,
                                InputFields(
                                  icon: Icon(FontAwesomeIcons.user,
                                      color: Color(0xffC7C7C7)),
                                  text: 'User id',
                                  hintText: 'Enter user Id',
                                  controller: _controller['email'],
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                InputFields(
                                  icon: Icon(FontAwesomeIcons.lock,
                                      color: Color(0xffC7C7C7)),
                                  text: 'Password',
                                  hintText: 'Password',
                                  isobscure: true,
                                  controller: _controller['password'],
                                ),
                                const SizedBox(height: 30.0),
                                ElevatedButton(
                                    child: const Text(
                                      'Sign in',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.teal,
                                      onPrimary: Colors.white,
                                      shadowColor: Colors.blueAccent,
                                      elevation: 5,
                                    ),
                                    
                                    onPressed: () async {
                                      if ((_formKey.currentState?.validate()) ==
                                          null) {
                                        setState(() {
                                          loading = true;
                                        });

                                        dynamic result = await _auth
                                            .signInWithEmailAndPassword(
                                                this._controller['email']!.text,
                                                this
                                                    ._controller['password']!
                                                    .text);
                                        if (result == null) {
                                          setState(() {
                                            error =
                                                'Could not sign in with those credentials! ';
                                            loading = false;
                                          });
                                        }
                                      }
                                    }),
                                    SizedBox(height: 20,),
                                Container(
                                  child: widget.text != 'driver'
                                      ? Column(
                                          children: [
                                            const Text(
                                                'New User? Register Below!'),
                                            TextButton(
                                              child: const Text(
                                                'Register',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              onPressed: () {
                                                {
                                                  widget.toogleView();
                                                }
                                              },
                                            ),
                                          ],
                                        )
                                      : Container(),
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
              ),
            ]));
  }

  @override
  void dispose() {
    //_controller.dispose();
    animationController.dispose();
    animContrroller.dispose();
    super.dispose();
  }
}


