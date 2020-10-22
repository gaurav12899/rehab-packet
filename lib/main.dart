import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/screen/loginScreen/login.dart';
import 'package:project/screen/signUpScreen/signup.dart';
import './screen/welcomeScreen/welcome_screen.dart';
import 'constants.dart';
void main()async{
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
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: Colors.white,
       ),
    title: "Rehab Pocket",
      home: WelcomeScreen(),
      routes: {
        Signup.routeName:(ctx)=>Signup(),
        Login.routeName:(ctx)=>Login()
      },
    );
  }
}
