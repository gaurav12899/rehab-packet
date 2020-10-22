import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      // height: size.height,
      // width: double.infinity,
      bottom: false,
      child: Stack(
        children: [
          Column(
            children: [
              Image.asset(
                'assets/images/REHAB.png',
                width: double.infinity,
                height: size.height * .4,
              ),
              Text("Welcome",
                  style: GoogleFonts.lato(
                      fontSize: 40, color: Colors.blue.shade900)),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/images/welcome.png',
              width: size.width,
              fit: BoxFit.fitWidth,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
