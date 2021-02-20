import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project/screen/aboutUs/aboutUs.dart';
import 'package:project/screen/contactUs/contactUs.dart';
import 'package:project/screen/forgetPassword/forget-password.dart';
import 'package:project/screen/forms/Cosmetic%20Forms/CosmeticRestorationHand/cosmeticRestorationHandA.dart';
import 'package:project/screen/forms/Cosmetic%20Forms/cosmeticRestorationFingers/cosmeticRestFingersA.dart';
import 'package:project/screen/forms/FormType/cosmetic.dart';
import 'package:project/screen/forms/FormType/orthotic.dart';
import 'package:project/screen/forms/FormType/prosthetic.dart';
import 'package:project/screen/forms/orthotic%20Forms/Afo/afoA.dart';
import 'package:project/screen/forms/orthotic%20Forms/HKAFO/hkafoA.dart';
import 'package:project/screen/forms/orthotic%20Forms/Kafo/kafoA.dart';
import 'package:project/screen/forms/orthotic%20Forms/elbowOrthosis/elbowOrthosis.dart';
import 'package:project/screen/forms/orthotic%20Forms/spinalOrthosis/spinalOrthosisA.dart';
import 'package:project/screen/forms/orthotic%20Forms/wristHandOrthosis/wristHandOrthosisA.dart';

import 'package:project/screen/forms/prostheticForms/TransfemoralMeasurementForm/transfemoralMeasurementFormA.dart';
import 'package:project/screen/forms/prostheticForms/aboveElbowProsthesis/aboveElbowProsthesis.dart';
import 'package:project/screen/forms/prostheticForms/belowElbowProsthesis/belowElbowProsthesis.dart';
import 'package:project/screen/forms/prostheticForms/belowKneeProsthesis/belowKneeProsthesisA.dart';
import 'package:project/screen/homeScreen/home_screen.dart';
import 'package:project/screen/homeScreen/new-or-old-patient.dart';
import 'package:project/screen/loginScreen/login.dart';
import 'package:project/screen/profile/editProfile.dart';
import 'package:project/screen/profile/profile.dart';
import 'package:project/screen/signUpScreen/signup.dart';
import 'package:project/screen/forms/demographic_form.dart';
import 'package:project/view_pdf/pdf_list.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Define the default brightness and colors.
        // brightness: Brightness.,
        primaryColor: HexColor('#1e88e5'),

        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        ),
      ),
      title: "Rehab Pocket",
      home: FirebaseAuth.instance.currentUser == null
          ? Login()
          : NewOrOldPatient(),
      showSemanticsDebugger: false,
      routes: {
        Signup.routeName: (ctx) => Signup(),
        Login.routeName: (ctx) => Login(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        ForgetPassword.routeName: (ctx) => ForgetPassword(),
        Profile.routeName: (ctx) => Profile(),
        EditProfile.routeName: (ctx) => EditProfile(),
        DemographicForm.routeName: (ctx) => DemographicForm(),
        NewOrOldPatient.routeName: (ctx) => NewOrOldPatient(),
        PdfList.routeName: (ctx) => PdfList(),
        AboutUs.routeName: (ctx) => AboutUs(),
        ContactUs.routeName: (ctx) => ContactUs(),
      },
    );
  }
}
