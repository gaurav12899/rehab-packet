import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project/screen/forms/Cosmetic%20Forms/CosmeticRestorationHand/cosmeticRestorationHandA.dart';
import 'package:project/screen/forms/Cosmetic%20Forms/cosmeticRestorationFingers/cosmeticRestFingersA.dart';

class Cosmetic extends StatelessWidget {
  static const routeName = '/cosmetic';
  final uid;
  Cosmetic(this.uid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cosmetic Restoration Forms"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          FormName(
            name: "Partial Hand Prosthesis",
            path: CosmeticRestorationHandA(uid),
          ),
          // FormName(
          //     name: "Partial Foot Prosthesis",
          //     path: AfoA.routeName,
          //     username: username),
          FormName(
            name: "Silicon Fingers",
            path: CosmeticRestorationFingersA(uid),
          ),
        ]),
      ),
    );
  }
}

class FormName extends StatelessWidget {
  final String name;
  final path;
  const FormName({
    @required this.name,
    @required this.path,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),

      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(80))),
      width: double.infinity,
      // color: Colors.red,
      height: 60,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => path));
        },
        child: Card(
          elevation: 5,
          color: HexColor('344955'),
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(80))),
          child: ListTile(
            leading: Icon(
              Icons.arrow_forward,
              color: HexColor('F9AA33'),
            ),
            title: Text(
              name,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
