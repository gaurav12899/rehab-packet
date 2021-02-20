import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project/screen/homeScreen/home_screen.dart';
import 'package:project/view_pdf/viewPdf.dart';

class SelectForm extends StatefulWidget {
  static const routeName = '/selectForm';
  final String patientId;
  SelectForm(this.patientId);

  @override
  _SelectFormState createState() => _SelectFormState();
}

class _SelectFormState extends State<SelectForm> {
  @override
  Widget build(BuildContext context) {
    // final patientId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Patient Forms'),
      ),
      body: Center(
        child: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser.uid.toString())
                .collection("username")
                .doc(widget.patientId)
                .collection("formname")
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
                          final url = forms[index]['form'].toString();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PdfScreen(url),
                            ),
                          );
                        },
                        child: Container(
                          height: 70,
                          child: Card(
                            color: HexColor('4A6572'),
                            child: ListTile(
                              // tileColor: Colors.blue.shade200,
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: HexColor('F9AA33'),
                                  // color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () {
                                  return showDialog(
                                      context: context,
                                      builder: (BuildContext ctx) {
                                        return AlertDialog(
                                          title: Text('Are you sure?'),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Text(
                                                    '${forms[index].documentID} will be deleted Permanently'),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('cancel'),
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: Text(
                                                'Delete',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              onPressed: () async {
                                                final formId = FirebaseFirestore
                                                    .instance
                                                    .collection("users")
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser.uid
                                                        .toString())
                                                    .collection("username")
                                                    .doc(widget.patientId)
                                                    .collection('formname')
                                                    .doc(forms[index]
                                                        .documentID);
                                                final Reference docStoragepath =
                                                    FirebaseStorage.instance
                                                        .ref()
                                                        .child(FirebaseAuth
                                                            .instance
                                                            .currentUser
                                                            .uid)
                                                        .child(widget.patientId)
                                                        .child(
                                                            "${forms[index].documentID}.pdf");
                                                docStoragepath.delete();

                                                await formId.delete();

                                                setState(() {
                                                  Navigator.of(ctx).pop();
                                                });
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                              ),
                              leading: Container(
                                child: SvgPicture.asset(
                                  'assets/images/file.svg',
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              title: Text(" ${forms[index].documentID}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeScreen(
              uid: widget.patientId,
            ),
          ));

          // (HomeScreen.routeName, arguments: widget.patientId);
        },
        child: Icon(
          Icons.add_circle_outlined,
          color: Colors.white,
        ),
        elevation: 20,
        backgroundColor: Colors.blue,
      ),
    );
  }
}
