import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project/controllers/authentication.dart';
import 'package:project/screen/aboutUs/aboutUs.dart';
import 'package:project/screen/contactUs/contactUs.dart';
import 'package:project/screen/homeScreen/new-or-old-patient.dart';
import 'package:project/screen/profile/profile.dart';
import 'package:project/view_pdf/pdf_list.dart';
import '../loginScreen/login.dart';

class AppDrawer extends StatefulWidget {
  final bool home;
  final bool profile;
  final bool aboutUs;
  final bool contactUs;
  final bool myPatient;
  AppDrawer(
      {@required this.home,
      @required this.profile,
      @required this.aboutUs,
      @required this.contactUs,
      @required this.myPatient});
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Drawer(
      child: Column(
        children: [
          Column(
            children: [
              Image.asset(
                'assets/images/Rehab-without-bg.png',
                width: double.infinity,
                height: size.height * .3,
              ),
            ],
          ),
          Expanded(
            child: Container(
              color: HexColor('344955'),
              child: Column(
                children: [
                  SizedBox(
                    height: 2,
                  ),
                  ListTile(
                      tileColor: widget.home ? null : HexColor('F9AA33'),
                      leading: Icon(Icons.home, color: Colors.white),
                      title: Text(
                        'Home',
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      onTap: !widget.home
                          ? null
                          : () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (ctx) => NewOrOldPatient()));
                            }),

                  ListTile(
                    tileColor: widget.profile ? null : HexColor('F9AA33'),
                    leading: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Profile',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    onTap: !widget.profile
                        ? null
                        : () {
                            Navigator.pushReplacement(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => Profile()));
                          },
                  ),

                  ListTile(
                    tileColor: widget.myPatient ? null : HexColor('F9AA33'),
                    leading: Icon(
                      Icons.list,
                      color: Colors.white,
                    ),
                    title: Text(
                      'My Patients',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    onTap: !widget.myPatient
                        ? null
                        : () {
                            Navigator.pushReplacement(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => PdfList()));
                          },
                  ),
                  // Divider(color: Colors.grey,),
                  ListTile(
                    tileColor: widget.aboutUs ? null : HexColor('F9AA33'),
                    leading: Icon(
                      Icons.info_sharp,
                      color: Colors.white,
                    ),
                    title: Text(
                      'About Us',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    onTap: !widget.aboutUs
                        ? null
                        : () {
                            Navigator.pushReplacement(context,
                                new MaterialPageRoute(builder: (context) {
                              return AboutUs();
                            }));
                          },
                  ),
                  // Divider(color: Colors.grey,),

                  ListTile(
                    tileColor: widget.contactUs ? null : HexColor('F9AA33'),
                    leading: Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Contact Us',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    onTap: !widget.contactUs
                        ? null
                        : () {
                            Navigator.pushReplacement(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => ContactUs()));
                          },
                  ),

                  Divider(
                    color: Colors.white,
                  ),
                  ListTile(
                      leading: Icon(
                        Icons.exit_to_app,
                        color: HexColor('F9AA33'),
                      ),
                      title: Text(
                        'Logout',
                        style: GoogleFonts.lato(
                            color: HexColor('F9AA33'),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        signOut().then((value) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => Login()),
                              (Route<dynamic> route) => false);
                          // Provider.of<Auth>(context, listen: false).logout();
                        });
                      })
                ],
              ),
            ),
          ),
        ],
      ),
      elevation: 10,
    );
  }
}
