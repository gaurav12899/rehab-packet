import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:image_pixels/image_pixels.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:project/screen/homeScreen/new-or-old-patient.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'dart:ui' as ui;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class ElbowOrthosisC extends StatefulWidget {
  static const routeName = '/elbowOrthosisC';
  var bytelist;
  var username;
  ElbowOrthosisC({@required this.bytelist, @required this.username});
  @override
  _ElbowOrthosisCState createState() => _ElbowOrthosisCState();
}

class _ElbowOrthosisCState extends State<ElbowOrthosisC> {
  GlobalKey _containerKey = GlobalKey();

  final doc = pw.Document();

  bool loading = false;

  Future<Uint8List> _capturePng() async {
    RenderRepaintBoundary boundary =
        _containerKey.currentContext.findRenderObject();

    ui.Image image;
    bool catched = false;
    try {
      image = await boundary.toImage(pixelRatio: 3.0);
      catched = true;
    } catch (exception) {
      catched = false;
      Future.delayed(Duration(milliseconds: 1), () {
        _capturePng();
      });
    }

    if (catched) {
      var byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData.buffer.asUint8List();
    }
  }

  var doctorInfo;
  var patientInfo;
  void _printPngBytes() async {
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
        .doc(widget.username)
        .get();
    var pngBytes = await _capturePng();
    // var bs64 = base64Encode(pngBytes);
    if (widget.bytelist.length > 2) {
      widget.bytelist.removeLast();
    }
    await widget.bytelist.add(pngBytes);

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
                      pw.Text('AFO Form', textScaleFactor: 1),
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

    for (int i = 0; i < widget.bytelist.length; i++) {
      final image = PdfImage.file(
        doc.document,
        bytes: widget.bytelist[i],
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
        .child(FirebaseAuth.instance.currentUser.uid)
        .child(widget.username)
        .child("Elbow Orthosis.pdf");
    await ref.putFile(file).whenComplete(() => this.setState(() {
          loading = false;
        }));
    final url = await ref.getDownloadURL();
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc("${FirebaseAuth.instance.currentUser.uid}")
          .collection("username")
          .doc(widget.username)
          .collection("formname")
          .doc("Elbow Orthosis")
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Elbow Orthosis"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .9,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Zoom(
                      initZoom: 0,
                      centerOnScale: true,
                      enableScroll: false,
                      width: 1000,
                      height: 1500,
                      doubleTapZoom: true,
                      zoomSensibility: 2,
                      backgroundColor: Colors.white,
                      child: RepaintBoundary(
                        key: _containerKey,
                        child: Column(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                child: Stack(
                                    fit: StackFit.expand,
                                    children: <Widget>[
                                      Image(
                                        image: AssetImage(
                                          "assets/images/elbowOrthosis.png",
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                      Textfield(
                                        top: 350,
                                        left: 200,
                                        height: 20,
                                        width: 100,
                                      ),
                                      Textfield(
                                        top: 480,
                                        left: 150,
                                        height: 20,
                                        width: 100,
                                      ),
                                      Textfield(
                                        top: 700,
                                        left: 100,
                                        height: 20,
                                        width: 100,
                                      ),
                                      Textfield(
                                        top: 920,
                                        left: 30,
                                        height: 20,
                                        width: 100,
                                      ),
                                      Textfield(
                                        top: 930,
                                        left: 300,
                                        height: 20,
                                        width: 100,
                                      ),
                                      Textfield(
                                        top: 1130,
                                        left: 280,
                                        height: 20,
                                        width: 100,
                                      ),
                                      Textfield(
                                        top: 850,
                                        left: 420,
                                        height: 20,
                                        width: 100,
                                      ),
                                      Textfield(
                                        top: 680,
                                        left: 500,
                                        height: 20,
                                        width: 100,
                                      ),
                                      Textfield(
                                        top: 520,
                                        left: 470,
                                        height: 20,
                                        width: 100,
                                      ),
                                      Textfield(
                                        top: 1350,
                                        left: 50,
                                        height: 20,
                                        width: 100,
                                      ),
                                      Textfield(
                                        top: 1350,
                                        left: 150,
                                        height: 20,
                                        width: 100,
                                      ),
                                      Textfield(
                                        top: 1350,
                                        left: 250,
                                        height: 20,
                                        width: 100,
                                      ),
                                      Textfield(
                                        top: 1350,
                                        left: 350,
                                        height: 20,
                                        width: 100,
                                      ),
                                      Textfield(
                                        top: 1230,
                                        left: 550,
                                        height: 20,
                                        width: 100,
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                            _printPngBytes();
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
  Textfield({
    @required this.top,
    @required this.left,
    @required this.height,
    @required this.width,
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
          decoration: InputDecoration(isDense: true),
          style: TextStyle(
              color: Colors.black,
              backgroundColor: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}