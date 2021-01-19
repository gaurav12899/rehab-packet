import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/screen/aboutUs/aboutUs.dart';
import 'package:project/screen/forgetPassword/forget-password.dart';
import 'package:project/screen/forms/Afo/afoA.dart';
import 'package:project/screen/forms/Afo/afoB.dart';
import 'package:project/screen/forms/Afo/afoC.dart';
import 'package:project/screen/forms/Kafo/kafoA.dart';
import 'package:project/screen/forms/Kafo/kfoaB.dart';
import 'package:project/screen/forms/Kafo/kfoac.dart';
import 'package:project/screen/forms/TransfemoralMeasurementForm/transfemoralMeasurementFormA.dart';
import 'package:project/screen/forms/TransfemoralMeasurementForm/transfemoralMeasurmentFormB.dart';
import 'package:project/screen/forms/belowKneeProsthesis/belowKneeProsthesisA.dart';
import 'package:project/screen/forms/belowKneeProsthesis/belowKneeProsthesisB.dart';
import 'package:project/screen/forms/belowKneeProsthesis/belowKneeProsthesisC.dart';
import 'package:project/screen/forms/belowKneeProsthesis/belowKneeProsthesisD.dart';
import 'package:project/screen/forms/belowKneeProsthesis/belowKneeProsthesisE.dart';
import 'package:project/screen/forms/cosmetic.dart';
import 'package:project/screen/forms/elbowOrthosis/elbowOrthosis.dart';
import 'package:project/screen/forms/elbowOrthosis/elbowOrthosisB.dart';
import 'package:project/screen/forms/elbowOrthosis/elbowOrthosisC.dart';
import 'package:project/screen/forms/orthotic.dart';
import 'package:project/screen/forms/prosthetic.dart';
import 'package:project/screen/forms/spinalOrthosis/spinalOrthosisA.dart';
import 'package:project/screen/forms/spinalOrthosis/spinalOrthosisB.dart';
import 'package:project/screen/forms/spinalOrthosis/spinalOrthosisC.dart';
import 'package:project/screen/forms/spinalOrthosis/spinalOrthosisD.dart';
import 'package:project/screen/forms/spinalOrthosis/spinalOrthosisE.dart';
import 'package:project/screen/forms/spinalOrthosis/spinalOrthosisF.dart';
import 'package:project/screen/forms/wristHandOrthosis/wristHandOrthosisA.dart';
import 'package:project/screen/forms/wristHandOrthosis/wristHandOrthosisB.dart';
import 'package:project/screen/homeScreen/home_screen.dart';
import 'package:project/screen/homeScreen/new-or-old-patient.dart';
import 'package:project/screen/loginScreen/login.dart';
import 'package:project/screen/profile/editProfile.dart';
import 'package:project/screen/profile/profile.dart';
import 'package:project/screen/showImage/show-image.dart';
import 'package:project/screen/signUpScreen/signup.dart';
import 'package:project/screen/forms/demographic_form.dart';
import 'package:project/screen/forms/knee_form.dart';
import 'package:project/view_pdf/pdf_list.dart';
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
      home: FirebaseAuth.instance.currentUser == null
          ? Login()
          : NewOrOldPatient(),
      routes: {
        Signup.routeName: (ctx) => Signup(),
        Login.routeName: (ctx) => Login(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        ForgetPassword.routeName: (ctx) => ForgetPassword(),
        Profile.routeName: (ctx) => Profile(),
        EditProfile.routeName: (ctx) => EditProfile(),
        DemographicForm.routeName: (ctx) => DemographicForm(),
        KneeForm.routeName: (ctx) => KneeForm(),
        Prosthetic.routeName: (ctxt) => Prosthetic(),
        Cosmetic.routeName: (ctxt) => Cosmetic(),
        Orthotic.routeName: (ctxt) => Orthotic(),
        AfoA.routeName: (ctxt) => AfoA(),
        AfoB.routeName: (ctxt) => AfoB(),
        AfoC.routeName: (ctxt) => AfoC(),
        KafoA.routeName: (ctxt) => KafoA(),
        KafoB.routeName: (ctxt) => KafoB(),
        KafoC.routeName: (ctxt) => KafoC(),
        NewOrOldPatient.routeName: (ctx) => NewOrOldPatient(),
        PdfList.routeName: (ctx) => PdfList(),
        AboutUs.routeName: (ctx) => AboutUs(),
        ShowImage.routeName: (ctx) => ShowImage(),
        BelowKneeProsthesisA.routeName: (ctx) => BelowKneeProsthesisA(),
        BelowKneeProsthesisB.routeName: (ctx) => BelowKneeProsthesisB(),
        BelowKneeProsthesisC.routeName: (ctx) => BelowKneeProsthesisC(),
        BelowKneeProsthesisD.routeName: (ctx) => BelowKneeProsthesisD(),
        BelowKneeProsthesisE.routeName: (ctx) => BelowKneeProsthesisE(),
        TransfemoralMeasurementA.routeName: (ctx) => TransfemoralMeasurementA(),
        TransfemoralMeasurementB.routeName: (ctx) => TransfemoralMeasurementB(),
        ElbowOrthosisA.routeName: (ctx) => ElbowOrthosisA(),
        ElbowOrthosisB.routeName: (ctx) => ElbowOrthosisB(),
        ElbowOrthosisC.routeName: (ctx) => ElbowOrthosisC(),
        WristHandOrthosisA.routeName: (ctx) => WristHandOrthosisA(),
        WristHandOrthosisB.routeName: (ctx) => WristHandOrthosisB(),
        SpinalOrthosisA.routeName: (ctx) => SpinalOrthosisA(),
        SpinalOrthosisB.routeName: (ctx) => SpinalOrthosisB(),
        SpinalOrthosisC.routeName: (ctx) => SpinalOrthosisC(),
        SpinalOrthosisD.routeName: (ctx) => SpinalOrthosisD(),
        SpinalOrthosisE.routeName: (ctx) => SpinalOrthosisE(),
        SpinalOrthosisF.routeName: (ctx) => SpinalOrthosisF(),
      },
    );
  }
}
