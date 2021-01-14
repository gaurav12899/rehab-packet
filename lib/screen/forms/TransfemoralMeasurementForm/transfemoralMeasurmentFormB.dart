import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdf/pdf.dart';
import 'package:project/main.dart';
import 'dart:ui' as ui;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class TransfemoralMeasurementB extends StatefulWidget {
  static const routeName = '/transfemoralMeasurementB';

  @override
  _TransfemoralMeasurementBState createState() =>
      _TransfemoralMeasurementBState();
}

class _TransfemoralMeasurementBState extends State<TransfemoralMeasurementB> {
  GlobalKey _containerKey = GlobalKey();

  var _socketMaterial;
  var _suspensionType;

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

  void _printPngBytes(dynamic args) async {
    var pngBytes = await _capturePng();
    // var bs64 = base64Encode(pngBytes);
    print(pngBytes);
    await args['bytelist'].add(pngBytes);

    print(args['bytelist'].length);
    for (int i = 0; i < args['bytelist'].length; i++) {
      final image = PdfImage.file(
        doc.document,
        bytes: args['bytelist'][i],
      );
      doc.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Center(
            child: pw.Image(image),
          ),
        ),
      );
    }

    this.setState(() {
      loading = true;
    });

    Directory directory = await getExternalStorageDirectory();
    String docpath = directory.path;
    final file = File('$docpath/${FirebaseAuth.instance.currentUser.uid}.pdf');
    // print(docpath);

    file.writeAsBytesSync(doc.save(), mode: FileMode.append, flush: false);

    final ref = FirebaseStorage.instance
        .ref()
        .child(args["username"])
        .child("Transfemoral.pdf");
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
          .doc("Transfemoral Measurement")
          .set({"form": url});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text("Form Submitted!!"),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
            label: "Okay",
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MyApp()));
            }),
      ));
    } on Exception catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text("Something went wrong!!"),
          action: SnackBarAction(
              label: "Okay",
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MyApp()));
              }),
        ),
      );
    }
    await Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => MyApp()));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    print("from c${args["username"]}");
    print("------------>>>>>>${args["bytelist"]}");
    if (args['bytelist'].length > 1) {
      args['bytelist'].removeLast();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Transfemoral Measurement Form"),
      ),
      body: SingleChildScrollView(
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
                    SocketMaterial(socketMaterial2: _socketMaterial),
                    Divider(),
                    SuspensionType(suspensionType2: _suspensionType),
                    Divider(),
                    Text("NOTE",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Container(
                      height: 100,
                      child: TextField(
                        maxLines: 3,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              // margin: EdgeInsets.only(top: 100),
              width: double.infinity,
              child: RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  _printPngBytes(args);
                },
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SuspensionType extends StatefulWidget {
  SuspensionType({
    Key key,
    @required suspensionType2,
  })  : _suspensionType = suspensionType2,
        super(key: key);

  var _suspensionType;

  @override
  _SuspensionTypeState createState() => _SuspensionTypeState();
}

class _SuspensionTypeState extends State<SuspensionType> {
  @override
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
                        groupValue: widget._suspensionType,
                        onChanged: (val) {
                          setState(() {
                            widget._suspensionType = val;
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
                        groupValue: widget._suspensionType,
                        onChanged: (val) {
                          setState(() {
                            widget._suspensionType = val;
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
                        groupValue: widget._suspensionType,
                        onChanged: (val) {
                          setState(() {
                            widget._suspensionType = val;
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
                        groupValue: widget._suspensionType,
                        onChanged: (val) {
                          setState(() {
                            widget._suspensionType = val;
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
            Container(
              width: 200,
              child: TextField(
                decoration: InputDecoration(hintText: "Others"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SocketMaterial extends StatefulWidget {
  SocketMaterial({
    Key key,
    @required socketMaterial2,
  })  : _socketMaterial = socketMaterial2,
        super(key: key);

  var _socketMaterial;

  @override
  _SocketMaterialState createState() => _SocketMaterialState();
}

class _SocketMaterialState extends State<SocketMaterial> {
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
                        groupValue: widget._socketMaterial,
                        onChanged: (val) {
                          setState(() {
                            widget._socketMaterial = val;
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
                            groupValue: widget._socketMaterial,
                            onChanged: (val) {
                              setState(() {
                                widget._socketMaterial = val;
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
                Container(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(hintText: "Others"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
