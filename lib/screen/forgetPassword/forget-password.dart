import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/screen/loginScreen/login.dart';
import 'package:project/widgets/authentication_background.dart';

class ForgetPassword extends StatefulWidget {
  static const routeName = '/forgePassword';
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool _isKeyboardVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  final _formKey = GlobalKey<FormState>();
  String email = '';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomPaint(
        painter: AuthenticationBackground(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!_isKeyboardVisible())
                  SizedBox(
                    height: size.height * .3,
                  ),
                Card(
                  elevation: 10,
                  shadowColor: Colors.blue,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/REHAB.png',
                        width: size.width * .6,
                        height: size.height * .25,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Reset Your Password",
                          style: GoogleFonts.lato(
                              fontSize: 20, color: Colors.black),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            decoration: InputDecoration(labelText: "Email"),
                            validator: (value) {
                              if (value.length == 0) {
                                return "please provide a email id";
                              }
                              if (!value.contains('@')) {
                                return "invalid email address";
                              } else {
                                email = value;
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        alignment: Alignment.centerRight,
                        child: RaisedButton(
                          color: Colors.blue.shade700,
                          child: Text(
                            "Submit",
                            style: GoogleFonts.lato(color: Colors.white),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              FirebaseAuth.instance
                                  .sendPasswordResetEmail(email: email)
                                  .then((value) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SimpleDialog(
                                        title: Container(child: Text("Done!!")),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text("Link sent to $email"),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            child: FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushReplacementNamed(
                                                          Login.routeName);
                                                },
                                                child: Text("Okay")),
                                          )
                                        ],
                                      );
                                    });
                              });
                            }
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.centerLeft,
                        child: RichText(
                            text: TextSpan(
                                text: "NOTE: ",
                                style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                children: [
                              TextSpan(
                                text:
                                    "A link will be send to your registered email. Click on the link to reset your password.",
                                style: GoogleFonts.lato(
                                  color: Colors.black,
                                ),
                              )
                            ])),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
