import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project/screen/forms/Afo/afoA.dart';
import 'package:project/screen/forms/CosmeticRestorationHand/cosmeticRestorationHandA.dart';
import 'package:project/screen/forms/cosmeticRestorationFingers/cosmeticRestFingersA.dart';
import 'package:project/screen/forms/cosmeticRestorationFingers/cosmeticRestFingersB.dart';

class Cosmetic extends StatelessWidget {
  static const routeName = '/cosmetic';
  @override
  Widget build(BuildContext context) {
    final String username = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Cosmetic Restoration Forms"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          FormName(
              name: "Partial Hand Prosthesis",
              path: CosmeticRestorationHandA.routeName,
              username: username),
          FormName(
              name: "Partial Foot Prosthesis",
              path: AfoA.routeName,
              username: username),
          FormName(
              name: "Silicon Fingers",
              path: CosmeticRestorationFingersA.routeName,
              username: username),
        ]),
      ),
    );
  }
}

class FormName extends StatelessWidget {
  final String name;
  final String path;
  final String username;
  const FormName({
    @required this.name,
    @required this.path,
    @required this.username,
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
          Navigator.of(context).popAndPushNamed(path, arguments: username);
        },
        child: Card(
          elevation: 5,
          color: HexColor('344955'),
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(80))),
          child: ListTile(
            // elevation: 5,
            // trailing: Image.asset(
            //   "assets/images/arrow.png",
            //   height: 30,
            //   width: 30,
            // ),
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
