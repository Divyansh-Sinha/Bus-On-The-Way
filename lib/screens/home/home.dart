import 'package:bus_on_the_way/services/auth.dart';
import 'package:flutter/material.dart';
import '../../shared/constants.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Center(child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color.fromARGB(255, 74, 11, 169),
          //fixedSize: Size.fromWidth(100),
        ),
        child: Text("Get Live Location"),
        onPressed: () {},
      )),
      appBar: AppBar(
        title: const Text('Welcome to Bus on the Way!'),
        backgroundColor: Colors.pink,
        elevation: 10.0,
        actions: <Widget>[
          ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color.fromARGB(255, 191, 219, 10),
          fixedSize: Size.fromWidth(100),
          padding: EdgeInsets.all(10)
        ),
        child: Text("Logout"),
        onPressed: () async {
          await _auth.signOut();
        },
      ),
      
      ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              child: Text("View location", 
              style: TextStyle(color: Colors.black, fontSize: 32),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.5),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                  
                    ),
                  )
                ],
              )
            )
          ],
        ),
      )
    );
  }
}