import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/screen/forms/demographic_form.dart';
import 'package:project/view_pdf/pdf_list.dart';
import './app-drawer.dart';
import 'package:hexcolor/hexcolor.dart';

class NewOrOldPatient extends StatefulWidget {
  static const routeName = "/new-or-old";

  @override
  _NewOrOldPatientState createState() => _NewOrOldPatientState();
}

class _NewOrOldPatientState extends State<NewOrOldPatient> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          // FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Rehab Pocket"),
          ),
          drawer: AppDrawer(
            home: false,
            aboutUs: true,
            contactUs: true,
            myPatient: true,
            profile: true,
          ),
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
                  Container(
                    // color: Colors.blue.shade100,
                    child: Text(
                      "Without the right data, we are just \n another person with an opinion.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        color: HexColor("000014"),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          primary: HexColor('344955'),
                        ),
                        child: Text(
                          "New Patient",
                          style: GoogleFonts.lato(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            DemographicForm.routeName,
                          );
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                        child: Text(
                          "Existing Patient",
                          style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PdfList()));
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
