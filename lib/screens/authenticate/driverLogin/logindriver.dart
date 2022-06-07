import 'package:bus_on_the_way/Constants/Constants.dart';
import 'package:bus_on_the_way/CustomComponents/InputFields.dart';
import 'package:bus_on_the_way/screens/driverHome/DriverHome1.dart';
import 'package:bus_on_the_way/screens/driverHome/driverHome.dart';
import 'package:bus_on_the_way/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:bus_on_the_way/services/auth.dart';
import 'package:bus_on_the_way/shared/constants.dart';
import 'package:flutter/material.dart';

class LoginDriver extends StatefulWidget {
  final double height;
  LoginDriver({Key? key, required this.height}) : super(key: key);
  _LoginDriverState createState() => _LoginDriverState();
}

class _LoginDriverState extends State<LoginDriver>
    with TickerProviderStateMixin {
  late SharedPreferences logindata;
  late Animation<double> animation, delayedAnimation;
  late AnimationController animationController, animContrroller;
  late bool newuser;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';

  final _controller = {
    'email': TextEditingController(),
    'password': TextEditingController()
  };

  @override
  void initState() {
    super.initState();

    check_if_already_login();

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

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (context) => DriverHome(
                    height: widget.height,
                  )));
    }
  }

  //text field state
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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

                          //state of our form for form validation
                          child: Form(
                            key: _formKey,
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
                                    'Driver Login',
                                    style: TextStyle(
                                        fontSize: 40.0,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5),
                                  ),
                                ),
                                KDivider,
                                InputFields(
                                  icon: Icon(FontAwesomeIcons.user,
                                      color: Color(0xffC7C7C7)),
                                  text: 'Username',
                                  hintText: 'Enter email or username',
                                  controller: _controller['email'],
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                InputFields(
                                  icon: Icon(FontAwesomeIcons.lock,
                                      color: Color(0xffC7C7C7)),
                                  text: 'Password',
                                  hintText: 'Enter Password',
                                  isobscure: true,
                                  controller: _controller['password'],
                                ),
                                const SizedBox(height: 20.0),
                                ElevatedButton(
                                    child: const Text('Login'),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.teal,
                                      onPrimary: Colors.white,
                                      shadowColor: Colors.blueAccent,
                                      elevation: 5,
                                    ),
                                    onPressed:() {
                                      // if ((_formKey.currentState?.validate()) ==
                                      //     null) {
                                      //   setState(() {
                                      //     loading = true;
                                      //   });
                                        // dynamic result = await _auth
                                        //     .signInWithEmailAndPassword(
                                        //         _controller['email']!.text, _controller['password']!.text);
                                        // if(result != null){
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => DriverHome(
                                        //       height: widget.height,
                                        //     ),
                                        //   ),
                                        // );
                                        // }
                                        if (this._controller['email']!.text ==
                                              'Driver1@gmail.com' &&
                                          this._controller['password']!.text ==
                                              'driver1') {
                                        //print('Successfull');
                                        logindata.setBool('login', false);
                                        //logindata.setString('username', this._controller['email']!.text);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DriverHome(
                                              height: widget.height,
                                            ),
                                          ),
                                        );
                                      }
                                      else if(this._controller['email']!.text ==
                                              'Driver2@gmail.com' &&
                                          this._controller['password']!.text ==
                                              'driver2') {
                                        logindata.setBool('login', false);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DriverHome1(
                                              height: widget.height,
                                            ),
                                          ),
                                        );
                                      }
                                      else {
                                        Alert(
                                          context: context,
                                          type: AlertType.warning,
                                          title: "Login Error:",
                                          desc: "Invalid Credentials",
                                          buttons: [
                                            DialogButton(
                                              child: Text(
                                                "Try again",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              color: Color.fromRGBO(
                                                  0, 179, 134, 1.0),
                                            ),
                                          ],
                                        ).show();
                                      }
                                    }),
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
