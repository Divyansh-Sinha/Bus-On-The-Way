import 'package:bus_on_the_way/Constants/Constants.dart';
import 'package:bus_on_the_way/CustomComponents/InputFields.dart';
import 'package:bus_on_the_way/services/auth.dart';
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

  String route = 'Select';

  var routes = ['Sakchi', 'Azadbasti', 'Bistupur', 'Kadma', 'Mango', 'Dimna'];

  String payment = 'Select';

  var payMethod = ['Offline', 'Online'];

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
TextEditingController email= new TextEditingController();
TextEditingController name= new TextEditingController();
TextEditingController password= new TextEditingController();
TextEditingController busStop= new TextEditingController();
TextEditingController paymentMode= new TextEditingController();
  
  // final _controller = {
  //   'email': TextEditingController(),
  //   'password': TextEditingController(),
  // };


  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  //text field state
  // String email = '';
  // String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                floatingActionButton: animationController.isDismissed
                    ? FloatingActionButton(
                        child: Icon(FontAwesomeIcons.backwardStep),
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
                            child: Column(
                              children: [
                                Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(60),
                                        bottomRight: Radius.circular(60),
                                      ),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.indigo,
                                          Colors.blueAccent
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 10.0,
                                            offset: Offset(4.0, 4.0))
                                      ]),
                                  child: Center(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                      child: const Text(
                                        'Register',
                                        style: TextStyle(
                                            fontSize: 40.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20.0, horizontal: 30.0),
                                        child: Form(
                                          key:
                                              _formKey, //state of our form for form validation
                                          child: Column(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 10,
                                              ),
                                              InputFields(
                                                icon: Icon(
                                                    FontAwesomeIcons.user,
                                                    color: Color(0xffC7C7C7)),
                                                text: 'Full Name',
                                                hintText: 'Enter Full Name',
                                                controller: name,
                                              ),
                                              InputFields(
                                                icon: Icon(
                                                    FontAwesomeIcons.user,
                                                    color: Color(0xffC7C7C7)),
                                                text: 'Email',
                                                hintText: 'Enter Email',
                                                controller:
                                                    email,
                                              ),
                                              InputFields(
                                                icon: Icon(
                                                    FontAwesomeIcons.lock,
                                                    color: Color(0xffC7C7C7)),
                                                text: 'Password',
                                                hintText: 'Password',
                                                isobscure: true,
                                                controller:
                                                  password,
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .baseline,
                                                      textBaseline: TextBaseline
                                                          .alphabetic,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Icon(
                                                            FontAwesomeIcons
                                                                .bus,
                                                            color: Color(
                                                                0xffC7C7C7),
                                                          ),
                                                        ),
                                                        Text(
                                                          'Bus Stop',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontSize:
                                                                      20.0),
                                                        )
                                                      ],
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        left: 20.0, top: 10.0),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 20.0,
                                                        right: 20.0),
                                                    child:
                                                        DropdownButtonFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        focusedBorder:
                                                            KOUtlineInputBorderFocus,
                                                        enabledBorder:
                                                            KOutlineInputBorderEnalbe,
                                                        labelStyle: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15.0),
                                                      ),
                                                      hint: Text(
                                                          'Select Bus Stop'),
                                                      items: routes
                                                          .map((String items) {
                                                        return DropdownMenuItem(
                                                            value: items,
                                                            child: Text(items));
                                                      }).toList(),
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          route = newValue
                                                              .toString();
                                                        });
                                                        print(route);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .baseline,
                                                      textBaseline: TextBaseline
                                                          .alphabetic,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Icon(
                                                            FontAwesomeIcons
                                                                .indianRupeeSign,
                                                            color: Color(
                                                                0xffC7C7C7),
                                                          ),
                                                        ),
                                                        Text(
                                                          'Payment Method',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontSize:
                                                                      20.0),
                                                        )
                                                      ],
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        left: 20.0, top: 10.0),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 20.0,
                                                        right: 20.0),
                                                    child:
                                                        DropdownButtonFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        focusedBorder:
                                                            KOUtlineInputBorderFocus,
                                                        enabledBorder:
                                                            KOutlineInputBorderEnalbe,
                                                        labelStyle: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15.0),
                                                      ),
                                                      hint: Text(
                                                          'Select Payment Method'),
                                                      items: payMethod
                                                          .map((String items) {
                                                        return DropdownMenuItem(
                                                            value: items,
                                                            child: Text(items));
                                                      }).toList(),
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          payment = newValue
                                                              .toString();
                                                        });
                                                        print(payment);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 30.0),
                                              ElevatedButton(
                                                child: const Text('Register'),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.teal,
                                                  onPrimary: Colors.white,
                                                  shadowColor:
                                                      Colors.blueAccent,
                                                  elevation: 5,
                                                ),
                                                onPressed: () async {
                                                  var Oname= name.text;
                                                  var Opassword= password.text;
                                                  var Oemail= email.text;
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    setState(() {
                                                      loading = true;
                                                    });
                                                    dynamic result = await _auth
                                                        .registerWithEmailAndPassword(
                                                            Oname,Oemail,Opassword,route,
                                                            payment
                                                            );
                                                    if (result == null) {
                                                      setState(() {
                                                        error =
                                                            'Invalid email format. Please supply a valid email';
                                                        loading = false;
                                                      });
                                                    }
                                                    // print("HEEEEEEEEEEHEEEEE");
                                                    // FirebaseFirestore.instance
                                                    //     .collection('bus')
                                                    //     .doc(FirebaseAuth
                                                    //         .instance
                                                    //         .currentUser!
                                                    //         .uid)
                                                    //     .set({
                                                    //   'Full Name':
                                                    //       _controller['name']!
                                                    //           .text,
                                                    //   'Email':
                                                    //       _controller['email']!
                                                    //           .text,
                                                    //   'Password': _controller[
                                                    //           'password']!
                                                    //       .text,
                                                    //   'Bus Stop:':
                                                    //       route.toString(),
                                                    //   'Payment Status':
                                                    //       payment.toString()
                                                    // });
                                                    //print(email);
                                                    //print(password);
                                                  }
                                                },
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              const Text(
                                                  'Already have an account?'),
                                              TextButton(
                                                child: const Text(
                                                  'Sign In',
                                                  style:
                                                      TextStyle(fontSize: 20),
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
                                  ),
                                ),
                              ],
                            ),
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
                )),
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
