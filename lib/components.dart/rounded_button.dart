import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:project/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color bgColor, textColor;
  const RoundedButton({
    Key key,
    this.textColor = Colors.white,
    @required this.bgColor,
    @required this.press,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .45,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          color: bgColor,
          onPressed: press,
          child: Text(
            text,
            style: GoogleFonts.lato(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
