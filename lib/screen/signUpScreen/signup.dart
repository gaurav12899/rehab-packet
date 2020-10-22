import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/controllers/authentication.dart';
import 'package:project/screen/homeScreen/home_screen.dart';
import 'package:project/screen/loginScreen/login.dart';
import 'package:project/screen/welcomeScreen/components/background.dart';
import 'package:project/widgets/authentication_background.dart';

class Signup extends StatefulWidget {
  static const routeName = '/signupScreen';
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _obscureText = true;
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
                          Container(
                            width: size.width * .9,
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Email",
                                prefixIcon: Icon(Icons.email_rounded),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: size.width * .9,
                            child: TextField(
                              // autofocus: true,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Choose Password",
                                  prefixIcon: Icon(Icons.lock_rounded),
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.visibility_off_rounded),
                                    onPressed: () {
                                      setState(() {
                                        _toggle();
                                      });
                                    },
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: size.width * .9,
                            child: TextField(
                              // autofocus: true,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Confirm Password",
                                  prefixIcon: Icon(Icons.lock_rounded),
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.visibility_off_rounded),
                                    onPressed: () {
                                      setState(() {
                                        _toggle();
                                      });
                                    },
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            color: Colors.blue,
                            width: size.width * .6,
                            child: FlatButton(
                              onPressed: () {},
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
