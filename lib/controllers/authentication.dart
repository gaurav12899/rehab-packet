import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'dart:ui' as ui;

FirebaseAuth auth = FirebaseAuth.instance;
final gSignIn = GoogleSignIn();

signUp(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid.toString())
        .set(({"email": email}));
    User user = FirebaseAuth.instance.currentUser;
    if (!user.emailVerified) {
      await user.sendEmailVerification();

      return ("signUpSuccessful");
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return ('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      return ('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
    return ("Something went wrong!!");
  }
}

loginWithEmail(String email, String password) async {
  final auth = FirebaseAuth.instance;
  try {
    UserCredential result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    if (!result.user.emailVerified) {
      print("User is not verified");
      await result.user.sendEmailVerification();
      return "User not Verified,verification link sent to your email.";
    } else {
      return "signInSuccessful";
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return ('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      return ('Wrong password provided for that user.');
    }
  } catch (e) {
    return "Something went wrong";
  }
}
// if (!result.user.emailVerified) {
//   print("User is not verified");
//   return Future.value(" ");
// } else {
//   return Future.value(result);
// }

googleSignIn() async {
  GoogleSignInAccount googleSignInAccount =
      await gSignIn.signIn().catchError((onError) {
    print("error $onError");
    return Future.value(true);
  });

  if (googleSignInAccount != null) {
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    UserCredential result =
        await auth.signInWithCredential(credential).catchError((onError) {
      print("error occured here!!");
      return Future.value(true);
    });

    User user = result.user;
    print(user.uid);

    return Future.value(true);
  }
}

// Future<>

Future<bool> signOut() async {
  User user = auth.currentUser;
  // print(user.providerData[1].providerId);
  print(user.providerData);
  if (user.providerData[0].providerId == 'google.com') {
    print(user.providerData[0].providerId);
    await gSignIn.signOut();
  }
  await auth.signOut();

  return Future.value(true);
}
