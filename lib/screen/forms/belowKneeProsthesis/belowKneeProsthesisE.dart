import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:project/main.dart';
import 'dart:ui' as ui;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:project/screen/homeScreen/new-or-old-patient.dart';

class BelowKneeProsthesisE extends StatefulWidget {
  static const routeName = '/belowKneeProsthesisE';

  @override
  _BelowKneeProsthesisEState createState() => _BelowKneeProsthesisEState();
}

class _BelowKneeProsthesisEState extends State<BelowKneeProsthesisE> {
  GlobalKey _containerKey = GlobalKey();

  final doc = pw.Document();

  bool loading = false;

  Future<Uint8List> _capturePng() async {
    RenderRepaintBoundary boundary =
        _containerKey.currentContext.findRenderObject();

    if (boundary.debugNeedsPaint) {
      print("Waiting for boundary to be painted.");
      await Future.delayed(const Duration(milliseconds: 20));
      return _capturePng();
    }

    var image = await boundary.toImage(
      pixelRatio: 2,
    );
    var byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );

    return byteData.buffer.asUint8List();
  }

  var doctorInfo;
  var patientInfo;
  void _printPngBytes(dynamic args) async {
    this.setState(() {
      loading = true;
    });
    doctorInfo = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    patientInfo = await FirebaseFirestore.instance
        .collection("users")
        .doc("${FirebaseAuth.instance.currentUser.uid}")
        .collection("username")
        .doc("${args["username"]}")
        .get();

    var pngBytes = await _capturePng();
    print(pngBytes);

    if (args['bytelist'].length > 4) {
      args['bytelist'].removeLast();
    }
    await args['bytelist'].add(pngBytes);

    print(args['bytelist'].length);
    final ByteData bytes = await rootBundle.load('assets/images/REHAB.jpg');
    final Uint8List list = bytes.buffer.asUint8List();
    final logo = PdfImage.file(doc.document, bytes: list);

    doc.addPage(pw.MultiPage(
        margin: pw.EdgeInsets.all(10),
        build: (pw.Context context) => [
              pw.Header(
                level: 0,
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      pw.Text('Below Kneee Prosthesis', textScaleFactor: 1),
                      pw.Image(logo, width: 60, height: 60)
                    ]),
              ),
              pw.Center(
                  child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                    pw.Column(children: [
                      pw.Text("Patient Information",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 35,
                            decoration: pw.TextDecoration.underline,
                          )),
                      pw.Text("PatientName: ${patientInfo['name']}",
                          style: pw.TextStyle(
                            fontStyle: pw.FontStyle.italic,
                            fontSize: 20,
                          )),
                      pw.Text("Age: ${patientInfo['age']}",
                          style: pw.TextStyle(
                            fontStyle: pw.FontStyle.italic,
                            fontSize: 20,
                          )),
                      pw.Text("Sex: ${patientInfo['gender']}",
                          style: pw.TextStyle(
                            fontStyle: pw.FontStyle.italic,
                            fontSize: 20,
                          )),
                    ]),
                    pw.Column(children: [
                      pw.Text("Doctor Information",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 35,
                            decoration: pw.TextDecoration.underline,
                          )),
                      pw.Text(
                          "BY:${doctorInfo['firstName']} ${doctorInfo['lastName']}",
                          style: pw.TextStyle(
                            fontStyle: pw.FontStyle.italic,
                            fontSize: 20,
                          )),
                      pw.Text("Phone:${doctorInfo['phone']} ",
                          style: pw.TextStyle(
                            fontStyle: pw.FontStyle.italic,
                            fontSize: 20,
                          )),
                      pw.Text("Address:${doctorInfo['address']} ",
                          style: pw.TextStyle(
                            fontStyle: pw.FontStyle.italic,
                            fontSize: 20,
                          )),
                    ])
                  ])),
              pw.Divider()
            ]));

    for (int i = 0; i < args['bytelist'].length; i++) {
      final image = PdfImage.file(
        doc.document,
        bytes: args['bytelist'][i],
      );

      doc.addPage(pw.MultiPage(
          margin: pw.EdgeInsets.all(10),
          build: (pw.Context context) => [
                pw.Header(
                  level: 0,
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: <pw.Widget>[
                        pw.Text('AFO Form', textScaleFactor: 1),
                        pw.Image(logo, width: 60, height: 60)
                      ]),
                ),
                pw.Center(
                  child: pw.Image(image, height: 700, fit: pw.BoxFit.fill),
                ),
                pw.Divider(),
              ]));
    }

    Directory directory = await getExternalStorageDirectory();
    String docpath = directory.path;
    final file = File('$docpath/${FirebaseAuth.instance.currentUser.uid}.pdf');

    file.writeAsBytesSync(doc.save(), flush: true);

    final ref = FirebaseStorage.instance
        .ref()
        .child(args["username"])
        .child("Below knee Pros.pdf");
    await ref.putFile(file).whenComplete(() => this.setState(() {
          loading = false;
        }));
    final url = await ref.getDownloadURL();
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc("${FirebaseAuth.instance.currentUser.uid}")
          .collection("username")
          .doc("${args["username"]}")
          .collection("formname")
          .doc("BelowKneePros")
          .set({"form": url});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text("Form Submitted!!"),
        duration: Duration(seconds: 3),
      ));
    } on Exception catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text("Something went wrong!!"),
        ),
      );
    }
    await Navigator.of(context)
        .pushNamedAndRemoveUntil(NewOrOldPatient.routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    var args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    print(args['bytelist'].length);

    return Scaffold(
      appBar: AppBar(
        title: Text("Below Knee prosthesis"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: SizedBox(
            // height: MediaQuery.of(context).size.height * .8,
            child: Column(
              children: [
                RepaintBoundary(
                  key: _containerKey,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .8,
                    child: Column(
                      children: [
                        Text(
                          "Other Information",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Expanded(
                                    child: Table(
                                  border: TableBorder.all(),
                                  children: [
                                    TableRow(
                                      decoration: BoxDecoration(),
                                      children: [
                                        SizedBox(
                                            child: TextField(
                                                // style: TextStyle(fontSize: 100),
                                                ))
                                      ],
                                    ),
                                    TableRow(
                                      children: [SizedBox(child: TextField())],
                                    ),
                                    TableRow(
                                      children: [SizedBox(child: TextField())],
                                    ),
                                    TableRow(
                                      children: [SizedBox(child: TextField())],
                                    ),
                                    TableRow(
                                      children: [SizedBox(child: TextField())],
                                    ),
                                    TableRow(
                                      children: [SizedBox(child: TextField())],
                                    ),
                                    TableRow(
                                      children: [SizedBox(child: TextField())],
                                    ),
                                    TableRow(
                                      children: [SizedBox(child: TextField())],
                                    ),
                                    TableRow(
                                      children: [SizedBox(child: TextField())],
                                    ),
                                    TableRow(
                                      children: [SizedBox(child: TextField())],
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * .8,
                  child: ElevatedButton(
                    child: loading
                        ? Row(
                            children: [
                              Text("Generating Doc",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10)),
                              SizedBox(
                                width: 20,
                              ),
                              CircularProgressIndicator(),
                            ],
                          )
                        : Text("Submit",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                    onPressed: loading
                        ? null
                        : () {
                            _printPngBytes(args);
                          },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Textfield extends StatelessWidget {
  final double top;
  final double left;
  final double height;
  final double width;
  final label;
  Textfield({
    @required this.top,
    @required this.left,
    @required this.height,
    @required this.width,
    @required this.label,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      height: height,
      width: width,
      child: Container(
        // color: Colors.white,
        width: 20,
        child: TextField(
          decoration: InputDecoration(labelText: label),
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
