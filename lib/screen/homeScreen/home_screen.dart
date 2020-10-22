import 'package:flutter/material.dart';
import 'package:project/controllers/authentication.dart';
import 'package:project/screen/loginScreen/login.dart';

class HomeScreen extends StatelessWidget {
  final String uid;
  HomeScreen({this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            signOut().then((value) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Login()),
                  (Route<dynamic> route) => false);
            });
          },
          child: Text("Logout"),
        ),
      ),
    );
  }
}
