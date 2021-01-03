import 'package:flutter/material.dart';
import 'package:project/screen/forms/Afo/afoA.dart';

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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(0),
              ),
            ),
            padding: EdgeInsets.only(
              top: 10,
            ),
            width: double.infinity,
            // color: Colors.red,
            height: 80,

            child: Card(
              color: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(0))),
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
            name: "Shoulder Orthosis",
            path: AfoA.routeName,
            username: username,
          ),
          FormName(
            name: " Elbow Orthosis",
            path: AfoA.routeName,
            username: username,
          ),
          FormName(
            name: "Wrist Osthesis",
            path: AfoA.routeName,
            username: username,
          ),
          FormName(
            name: "Hand Osthesis",
            path: AfoA.routeName,
            username: username,
          ),
          FormName(
            name: "Weist-Hand Osthesis",
            path: AfoA.routeName,
            username: username,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(0),
              ),
            ),
            padding: EdgeInsets.only(
              top: 10,
            ),
            width: double.infinity,
            // color: Colors.red,
            height: 80,

            child: Card(
              color: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(0))),
              elevation: 5,
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
            name: "Foot Osthesis",
            path: AfoA.routeName,
            username: username,
          ),
          FormName(
            name: "Ankle Foot Osthesis",
            path: AfoA.routeName,
            username: username,
          ),
          FormName(
            name: "Knee Ankle Foot Osthesis",
            path: AfoA.routeName,
            username: username,
          ),
          FormName(
            name: "Knee Osthesis",
            path: AfoA.routeName,
            username: username,
          ),
          FormName(
            name: "Hip Knee-Ankle Foot Osthesis",
            path: AfoA.routeName,
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
          Navigator.of(context).popAndPushNamed(path);
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
            leading: Image.asset(
              "assets/images/star.png",
              height: 30,
              width: 30,
            ),
            title: Text(
              name,
              style: TextStyle(fontSize: 22),
            ),
          ),
        ),
      ),
    );
  }
}
