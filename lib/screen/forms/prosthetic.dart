import 'package:flutter/material.dart';
import 'package:project/screen/forms/TransfemoralMeasurementForm/transfemoralMeasurementFormA.dart';
import 'package:project/screen/forms/aboveElbowProsthesis/aboveElbowProsthesis.dart';
import 'package:project/screen/forms/belowElbowProsthesis/belowElbowProsthesis.dart';
import 'package:project/screen/forms/belowKneeProsthesis/belowKneeProsthesisA.dart';
import 'package:hexcolor/hexcolor.dart';

class Prosthetic extends StatelessWidget {
  static const routeName = '/prosthetic';

  @override
  Widget build(BuildContext context) {
    final String username = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Prosthetic Forms"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            padding: EdgeInsets.only(
              top: 10,
            ),
            width: double.infinity,
            // color: Colors.red,
            height: 70,

            child: Card(
              color: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              child: Text("Upper Limb",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
          ),
          FormName(
            name: "Below Elbow Prosthesis",
            path: BelowElbowProsthesis.routeName,
            username: username,
          ),
          FormName(
            name: "Above Elbow Prosthesis",
            path: AboveElbowProsthesis.routeName,
            username: username,
          ),
          Container(
            padding: EdgeInsets.only(
              top: 10,
            ),
            width: double.infinity,
            // color: Colors.red,
            height: 70,

            child: Card(
              color: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              child: Text("Lower Limb",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
          ),
          FormName(
            name: "Below Knee Prosthesis",
            path: BelowKneeProsthesisA.routeName,
            username: username,
          ),
          FormName(
            name: "Above Knee Prothesis",
            path: TransfemoralMeasurementA.routeName,
            username: username,
          ),
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
          color: HexColor('344955'),
          elevation: 5,
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
