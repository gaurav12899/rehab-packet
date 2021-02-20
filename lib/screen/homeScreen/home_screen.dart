import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/screen/forms/FormType/cosmetic.dart';
import 'package:project/screen/forms/FormType/orthotic.dart';
import 'package:project/screen/forms/FormType/prosthetic.dart';
import 'package:project/screen/homeScreen/new-or-old-patient.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homescreen';
  final String uid;
  HomeScreen({this.uid});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

Image myImage1;
Image myImage2;
Image myImage3;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    myImage1 = Image.asset("assets/images/prosthetic.jpg");
    myImage2 = Image.asset("assets/images/orthetic.jpg");
    myImage3 = Image.asset("assets/images/skeleton.jpg");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(myImage1.image, context);
    precacheImage(myImage2.image, context);
    precacheImage(myImage3.image, context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Form Type"),
      ),
      body: ListView(
        children: [
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
                            image: myImage1.image),
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
                                .doc(widget.uid)
                                .get()
                                .then((value) {
                              value.exists
                                  ? Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              Prosthetic(widget.uid)))
                                  : showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Alert!!"),
                                          content: Text(
                                              "You need to first complete your demographic form"),
                                          actions: [
                                            ElevatedButton(
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
                            image: myImage2.image),
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
                        child: TextButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser.uid)
                                .collection('username')
                                .doc(widget.uid)
                                .get()
                                .then((value) {
                              value.exists
                                  ? Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              Prosthetic(widget.uid)))
                                  : showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Alert!!"),
                                          content: Text(
                                              "You need to first complete your demographic form"),
                                          actions: [
                                            TextButton(
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
                            image: myImage3.image),
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
                        child: TextButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser.uid)
                                .collection('username')
                                .doc(widget.uid)
                                .get()
                                .then((value) {
                              value.exists
                                  ? Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (ctx) =>
                                              Cosmetic(widget.uid)))
                                  : showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Alert!!"),
                                          content: Text(
                                              "You need to first complete your demographic form"),
                                          actions: [
                                            ElevatedButton(
                                              // style: ButtonStyle(backgroundColor: Color.blue),
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
