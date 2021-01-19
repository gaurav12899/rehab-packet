import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:image_pixels/image_pixels.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdf/pdf.dart';
import 'package:project/main.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'dart:ui' as ui;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class ElbowOrthosisC extends StatefulWidget {
  static const routeName = '/elbowOrthosisC';
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

    if (boundary.debugNeedsPaint) {
      print("Waiting for boundary to be painted.");
      await Future.delayed(const Duration(milliseconds: 20));
      return _capturePng();
    }

    var image = await boundary.toImage(pixelRatio: 2);
    var byteData = await image.toByteData(format: ui.ImageByteFormat.png);
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
    // args.clear();

    final ref = FirebaseStorage.instance
        .ref()
        .child(args["username"])
        .child("ElbowOrthosis.pdf");
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
          .doc("ElbowOrthosis")
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
    // final size = MediaQuery.of(context).size;
    var args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    print("from c${args["username"]}");
    print("------------>>>>>>${args["bytelist"]}");
    if (args['bytelist'].length > 2) {
      args['bytelist'].removeLast();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Elbow Orthosis"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .8,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Zoom(
                      initZoom: 0,
                      centerOnScale: true,
                      width: 1200,
                      height: 1200,
                      backgroundColor: Colors.white,
                      child: RepaintBoundary(
                        key: _containerKey,
                        child: Column(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                // onTapDown: (TapDownDetails details) =>
                                //     onTapDown(context, details),
                                child: Stack(fit: StackFit.expand, children: <
                                    Widget>[
                                  // Hack to expand stack to fill all the space. There must be a better
                                  // way to do it.
                                  Image(
                                    image: AssetImage(
                                      "assets/images/elbowOrthosis.png",
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                  Positioned(
                                    top: 180,
                                    left: 470,
                                    height: 20,
                                    width: 100,
                                    child: Container(
                                      // color: Colors.white,
                                      width: 20,
                                      child: TextField(
                                        decoration:
                                            InputDecoration(labelText: "a"),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 420,
                                    left: 470,
                                    height: 20,
                                    width: 100,
                                    child: Container(
                                      // color: Colors.white,
                                      width: 20,
                                      child: TextField(
                                        decoration:
                                            InputDecoration(labelText: "b"),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 510,
                                    left: 470,
                                    height: 20,
                                    width: 100,
                                    child: Container(
                                      // color: Colors.white,
                                      width: 20,
                                      child: TextField(
                                        style: TextStyle(color: Colors.black),
                                        decoration:
                                            InputDecoration(labelText: "c"),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 510,
                                    left: 600,
                                    height: 20,
                                    width: 100,
                                    child: Container(
                                      // color: Colors.white,
                                      width: 20,
                                      child: TextField(
                                        decoration:
                                            InputDecoration(labelText: "d"),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 610,
                                    left: 470,
                                    height: 20,
                                    width: 100,
                                    child: Container(
                                      // color: Colors.white,
                                      width: 20,
                                      child: TextField(
                                        decoration:
                                            InputDecoration(labelText: "e"),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 680,
                                    left: 470,
                                    height: 20,
                                    width: 100,
                                    child: Container(
                                      // color: Colors.white,
                                      width: 20,
                                      child: TextField(
                                        decoration:
                                            InputDecoration(labelText: "f"),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: 680,
                                    left: 680,
                                    height: 20,
                                    width: 100,
                                    child: Container(
                                      // color: Colors.white,
                                      width: 20,
                                      child: TextField(
                                        decoration:
                                            InputDecoration(labelText: "g"),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 610,
                                    left: 750,
                                    height: 20,
                                    width: 100,
                                    child: Container(
                                      // color: Colors.white,
                                      width: 20,
                                      child: TextField(
                                        decoration:
                                            InputDecoration(labelText: "h"),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 540,
                                    left: 820,
                                    height: 20,
                                    width: 100,
                                    child: Container(
                                      // color: Colors.white,
                                      width: 20,
                                      child: TextField(
                                        decoration:
                                            InputDecoration(labelText: "i"),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 750,
                                    left: 620,
                                    height: 20,
                                    width: 100,
                                    child: Container(
                                      // color: Colors.white,
                                      width: 20,
                                      child: TextField(
                                        decoration:
                                            InputDecoration(labelText: "j"),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 820,
                                    left: 560,
                                    height: 20,
                                    width: 100,
                                    child: Container(
                                      // color: Colors.white,
                                      width: 20,
                                      child: TextField(
                                        decoration:
                                            InputDecoration(labelText: "j"),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  // Container(color: Colors.red),
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
                  width: double.infinity,
                  color: Colors.blue,
                  // height: 100,2
                  child: FlatButton(
                    child: loading
                        ? CircularProgressIndicator()
                        : Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                    onPressed: () {
                      // convertWidgetToImage();
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
