import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/screen/forms/demographic_form.dart';
import './app-drawer.dart';
import 'package:hexcolor/hexcolor.dart';

class NewOrOldPatient extends StatelessWidget {
  static const routeName = "/new-or-old";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Rehab Pocket"),
      ),
      drawer: AppDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Image.asset(
                'assets/images/Rehab-without-bg.png',
                width: double.infinity,
                height: size.height * .3,
              ),
              Text(
                "Without the right data, we are just \n another person with an opinion.",
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  color: HexColor("000014"),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: size.width * .8,
                  color: HexColor("60656F"),
                  child: FlatButton(
                      child: Text(
                        "New Patient",
                        style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          DemographicForm.routeName,
                        );
                      })),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: size.width * .8,
                  color: HexColor("279AF1"),
                  child: FlatButton(
                      child: Text(
                        "Existing Patient",
                        style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        // Navigator.of(context).pushReplacement(
                        //   MaterialPageRoute(
                        //       builder: (BuildContext context) => ()),
                        // );
                      })),
            ],
          ),
        ],
      ),
    );
  }
}
