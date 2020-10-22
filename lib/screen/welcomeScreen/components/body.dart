import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/components.dart/rounded_button.dart';
import 'package:project/constants.dart';
import 'package:project/screen/loginScreen/login.dart';
import 'package:project/screen/signUpScreen/signup.dart';
import 'background.dart';
import 'package:google_fonts/google_fonts.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: size.height * .1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [],
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundedButton(
                    text: "Login",
                    bgColor: kPrimaryColor,
                    press: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return Login();
                      }));
                    },
                  ),
                  RoundedButton(
                    text: "Signup",
                    bgColor: kPrimaryLightColor,
                    press: () {
                      Navigator.of(context).pushNamed(Signup.routeName);
                    },
                    textColor: Colors.black,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
