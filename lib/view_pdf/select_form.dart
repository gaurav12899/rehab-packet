import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/view_pdf/viewPdf.dart';

class SelectForm extends StatelessWidget {
  static const routeName = '/selectForm';

  @override
  Widget build(BuildContext context) {
    final patientId = ModalRoute.of(context).settings.arguments;

    return MaterialApp(
      title: 'Patient Forms',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Patient Forms'),
        ),
        body: Center(
          child: Container(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser.uid.toString())
                  .collection("username")
                  .doc(patientId)
                  .collection("formname")

                  // .doc(patientId)
                  // .collection()
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
                  final forms = snapshot.data.documents;
                  return Container(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigator.of(context).pushNamed(routeName);
                            print(forms[index].get('form').toString());
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    PdfScreen(forms[index]['form'])));
                          },
                          child: Card(
                            child: Text(forms[index].documentID),
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
      ),
    );
  }
}
