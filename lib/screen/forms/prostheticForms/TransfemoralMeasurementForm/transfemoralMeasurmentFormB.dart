import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'dart:ui' as ui;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:project/main.dart';
import 'package:project/screen/homeScreen/new-or-old-patient.dart';

class TransfemoralMeasurementB extends StatefulWidget {
  static const routeName = '/transfemoralMeasurementB';

  var bytelist;
  var username;

  TransfemoralMeasurementB({@required this.bytelist, @required this.username});
  @override
  _TransfemoralMeasurementBState createState() =>
      _TransfemoralMeasurementBState();
}

class _TransfemoralMeasurementBState extends State<TransfemoralMeasurementB> {
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
    if (widget.bytelist.length > 1) {
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
                      pw.Text('Transfemoral Form', textScaleFactor: 1),
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
                        pw.Text('Transfemoral Form', textScaleFactor: 1),
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
    // print(docpath);

    file.writeAsBytesSync(doc.save(), flush: true);

    final ref = FirebaseStorage.instance
        .ref()
        .child(FirebaseAuth.instance.currentUser.uid)
        .child(widget.username)
        .child("Transfemoral Measurement.pdf");
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
          .doc("Transfemoral Measurement")
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
        title: Text("Transfemoral Measurement Form"),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RepaintBoundary(
                key: _containerKey,
                child: Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(border: Border.all(width: 2)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SocketMaterial(),
                      Divider(),
                      SuspensionType(),
                      Divider(),
                      Text("NOTE",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Container(
                        height: 100,
                        child: TextField(
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                          maxLines: 3,
                        ),
                      )
                    ],
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
    );
  }
}

class SuspensionType extends StatefulWidget {
  @override
  _SuspensionTypeState createState() => _SuspensionTypeState();
}

class _SuspensionTypeState extends State<SuspensionType> {
  @override
  var _suspensionType;

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "\nSuspension\nType:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                        activeColor: Colors.green,
                        value: 0,
                        groupValue: _suspensionType,
                        onChanged: (val) {
                          setState(() {
                            _suspensionType = val;
                          });
                        }),
                    Text(
                      "TES\nBelt",
                      // textAlign: TextAlign.justify,
                    )
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        activeColor: Colors.green,
                        value: 1,
                        groupValue: _suspensionType,
                        onChanged: (val) {
                          setState(() {
                            _suspensionType = val;
                          });
                        }),
                    Text(
                      "Locking\nLiner",
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Radio(
                        activeColor: Colors.green,
                        value: 2,
                        groupValue: _suspensionType,
                        onChanged: (val) {
                          setState(() {
                            _suspensionType = val;
                          });
                        }),
                    Text(
                      "Suction\nValve",
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        activeColor: Colors.green,
                        value: 3,
                        groupValue: _suspensionType,
                        onChanged: (val) {
                          setState(() {
                            _suspensionType = val;
                          });
                        }),
                    Text(
                      "KISS\n Lanyard",
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio(
                        activeColor: Colors.green,
                        value: 4,
                        groupValue: _suspensionType,
                        onChanged: (val) {
                          setState(() {
                            _suspensionType = val;
                          });
                        }),
                    if (_suspensionType != 4)
                      Text(
                        "Others",
                        textAlign: TextAlign.justify,
                      )
                  ],
                ),
                if (_suspensionType == 4)
                  Container(
                    width: 100,
                    child: TextField(
                      decoration: InputDecoration(hintText: "Others"),
                    ),
                  ),
              ],
            )
          ],
        ),
      ],
    );
  }
}

class SocketMaterial extends StatefulWidget {
  @override
  _SocketMaterialState createState() => _SocketMaterialState();
}

class _SocketMaterialState extends State<SocketMaterial> {
  var _socketMaterial;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "\nSocket Material",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                        activeColor: Colors.green,
                        value: 0,
                        groupValue: _socketMaterial,
                        onChanged: (val) {
                          setState(() {
                            _socketMaterial = val;
                          });
                        }),
                    Text(
                      "Lamination",
                      // textAlign: TextAlign.justify,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                            activeColor: Colors.green,
                            value: 2,
                            groupValue: _socketMaterial,
                            onChanged: (val) {
                              setState(() {
                                _socketMaterial = val;
                              });
                            }),
                        Text(
                          "PP Socket",
                          textAlign: TextAlign.justify,
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio(
                            activeColor: Colors.green,
                            value: 4,
                            groupValue: _socketMaterial,
                            onChanged: (val) {
                              setState(() {
                                _socketMaterial = val;
                              });
                            }),
                        if (_socketMaterial != 4)
                          Text(
                            "Others",
                            textAlign: TextAlign.justify,
                          )
                      ],
                    ),
                    if (_socketMaterial == 4)
                      Container(
                        width: 100,
                        child: TextField(
                          decoration: InputDecoration(hintText: "Others"),
                        ),
                      ),
                  ],
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
