import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/screen/homeScreen/home_screen.dart';
import 'package:project/screen/signUpScreen/signup.dart';
import 'package:project/widgets/authentication_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../controllers/authentication.dart';

// import './components/body.dart';
class Login extends StatefulWidget {
  static const routeName = 'login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool _keyboardIsVisible() {
      return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
    }

    void _tryToLogin() {
      final isValid = _formKey.currentState.validate();
      if (isValid) {
        _formKey.currentState.save();
      } else {
        return;
      }
    }

    return Scaffold(
      body: CustomPaint(
        painter:
            AuthenticationBackground(isKeyboardVisible: _keyboardIsVisible()),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * .05, vertical: size.height * .05),
              width: double.infinity,
              child: Text(
                "Hello there,\nwelcome Back!!",
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
                              "LOGIN",
                              style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: Colors.blue.shade700,
                                  fontWeight: FontWeight.bold),
                            ),
                          SizedBox(height: 10),
                          Form(
                            child: Column(children: [
                              Container(
                                width: size.width * .9,
                                child: TextFormField(
                                  // autofocus: true,

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
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: size.width * .9,
                                child: TextFormField(
                                    // autofocus: true,
                                    focusNode: _passwordFocusNode,
                                    keyboardType: TextInputType.emailAddress,
                                    obscureText: _obscureText,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Password",
                                        prefixIcon: Icon(Icons.lock_rounded),
                                        suffixIcon: IconButton(
                                          icon: Icon(_obscureText
                                              ? Icons.visibility_off_rounded
                                              : Icons.visibility_rounded),
                                          onPressed: () {
                                            setState(() {
                                              _toggle();
                                            });
                                          },
                                        )),
                                    validator: (value) {
                                      if (value.length == 0) {
                                        return "Field can't be empty";
                                      }
                                      return null;
                                    }),
                              ),
                            ]),
                            key: _formKey,
                          ),
                          FlatButton(
                            onPressed: () {},
                            child: Text(
                              "Forget Password?",
                              style: GoogleFonts.lato(color: Colors.blue),
                            ),
                          ),
                          Container(
                            color: Colors.blue,
                            width: size.width * .6,
                            child: FlatButton(
                              onPressed: () {
                                _tryToLogin();
                              },
                              child: Text(
                                "Login",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      height: 5,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text("OR"),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      height: 5,
                    ),
                  )
                ],
              ),
            if (!_keyboardIsVisible())
              Container(
                width: size.width * .7,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  onPressed: () {
                    googleSignIn().then((value) {
                      if (value == null) {
                        print("some error occured");
                      } else {
                        User user = FirebaseAuth.instance.currentUser;

                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(uid: user.uid),
                          ),
                        );
                      }
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login with",
                        style: GoogleFonts.lato(fontSize: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset(
                        'assets/icons/google.svg',
                        width: 30,
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            if (!_keyboardIsVisible())
              SizedBox(
                height: size.height * .01,
              ),
            if (!_keyboardIsVisible())
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(Signup.routeName),
                child: RichText(
                  text: TextSpan(
                      text: "Do not have account? ",
                      style:
                          GoogleFonts.lato(color: Colors.black, fontSize: 15),
                      children: [
                        TextSpan(
                          text: "Signup",
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
