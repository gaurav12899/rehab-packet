import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/screen/homeScreen/app-drawer.dart';
import 'package:hexcolor/hexcolor.dart';

class AboutUs extends StatelessWidget {
  static const routeName = '/aboutUs';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: HexColor('4A6572'),
      appBar: AppBar(
        title: Text("About Us"),
      ),
      drawer: AppDrawer(
        home: true,
        aboutUs: false,
        contactUs: true,
        myPatient: true,
        profile: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/Rehab-without-bg.png',
              width: double.infinity,
              height: size.height * .25,
            ),
            Container(
              // padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                color: Colors.black,
                elevation: 20,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        "Access your patient data anytime, from anywhere!!",
                        style: GoogleFonts.lato(
                            color: HexColor('F9AA33'),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "\nPocket Rehab has been created with the aim of helping clinicians access their patient data and measurements from anywhere in the world. It will help you save time, energy and storage space. By saving your patient’s information on this app, you can be assured that the data is safe and completely confidential and will continue to be available to you as long as you would want to. With the ‘share’ feature, it is now even simpler to discuss your cases with experts, just by a single tap. ",
                        style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 17,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.black,
              child: ListTile(
                leading: Icon(
                  Icons.call,
                  color: Colors.green,
                ),
                title: Text(
                  "Phone:",
                  style: TextStyle(color: Colors.yellow),
                ),
                subtitle: Text(
                  "9315414056",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Card(
              color: Colors.black,
              child: ListTile(
                leading: Icon(
                  Icons.mail,
                  color: Colors.blue,
                ),
                title: Text(
                  "Email:",
                  style: TextStyle(color: Colors.yellow),
                ),
                subtitle: Text(
                  "tarunsaini510@gmail.com",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
