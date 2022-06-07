import 'package:bus_on_the_way/CustomComponents/labeled_text.dart';
import 'package:bus_on_the_way/CustomComponents/profile_image.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(4, 9, 35, 1),
                Color.fromRGBO(39, 105, 171, 1),
              ],
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
            ),
          ),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Profile",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: 'OleoScript'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: height * 0.72,
                        // color: Colors.black,
                        child: LayoutBuilder(builder: (context, constraints) {
                          double innerHeight = constraints.maxHeight;
                          double innerWidth = constraints.maxWidth;
                          return Stack(
                            children: [
                              Positioned(
                                top: 90,
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  height: innerHeight,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: AssetImage('images/bgImage.png'),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 50,
                                      ),
                                      LabeledText(
                                        label: "Full Name",
                                        text: "Jhon Doe",
                                      ),
                                      LabeledText(
                                          label: "Contact Number",
                                          text: "9123456789"),
                                      LabeledText(
                                          label: "Route",
                                          text: "Sakchi<--> Dimna <--> College")
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: ProfileImage(),
                                ),
                              ),
                            ],
                          );
                        }),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ],
    );
  }
}

// Container(
//             padding: EdgeInsets.only(left: 16, top: 25, right: 16),
//             child: ListView(
//               children: [
//                 SizedBox(
//                   height: 25,
//                 ),
//                 Center(
//                   child: Stack(
//                     children: [
//                       ProfileImage(),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 45,
//                 ),
//                 LabeledText(label: 'Full name', text: 'Dor Alex'),
//                 LabeledText(label: 'Contact Number', text: '8456487920'),
//                 LabeledText(
//                     label: 'Route', text: 'Sakchi <--> Dimna <--> College'),
//               ],
//             ),
//           ),