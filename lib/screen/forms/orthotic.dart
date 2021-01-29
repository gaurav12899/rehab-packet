import 'package:flutter/material.dart';
import 'package:project/screen/forms/Afo/afoA.dart';
import 'package:project/screen/forms/Kafo/kafoA.dart';
import 'package:project/screen/forms/elbowOrthosis/elbowOrthosis.dart';
import 'package:project/screen/forms/spinalOrthosis/spinalOrthosisA.dart';
import 'package:project/screen/forms/wristHandOrthosis/wristHandOrthosisA.dart';

class Orthotic extends StatelessWidget {
  static const routeName = '/orthotic';
  @override
  Widget build(BuildContext context) {
    final String username = ModalRoute.of(context).settings.arguments;
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
            height: 80,

            child: Card(
              color: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              child: Text("UPPER LIMB",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
          ),
          FormName(
            name: " Elbow Hand Orthosis",
            path: ElbowOrthosisA.routeName,
            username: username,
          ),
          FormName(
            name: "Wrist-Hand Orthosis",
            path: WristHandOrthosisA.routeName,
            username: username,
          ),
          Container(
            padding: EdgeInsets.only(
              top: 10,
            ),
            width: double.infinity,
            // color: Colors.red,
            height: 80,

            child: Card(
              color: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 10,
              child: Text("LOWER LIMB",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
          ),
          FormName(
            name: "Ankle Foot Orthosis",
            path: AfoA.routeName,
            username: username,
          ),
          FormName(
            name: "Knee Ankle Foot Orthosis",
            path: KafoA.routeName,
            username: username,
          ),
          FormName(
            name: "Knee Orthosis",
            path: AfoA.routeName,
            username: username,
          ),
          FormName(
            name: "Hip Knee-Ankle Foot Orthosis",
            path: AfoA.routeName,
            username: username,
          ),
          Container(
            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
            padding: EdgeInsets.only(
              top: 10,
            ),
            width: double.infinity,
            // color: Colors.red,
            height: 80,

            child: Card(
              color: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              elevation: 5,
              child: Text("Spinal Orthosis",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
          ),
          FormName(
            name: "Spinal Orthosis",
            path: SpinalOrthosisA.routeName,
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
              color: Colors.blue,
            ),
            title: Text(
              name,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
