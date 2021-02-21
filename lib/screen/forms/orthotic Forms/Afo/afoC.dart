import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:image_pixels/image_pixels.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pdf/pdf.dart';
import 'package:project/main.dart';
import 'package:project/screen/homeScreen/new-or-old-patient.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'dart:ui' as ui;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class AfoC extends StatefulWidget {
  static const routeName = '/afoc';
  var bytelist;
  var username;
  AfoC({@required this.bytelist, @required this.username});

  @override
  _AfoCState createState() => _AfoCState();
}

class _AfoCState extends State<AfoC> {
  var doctorInfo;
  var patientInfo;

  GlobalKey _containerKey = GlobalKey();

  final doc = pw.Document();

  bool loading = false;

  Future<Uint8List> _capturePng() async {
    RenderRepaintBoundary boundary =
        _containerKey.currentContext.findRenderObject();

    ui.Image image;
    bool catched = false;
    try {
      image = await boundary.toImage(pixelRatio: 1.0);
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
        .doc("${widget.username}")
        .get();

    var pngBytes = await _capturePng();
    if (widget.bytelist.length > 2) {
      widget.bytelist.removeLast();
    }

    await widget.bytelist.add(pngBytes);
    final fontbold = await rootBundle.load("assets/fonts/Helvetica-Bold.ttf");
    final font = await rootBundle.load("assets/fonts/Helvetica.ttf");
    final fontOblique =
        await rootBundle.load("assets/fonts/Helvetica-Oblique.ttf");

    final ttfBold = pw.Font.ttf(fontbold);
    final ttf = pw.Font.ttf(font);
    final ttfOblique = pw.Font.ttf(fontOblique);

    final pw.ThemeData theme =
        pw.ThemeData.withFont(bold: ttfBold, base: ttf, italic: ttfOblique);

    final ByteData bytes = await rootBundle.load('assets/images/REHAB.jpg');
    final Uint8List list = bytes.buffer.asUint8List();
    final logo = PdfImage.file(doc.document, bytes: list);

    doc.addPage(pw.MultiPage(
        theme: theme,
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
          theme: theme,
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
        .child("AFO.pdf");
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
          .doc("AFO")
          .set({"form": url});
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => NewOrOldPatient(
                    result: true,
                  )),
          (Route<dynamic> route) => false);
    } on Exception catch (_) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => NewOrOldPatient(
                    result: false,
                  )),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AFO"),
      ),
      body: Container(
        color: HexColor('#e4f0f4'),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .9,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: Zoom(
                      initZoom: 0,
                      // zoomSensibility: 2.0,
                      centerOnScale: true,
                      enableScroll: true,
                      width: 1000,
                      height: 1500,
                      doubleTapZoom: true,
                      zoomSensibility: 2,

                      backgroundColor: HexColor('e4f0f4'),

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
                                          "assets/images/form1.png",
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                      Positioned(
                                        top: 250, //2/5,2.04
                                        left: 400,
                                        height: 20,
                                        width: 100,
                                        child: Container(
                                          // color: Colors.white,
                                          width: 20,
                                          child: TextField(
                                            decoration:
                                                InputDecoration(isDense: true),
                                            style: TextStyle(
                                                color: Colors.black,
                                                backgroundColor: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 550,
                                        left: 400,
                                        height: 20,
                                        width: 100,
                                        child: Container(
                                          // color: Colors.white,
                                          width: 20,
                                          child: TextField(
                                            decoration:
                                                InputDecoration(isDense: true),
                                            style: TextStyle(
                                                color: Colors.black,
                                                backgroundColor: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 660,
                                        left: 400,
                                        height: 20,
                                        width: 80,
                                        child: Container(
                                          // color: Colors.white,
                                          width: 20,
                                          child: TextField(
                                            decoration:
                                                InputDecoration(isDense: true),
                                            style: TextStyle(
                                                color: Colors.black,
                                                backgroundColor: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 700,
                                        left: 680,
                                        height: 20,
                                        width: 100,
                                        child: Container(
                                          // color: Colors.white,
                                          width: 20,
                                          child: TextField(
                                            decoration:
                                                InputDecoration(isDense: true),
                                            style: TextStyle(
                                                color: Colors.black,
                                                backgroundColor: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 660,
                                        left: 500,
                                        height: 20,
                                        width: 100,
                                        child: Container(
                                          // color: Colors.white,

                                          // width: 20,
                                          child: TextField(
                                            decoration:
                                                InputDecoration(isDense: true),
                                            style: TextStyle(
                                                color: Colors.black,
                                                backgroundColor: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 700,
                                        left: 26,
                                        height: 20,
                                        width: 100,
                                        child: Container(
                                          // color: Colors.white,
                                          width: 20,
                                          child: TextField(
                                            decoration:
                                                InputDecoration(isDense: true),
                                            style: TextStyle(
                                                color: Colors.black,
                                                backgroundColor: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),

                                      Positioned(
                                        top: 1410,
                                        left: 26,
                                        height: 20,
                                        width: 100,
                                        child: Container(
                                          // color: Colors.white,
                                          width: 20,
                                          child: TextField(
                                            decoration:
                                                InputDecoration(isDense: true),
                                            style: TextStyle(
                                                color: Colors.black,
                                                backgroundColor: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 800,
                                        left: 400,
                                        height: 20,
                                        width: 100,
                                        child: Container(
                                          // color: Colors.white,
                                          width: 20,
                                          child: TextField(
                                            decoration:
                                                InputDecoration(isDense: true),
                                            style: TextStyle(
                                                color: Colors.black,
                                                backgroundColor: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),

                                      Positioned(
                                        top: 890,
                                        left: 400,
                                        height: 20,
                                        width: 100,
                                        child: Container(
                                          // color: Colors.white,
                                          width: 20,
                                          child: TextField(
                                            decoration:
                                                InputDecoration(isDense: true),
                                            style: TextStyle(
                                                color: Colors.black,
                                                backgroundColor: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 780,
                                        left: 620,
                                        height: 20,
                                        width: 100,
                                        child: Container(
                                          // color: Colors.white,
                                          width: 20,
                                          child: TextField(
                                            decoration:
                                                InputDecoration(isDense: true),
                                            style: TextStyle(
                                                color: Colors.black,
                                                backgroundColor: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 880,
                                        left: 570,
                                        height: 20,
                                        width: 100,
                                        child: Container(
                                          // color: Colors.white,
                                          width: 20,
                                          child: TextField(
                                            decoration:
                                                InputDecoration(isDense: true),
                                            style: TextStyle(
                                                color: Colors.black,
                                                backgroundColor: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 970,
                                        left: 520,
                                        height: 20,
                                        width: 100,
                                        child: Container(
                                          // color: Colors.white,
                                          width: 20,
                                          child: TextField(
                                            decoration:
                                                InputDecoration(isDense: true),
                                            style: TextStyle(
                                                color: Colors.black,
                                                backgroundColor: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 1050,
                                        left: 460,
                                        height: 20,
                                        width: 100,
                                        child: Container(
                                          // color: Colors.white,
                                          width: 20,
                                          child: TextField(
                                            decoration:
                                                InputDecoration(isDense: true),
                                            style: TextStyle(
                                                color: Colors.black,
                                                backgroundColor: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 1210,
                                        left: 368,
                                        height: 20,
                                        width: 100,
                                        child: Container(
                                          // color: Colors.white,
                                          width: 20,
                                          child: TextField(
                                            decoration:
                                                InputDecoration(isDense: true),
                                            style: TextStyle(
                                                color: Colors.black,
                                                backgroundColor: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 1170,
                                        left: 185,
                                        height: 20,
                                        width: 100,
                                        child: Container(
                                          // color: Colors.white,
                                          width: 20,
                                          child: TextField(
                                            decoration:
                                                InputDecoration(isDense: true),
                                            style: TextStyle(
                                                color: Colors.black,
                                                backgroundColor: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 1330,
                                        left: 85,
                                        height: 20,
                                        width: 100,
                                        child: Container(
                                          // color: Colors.white,
                                          width: 20,
                                          child: TextField(
                                            decoration:
                                                InputDecoration(isDense: true),
                                            style: TextStyle(
                                                color: Colors.black,
                                                backgroundColor: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 1410,
                                        left: 170,
                                        height: 20,
                                        width: 100,
                                        child: Container(
                                          // color: Colors.white,
                                          width: 20,
                                          child: TextField(
                                            decoration:
                                                InputDecoration(isDense: true),
                                            style: TextStyle(
                                                color: Colors.black,
                                                backgroundColor: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 1450,
                                        left: 550,
                                        height: 20,
                                        width: 100,
                                        child: Container(
                                          // color: Colors.white,
                                          width: 20,
                                          child: TextField(
                                            decoration:
                                                InputDecoration(isDense: true),
                                            style: TextStyle(
                                                color: Colors.black,
                                                backgroundColor: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 1450,
                                        left: 880,
                                        height: 20,
                                        width: 100,
                                        child: Container(
                                          // color: Colors.white,
                                          width: 20,
                                          child: TextField(
                                            decoration:
                                                InputDecoration(isDense: true),
                                            style: TextStyle(
                                                color: Colors.black,
                                                backgroundColor: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 1330,
                                        left: 900,
                                        height: 20,
                                        width: 100,
                                        child: Container(
                                          // color: Colors.white,
                                          width: 20,
                                          child: TextField(
                                            decoration:
                                                InputDecoration(isDense: true),
                                            style: TextStyle(
                                                color: Colors.black,
                                                backgroundColor: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),

                                      Positioned(
                                        top: 970,
                                        left: 115,
                                        height: 20,
                                        width: 100,
                                        child: Container(
                                          // color: Colors.white,
                                          width: 20,
                                          child: TextField(
                                            decoration:
                                                InputDecoration(isDense: true),
                                            style: TextStyle(
                                                color: Colors.black,
                                                backgroundColor: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ), // Container(color: Colors.red),
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
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      child: loading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
