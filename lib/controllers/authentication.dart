import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final gSignIn = GoogleSignIn();

signUp(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    User user = FirebaseAuth.instance.currentUser;
    print(user.emailVerified);
    // if (user.emailVerified) {
    print("creatig");
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .set({'emailID': user.email});
    print("done");
    // }
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
      print(FirebaseAuth.instance.currentUser.uid);

      final ref = FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser.uid);

      ref.snapshots().listen((event) {
        if (event.data().containsKey('firstName')) {
          return null;
        } else {
          ref.update({
            'firstName': "",
            'address': '',
            'emailID': email,
            'phone': "",
            'dob': '',
            'gender': 'male',
            'qualification': '',
            'state': '',
            'lastName': "",
            'profileUrl': '',
          }).whenComplete(() => print("donee"));
        }
      });
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
    print(credential);
    UserCredential result =
        await auth.signInWithCredential(credential).catchError((onError) {
      print("error occured here!!");
      return Future.value(true);
    });

    User user = result.user;
    String name;
    String email;
    String imageUrl;
    String firstName;
    String lastName;
    String phone;

    if (user != null) {
      // Add the following lines after getting the user
      // Checking if email and name is null
      assert(user.email != null);
      assert(user.displayName != null);
      assert(user.photoURL != null);

      // Store the retrieved data
      name = user.displayName;
      email = user.email;
      imageUrl = user.photoURL;
      phone = user.phoneNumber;

      // Only taking the first part of the name, i.e., First Name
      if (name.contains(" ")) {
        lastName = name.substring(
          name.indexOf(" "),
        );
        firstName = name.substring(0, name.indexOf(" "));
      }
      print(imageUrl);
    }

    final ref = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid);
    ref.snapshots().listen((event) {
      if (event.data().containsKey('firstName')) {
        return null;
      } else {
        ref.set({
          'firstName': firstName,
          'address': '',
          'emailID': email,
          'phone': phone ?? "",
          'dob': '',
          'gender': 'male',
          'qualification': '',
          'state': '',
          'lastName': lastName,
          'profileUrl': imageUrl,
        });
      }
    });

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
