import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/controllers/authentication.dart';
import 'package:project/screen/homeScreen/home_screen.dart';
import 'package:project/screen/loginScreen/login.dart';
import 'package:project/widgets/authentication_background.dart';

class Signup extends StatefulWidget {
  static const routeName = '/signupScreen';
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  final credential = {'email': '', 'password': ''};
  bool isLoading = false;
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _password = TextEditingController();
  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool _keyboardIsVisible() {
      return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
    }

    void _tryToSignup(BuildContext context) {
      print("validating");
      final isValid = _formKey.currentState.validate();
      if (isValid) {
        _formKey.currentState.save();
        setState(() {
          isLoading = true;
        });

        signUp(credential['email'], credential['password']).then((value) {
          if (value == null) {
            setState(() {
              isLoading = false;
            });
          } else {
            return;
          }
        });
      }
    }

    return Scaffold(
      body: CustomPaint(
        painter: AuthenticationBackground(),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * .05, vertical: size.height * .05),
              width: double.infinity,
              child: Text(
                "Welcome to \nthe Family!!",
                style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: size.width * .06,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
                height: (_keyboardIsVisible())
                    ? size.height * 0
                    : size.height * .08),
            Expanded(
              child: Container(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return SingleChildScrollView(
                      child: Column(
                        // mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/REHAB.png',
                            width: size.width * .4,
                            height: size.height * .18,
                          ),
                          if (!_keyboardIsVisible())
                            Text(
                              "Signup",
                              style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: Colors.blue.shade700,
                                  fontWeight: FontWeight.bold),
                            ),
                          SizedBox(height: 10),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Container(
                                  width: size.width * .9,
                                  child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Email",
                                        prefixIcon: Icon(Icons.email_rounded),
                                      ),
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context)
                                            .requestFocus(_passwordFocusNode);
                                      },
                                      validator: (value) {
                                        if (value.length == 0) {
                                          return "Field can't be empty";
                                        } else if (!value.contains('@')) {
                                          return "Please provide a valide email address";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        credential['email'] = value;
                                      }),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: size.width * .9,
                                  child: TextFormField(
                                    // focusNode: _passwordFocusNode,
                                    // autofocus: true,
                                    keyboardType: TextInputType.emailAddress,
                                    obscureText: _obscureText1,
                                    controller: _password,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Choose Password",
                                      prefixIcon: Icon(Icons.lock_rounded),
                                      suffixIcon: IconButton(
                                        icon: Icon(_obscureText1
                                            ? Icons.visibility_off_rounded
                                            : Icons.visibility_rounded),
                                        onPressed: () {
                                          setState(() {
                                            _toggle1();
                                          });
                                        },
                                      ),
                                    ),
                                    focusNode: _passwordFocusNode,
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context).requestFocus(
                                          _confirmPasswordFocusNode);
                                    },
                                    validator: (value) {
                                      if (value.length == 0) {
                                        return "Field can't be empty";
                                      }
                                      if (value.length < 6) {
                                        return "password can't be less than 6 characters";
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      credential['password'] = value;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: size.width * .9,
                                  child: TextFormField(
                                      // autofocus: true,
                                      // focusNode: _confirmPasswordFocusNode,
                                      obscureText: _obscureText2,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "Confirm Password",
                                          prefixIcon: Icon(Icons.lock_rounded),
                                          suffixIcon: IconButton(
                                            icon: Icon(_obscureText2
                                                ? Icons.visibility_off_rounded
                                                : Icons.visibility_rounded),
                                            onPressed: () {
                                              setState(() {
                                                _toggle2();
                                              });
                                            },
                                          )),
                                      focusNode: _confirmPasswordFocusNode,
                                      validator: (value) {
                                        if (value != _password.text) {
                                          print(credential['password']);
                                          return "password do not match";
                                        }
                                        if (value.length == 0) {
                                          return "Field can't be empty";
                                        }
                                        return null;
                                      }),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          (isLoading)
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Container(
                                  color: Colors.blue,
                                  width: size.width * .6,
                                  child: FlatButton(
                                    onPressed: () {
                                      _tryToSignup(context);
                                    },
                                    child: Text(
                                      "Signup",
                                      style: GoogleFonts.lato(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            if (!_keyboardIsVisible())
              SizedBox(
                height: size.height * .02,
              ),
            if (_keyboardIsVisible()) Divider(color: Colors.black),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(Login.routeName),
              child: RichText(
                text: TextSpan(
                    text: "Already have a acount? ",
                    style: GoogleFonts.lato(color: Colors.black, fontSize: 15),
                    children: [
                      TextSpan(
                        text: "SignIn",
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )
                    ]),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      // ),
    );
  }
}
