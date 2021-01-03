import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/controllers/authentication.dart';
import 'package:project/screen/profile/profile.dart';
import 'package:project/view_pdf/pdf_list.dart';
import '../loginScreen/login.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Column(
        children: [
          // AppBar(
          //   title: Text("Hello User!"),
          //   automaticallyImplyLeading: false,
          // ), //never apply backbutton if false,
          // Divider(),
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
              color: Colors.blue,
              child: Column(
                children: [
                  ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Profile',
                        style:
                            GoogleFonts.lato(color: Colors.white, fontSize: 15),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(Profile.routeName);
                      }),

                  ListTile(
                      leading: Icon(
                        Icons.list,
                        color: Colors.white,
                      ),
                      title: Text(
                        'My Forms',
                        style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        print(FirebaseAuth.instance.currentUser.uid.toString());
                        Navigator.of(context).pushNamed(PdfList.routeName);
                      }),
                  // Divider(color: Colors.grey,),
                  ListTile(
                      leading: Icon(
                        Icons.info_sharp,
                        color: Colors.white,
                      ),
                      title: Text(
                        'About Us',
                        style:
                            GoogleFonts.lato(color: Colors.white, fontSize: 15),
                      ),
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('');
                        // Navigator.of(context).pushReplacement(CustomRoute(builder:(context)=>OrderScreen()));
                      }),
                  // Divider(color: Colors.grey,),

                  ListTile(
                      leading: Icon(
                        Icons.contact_support_rounded,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Contact Us',
                        style:
                            GoogleFonts.lato(color: Colors.white, fontSize: 15),
                      ),
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/');
                      }),

                  ListTile(
                      leading: Icon(
                        Icons.feedback,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Feedback',
                        style:
                            GoogleFonts.lato(color: Colors.white, fontSize: 15),
                      ),
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/');
                      }),
                  Divider(
                    color: Colors.grey,
                  ),
                  ListTile(
                      leading: Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                      ),
                      title: Text('Logout',
                          style: GoogleFonts.lato(
                              color: Colors.white, fontSize: 15)),
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
    );
  }
}
