import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/screen/forms/cosmetic.dart';

import 'package:project/screen/forms/orthotic.dart';
import 'package:project/screen/forms/prosthetic.dart';
import 'package:project/screen/homeScreen/new-or-old-patient.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/homescreen';
  final String uid;
  HomeScreen({this.uid});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final String username = ModalRoute.of(context).settings.arguments;

    print("From demo to home$username");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).popAndPushNamed(NewOrOldPatient.routeName);
          },
        ),
        title: Text("Form Type"),
      ),

      // drawer: AppDrawer(),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // InkWell(
          //   child: Container(
          //     height: MediaQuery.of(context).size.height * .35,
          //     width: double.infinity,
          //     child: Card(
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(5)),
          //       color: Colors.black,
          //       elevation: 10,
          //       child: Stack(
          //         children: [
          //           Container(
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(5),
          //               image: DecorationImage(
          //                   fit: BoxFit.cover,
          //                   colorFilter: ColorFilter.mode(
          //                       Colors.black.withOpacity(.52),
          //                       BlendMode.dstATop),
          //                   image: AssetImage(
          //                     "assets/images/form.jpg",
          //                   )),
          //             ),
          //           ),
          //           Container(
          //             // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          //             child: Column(
          //               children: [
          //                 Container(
          //                   margin: EdgeInsets.symmetric(
          //                       horizontal: 20, vertical: 5),
          //                   child: Text(
          //                     "Demographic Data",
          //                     style:
          //                         TextStyle(fontSize: 55, color: Colors.white),
          //                   ),
          //                 ),
          //                 Container(
          //                   color: Colors.black26,
          //                   margin: EdgeInsets.symmetric(horizontal: 10),
          //                   child: Text(
          //                     "Knee pain can have causes that aren't due to underlying disease. Examples include heavy physical activity, lack of use, injuries",
          //                     style: TextStyle(
          //                       color: Colors.white,
          //                       fontSize: 15,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Align(
          //             alignment: Alignment.bottomRight,
          //             child: Container(
          //               height: size.height * .05,
          //               width: size.width * .4,
          //               alignment: Alignment.bottomRight,
          //               margin: EdgeInsets.all(10),
          //               color: Colors.blue,
          //               child: FlatButton(
          //                 onPressed: () {
          //                   Navigator.of(context)
          //                       .pushNamed(DemographicForm.routeName);
          //                 },
          //                 child: Text(
          //                   "Select Form",
          //                   style: TextStyle(color: Colors.white, fontSize: 20),
          //                 ),
          //               ),
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          InkWell(
            child: Container(
              height: MediaQuery.of(context).size.height * .3,
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: Colors.black,
                elevation: 10,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(.52),
                                BlendMode.dstATop),
                            image: AssetImage(
                              "assets/images/prosthetic.jpg",
                            )),
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Text(
                              "Prosthetic Forms",
                              style: TextStyle(
                                  fontSize: 50,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          // Container(
                          //   color: Colors.black26,
                          //   margin: EdgeInsets.symmetric(horizontal: 10),
                          //   child: Text(
                          //     "Knee pain can have causes that aren't due to underlying disease. Examples include heavy physical activity, lack of use, injuries",
                          //     style: TextStyle(
                          //       color: Colors.white,
                          //       fontSize: 15,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: size.height * .05,
                        width: size.width * .4,
                        alignment: Alignment.bottomRight,
                        margin: EdgeInsets.all(10),
                        color: Colors.blue,
                        child: FlatButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser.uid)
                                .collection('username')
                                .doc(username)
                                .get()
                                .then((value) {
                              value.exists
                                  ? Navigator.of(context).pushNamed(
                                      Prosthetic.routeName,
                                      arguments: username)
                                  : showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Alert!!"),
                                          content: Text(
                                              "You need to first complete your demographic form"),
                                          actions: [
                                            RaisedButton(
                                              color: Colors.blue,
                                              child: Text("Okay"),
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                            )
                                          ],
                                        );
                                      },
                                    );
                            });
                          },
                          child: Text(
                            "Select Form",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            child: Container(
              height: MediaQuery.of(context).size.height * .3,
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: Colors.black,
                elevation: 10,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(.52),
                                BlendMode.dstATop),
                            image: AssetImage(
                              "assets/images/orthetic.jpg",
                            )),
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Text(
                              "Orthotic\nForms",
                              style: TextStyle(
                                  fontSize: 50,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          // Container(
                          //   color: Colors.black26,
                          //   margin: EdgeInsets.symmetric(horizontal: 10),
                          //   child: Text(
                          //     "Knee pain can have causes that aren't due to underlying disease. Examples include heavy physical activity, lack of use, injuries",
                          //     style: TextStyle(
                          //       color: Colors.white,
                          //       fontSize: 15,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: size.height * .05,
                        width: size.width * .4,
                        alignment: Alignment.bottomRight,
                        margin: EdgeInsets.all(10),
                        color: Colors.blue,
                        child: FlatButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser.uid)
                                .collection('username')
                                .doc(username)
                                .get()
                                .then((value) {
                              value.exists
                                  ? Navigator.of(context).pushNamed(
                                      Orthotic.routeName,
                                      arguments: username)
                                  : showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Alert!!"),
                                          content: Text(
                                              "You need to first complete your demographic form"),
                                          actions: [
                                            RaisedButton(
                                              color: Colors.blue,
                                              child: Text("Okay"),
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                            )
                                          ],
                                        );
                                      },
                                    );
                            });
                          },
                          child: Text(
                            "Select Form",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            child: Container(
              height: MediaQuery.of(context).size.height * .3,
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: Colors.black,
                elevation: 10,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(.52),
                                BlendMode.dstATop),
                            image: AssetImage(
                              "assets/images/skeleton.jpg",
                            )),
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Text(
                              "Cosmetic\nRestoration",
                              style: TextStyle(
                                  fontSize: 50,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: size.height * .05,
                        width: size.width * .4,
                        alignment: Alignment.bottomRight,
                        margin: EdgeInsets.all(10),
                        color: Colors.blue,
                        child: FlatButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser.uid)
                                .collection('username')
                                .doc(username)
                                .get()
                                .then((value) {
                              value.exists
                                  ? Navigator.of(context).pushNamed(
                                      Cosmetic.routeName,
                                      arguments: username)
                                  : showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Alert!!"),
                                          content: Text(
                                              "You need to first complete your demographic form"),
                                          actions: [
                                            RaisedButton(
                                              color: Colors.blue,
                                              child: Text("Okay"),
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                            )
                                          ],
                                        );
                                      },
                                    );
                            });
                          },
                          child: Text(
                            "Select Form",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
