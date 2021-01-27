import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/screen/homeScreen/app-drawer.dart';
import 'package:project/screen/profile/editProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  static const routeName = "/profile";

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var userInfo;
    Map userDetails = {
      'firstName': '',
      'address': '',
      'emailID': '',
      'phone': '',
      'dob': '',
      'gender': 'male',
      'qualification': '',
      'state': '',
      'lastName': '',
    };
    return Scaffold(
        // backgroundColor: Colors.black,
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text("Profile"),
          actions: [
            IconButton(
              padding: EdgeInsets.symmetric(horizontal: 20),
              icon: Icon(Icons.edit, color: Colors.white),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProfile.routeName, arguments: userDetails);
              },
            )
          ],
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser.uid.toString())
                .snapshots(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                userInfo = snapshot.data;
                userDetails['firstName'] = userInfo['firstName'];
                userDetails['lastName'] = userInfo['lastName'];
                userDetails['qualification'] = userInfo['qualification'];
                userDetails['phone'] = userInfo['phone'];
                userDetails['address'] = userInfo['address'];
                userDetails['state'] = userInfo['state'];
                userDetails['dob'] = userInfo['dob'];
                userDetails['gender'] = userInfo['gender'];
                userDetails['profileUrl'] = userInfo['profileUrl'];
                userDetails['emailID'] = userInfo['emailID'];

                return Container(
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ListView(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: (userDetails['profileUrl'] ==
                                                  '')
                                              ? AssetImage(
                                                  'assets/images/doctor.png')
                                              : NetworkImage(
                                                  userDetails['profileUrl']),
                                        ),
                                      ),
                                      height: 250,
                                      width: double.infinity,
                                      child: ClipRect(
                                        child: BackdropFilter(
                                          child: Container(
                                            decoration: new BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.0),
                                            ),
                                          ),
                                          filter: ImageFilter.blur(
                                              sigmaX: 3.0, sigmaY: 3.0),
                                        ),
                                      )),
                                  Positioned(
                                    bottom: 10,
                                    left: 10,
                                    child: Container(
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: 200,
                                            height: 200,
                                            // margin: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 2,
                                                color: Colors.white,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                    spreadRadius: 2,
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    blurRadius: 10,
                                                    offset: Offset(0, 10)),
                                              ],
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: (userDetails[
                                                            'profileUrl'] ==
                                                        '')
                                                    ? AssetImage(
                                                        'assets/images/doctor.png')
                                                    :
                                                    // image
                                                    NetworkImage(
                                                        userDetails[
                                                            'profileUrl'],
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (userInfo['firstName'] != '')
                                    Positioned(
                                      left: MediaQuery.of(context).size.width -
                                          195,
                                      top: 200,
                                      child: Container(
                                        width: 150,
                                        height: 30,
                                        child: FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Chip(
                                            backgroundColor: Colors.black87,
                                            label: Text(
                                                "${userInfo['firstName']} ${userInfo['lastName']}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                              Card(
                                elevation: 10,
                                color: Colors.white,
                                child: Container(
                                  child: Column(
                                    children: [
                                      ListTile(
                                          leading: Icon(
                                            Icons.person,
                                            color: Colors.blue,
                                          ),
                                          title: Text(
                                            "Name",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                          subtitle: Text(
                                              "${userInfo['firstName']} ${userInfo['lastName']} ")),
                                      Divider(
                                        color: Colors.blue,
                                      ),
                                      ListTile(
                                          leading: Icon(
                                            Icons.phone,
                                            color: Colors.blue,
                                          ),
                                          title: Text(
                                            'Phone',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                          subtitle:
                                              Text("${userInfo['phone']} ")),
                                      Divider(
                                        color: Colors.blue,
                                      ),
                                      ListTile(
                                          leading: Icon(
                                            Icons.email,
                                            color: Colors.blue,
                                          ),
                                          title: Text(
                                            'Email',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                          subtitle:
                                              Text("${userInfo['emailID']} ")),
                                      Divider(
                                        color: Colors.blue,
                                      ),
                                      ListTile(
                                          leading: Icon(
                                            Icons.book,
                                            color: Colors.blue,
                                          ),
                                          title: Text(
                                            'Qualification',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                          subtitle: Text(
                                              "${userInfo['qualification']}")),
                                      Divider(
                                        color: Colors.blue,
                                      ),
                                      ListTile(
                                          leading: Icon(
                                            Icons.map,
                                            color: Colors.blue,
                                          ),
                                          title: Text(
                                            'Address',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                          subtitle:
                                              Text("${userInfo['address']}")),
                                      Divider(
                                        color: Colors.blue,
                                      ),
                                      ListTile(
                                          leading: Icon(
                                            Icons.pin_drop,
                                            color: Colors.blue,
                                          ),
                                          title: Text(
                                            'State',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                          subtitle:
                                              Text("${userInfo['state']} ")),
                                      Divider(
                                        color: Colors.blue,
                                      ),
                                      ListTile(
                                          leading: Icon(
                                            Icons.emoji_people,
                                            color: Colors.blue,
                                          ),
                                          title: Text(
                                            'Sex',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                          subtitle: Text(
                                              "${userInfo['gender'].toUpperCase()}")),
                                      Divider(
                                        color: Colors.blue,
                                      ),
                                      ListTile(
                                          leading: Icon(
                                            Icons.celebration,
                                            color: Colors.blue,
                                          ),
                                          title: Text(
                                            'Date Of Birth',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                          subtitle: Text(
                                              "${userInfo['dob'].toUpperCase()}")),
                                      Divider(
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }));
  }
}
