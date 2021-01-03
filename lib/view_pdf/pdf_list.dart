import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/view_pdf/select_form.dart';

class PdfList extends StatelessWidget {
  static const routeName = '/pdfList';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Names'),
      ),
      body: Center(
        child: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser.uid.toString())
                .collection("username")
                // .doc('0bZeDiEJVWiNYg7BkwEO')
                // .collection()
                .snapshots(),
            initialData: null,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                print("hello=======>>>");
                print(FirebaseAuth.instance.currentUser.uid.toString());
                final forms = snapshot.data.documents;
                print(forms.length);
                return Container(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(SelectForm.routeName,
                              arguments: forms[index].documentID);
                          // arguments: "j");
                        },
                        child: Card(
                          child: Text(forms[index]["name"]),
                        ),
                      );
                    },
                    itemCount: forms.length,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
