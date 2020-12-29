import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/screen/forgetPassword/forget-password.dart';
import 'package:project/screen/forms/Afo/afoA.dart';
import 'package:project/screen/forms/Afo/afoB.dart';
import 'package:project/screen/forms/Afo/afoC.dart';
import 'package:project/screen/forms/cosmetic.dart';
import 'package:project/screen/forms/orthotic.dart';
import 'package:project/screen/forms/prosthetic.dart';
import 'package:project/screen/homeScreen/home_screen.dart';
import 'package:project/screen/homeScreen/new-or-old-patient.dart';
import 'package:project/screen/loginScreen/login.dart';
import 'package:project/screen/profile/profile.dart';
import 'package:project/screen/signUpScreen/signup.dart';
import 'package:project/screen/forms/demographic_form.dart';
import 'package:project/screen/forms/knee_form.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primaryColor: kPrimaryColor,
        accentColor: kAccentCOlor,
        primarySwatch: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      title: "Rehab Pocket",
      home:
          //  AfoA(),
          FirebaseAuth.instance.currentUser == null
              ? Login()
              : NewOrOldPatient(),
      routes: {
        Signup.routeName: (ctx) => Signup(),
        Login.routeName: (ctx) => Login(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        ForgetPassword.routeName: (ctx) => ForgetPassword(),
        Profile.routeName: (ctx) => Profile(),
        DemographicForm.routeName: (ctx) => DemographicForm(),
        KneeForm.routeName: (ctx) => KneeForm(),
        Prosthetic.routeName: (ctxt) => Prosthetic(),
        Cosmetic.routeName: (ctxt) => Cosmetic(),
        Orthotic.routeName: (ctxt) => Orthotic(),
        AfoA.routeName: (ctxt) => AfoA(),
        AfoB.routeName: (ctxt) => AfoB(),
        AfoC.routeName: (ctxt) => AfoC(),
        NewOrOldPatient.routeName: (ctx) => NewOrOldPatient(),
      },
    );
  }
}
