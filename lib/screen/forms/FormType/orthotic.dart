import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project/screen/forms/orthotic%20Forms/Afo/afoA.dart';
import 'package:project/screen/forms/orthotic%20Forms/HKAFO/hkafoA.dart';
import 'package:project/screen/forms/orthotic%20Forms/Kafo/kafoA.dart';
import 'package:project/screen/forms/orthotic%20Forms/elbowOrthosis/elbowOrthosis.dart';
import 'package:project/screen/forms/orthotic%20Forms/spinalOrthosis/spinalOrthosisA.dart';
import 'package:project/screen/forms/orthotic%20Forms/wristHandOrthosis/wristHandOrthosisA.dart';

class Orthotic extends StatelessWidget {
  static const routeName = '/orthotic';
  final uid;
  Orthotic(this.uid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orthotic Forms"),
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
            name: " Elbow Orthosis",
            path: ElbowOrthosisA(uid),
          ),
          FormName(
            name: "Wrist-Hand Orthosis",
            path: WristHandOrthosisA(uid),
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
            name: "Ankle Foot Orthosis",
            path: AfoA(uid),
          ),
          FormName(
            name: "Knee Ankle Foot Orthosis",
            path: KafoA(uid),
          ),
          // FormName(
          //   name: "Knee Orthosis",
          //   path: AfoA.routeName,
          //   username: username,
          // ),
          FormName(
            name: "Hip Knee-Ankle Foot Orthosis",
            path: HKAFOA(uid),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 10,
            ),
            width: double.infinity,
            height: 70,
            child: Card(
              color: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              child: Text("Spinal Orthosis",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
          ),
          FormName(
            name: "Spinal Orthosis",
            path: SpinalOrthosisA(uid),
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
          color: HexColor('344955'),
          elevation: 5,
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
