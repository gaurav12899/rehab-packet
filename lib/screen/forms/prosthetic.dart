import 'package:flutter/material.dart';

class Prosthetic extends StatelessWidget {
  static const routeName = 'prosthetic';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prosthetic Forms"),
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(80))),
            width: double.infinity,
            height: 60,
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
                // leading: Image.asset(
                //   "assets/images/star.png",
                //   height: 30,
                //   width: 30,
                // ),
                title: Text(
                  "Partial Hand",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),

            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(80))),
            width: double.infinity,
            // color: Colors.red,
            height: 60,
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
                // leading: Image.asset(
                //   "assets/images/star.png",
                //   height: 30,
                //   width: 30,
                // ),
                title: Text(
                  "Below Elbow Prosthesis",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),

            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(80))),
            width: double.infinity,
            // color: Colors.red,
            height: 60,
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
                // leading: Image.asset(
                //   "assets/images/star.png",
                //   height: 30,
                //   width: 30,
                // ),
                title: Text(
                  "Silicon Fingers",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: 30,
          // ),
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(0))),
            width: double.infinity,
            height: 60,
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
                // leading: Image.asset(
                //   "assets/images/star.png",
                //   height: 30,
                //   width: 30,
                // ),
                title: Text(
                  "Partial Foot",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),

            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(80))),
            width: double.infinity,
            // color: Colors.red,
            height: 60,
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
                // leading: Image.asset(
                //   "assets/images/star.png",
                //   height: 30,
                //   width: 30,
                // ),
                title: Text(
                  "Silicon Figers",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(80)),
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
              child: Text("OTHERS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(0))),
            width: double.infinity,
            height: 60,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(80))),
              child: ListTile(
                // elevation: 5,
                //

                title: Text(
                  "Silicon Fingers",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),

            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(80))),
            width: double.infinity,
            // color: Colors.red,
            height: 60,
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

                // leading: Image.asset(
                //   "assets/images/star.png",
                //   height: 30,
                //   width: 30,
                // ),
                title: Text(
                  "Silicon Nose",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),

            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(80))),
            width: double.infinity,
            // color: Colors.red,
            height: 60,
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
                // leading: Image.asset(
                //   "assets/images/star.png",
                //   height: 30,
                //   width: 30,
                // ),
                title: Text(
                  "Silicon Ears",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
