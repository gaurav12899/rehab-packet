import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final gSignIn = GoogleSignIn();

showErrDialog(BuildContext context, String err) {
  // to hide the keyboard, if it is still p
  FocusScope.of(context).requestFocus(new FocusNode());
  return showDialog(
    context: context,
    child: AlertDialog(
      title: Text("Error"),
      content: Text(err),
      actions: <Widget>[
        OutlineButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Ok"),
        ),
      ],
    ),
  );
}

signUp() async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: "gjain8369@gmail.com", password: "gaurav750@");

    User user = FirebaseAuth.instance.currentUser;
    if (!user.emailVerified) {
      await user.sendEmailVerification();
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}

Future<bool> googleSignIn() async {
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
