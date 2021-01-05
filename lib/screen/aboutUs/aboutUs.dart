import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/widgets/authentication_background.dart';

class AboutUs extends StatelessWidget {
  static const routeName = '/aboutUs';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: SingleChildScrollView(
        child: CustomPaint(
          painter: AuthenticationBackground(),
          child: Column(
            children: [
              SizedBox(
                height: 120,
              ),
              Image.asset(
                'assets/images/Rehab-without-bg.png',
                width: double.infinity,
                height: size.height * .25,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Access your patient data anytime, from anywhere!\nPocket Rehab has been created with the aim of helping clinicians access their patient data and measurements from anywhere in the world. It will help you save time, energy and storage space. By saving your patient’s information on this app, you can be assured that the data is safe and completely confidential and will continue to be available to you as long as you would want to. With the ‘share’ feature, it is now even simpler to discuss your cases with experts, just by a single tap. ",
                  style: GoogleFonts.lato(color: Colors.black, fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
