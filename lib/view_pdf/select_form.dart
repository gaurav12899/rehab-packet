import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/screen/homeScreen/home_screen.dart';
import 'package:project/view_pdf/viewPdf.dart';

class SelectForm extends StatelessWidget {
  static const routeName = '/selectForm';
  final String patientId;
  SelectForm(this.patientId);

  @override
  Widget build(BuildContext context) {
    // final patientId = ModalRoute.of(context).settings.arguments;

    return MaterialApp(
      title: 'Patient Forms',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: [
            IconButton(
                icon: Icon(Icons.add_circle_rounded),
                onPressed: () async {
                  // .get();
                  // print(username);
                  Navigator.of(context)
                      .pushNamed(HomeScreen.routeName, arguments: patientId);
                })
          ],
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
                          onTap: () async {
                            // Navigator.of(context).pushNamed(routeName);
                            print(forms[index].get('form').toString());
                            final url = forms[index]['form'].toString();
                            // if (await canLaunch(url)) {
                            //   await launch(
                            //     url,
                            //   );
                            // }

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PdfScreen(url),
                              ),
                            );
                          },
                          child: Container(
                            height: 60,
                            child: Card(
                              child: ListTile(
                                // tileColor: Colors.blue.shade200,
                                leading: Container(
                                  child: SvgPicture.asset(
                                    'assets/images/file.svg',
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                                title: Text(
                                    "${index + 1}. ${forms[index].documentID}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    )),
                              ),
                            ),
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
