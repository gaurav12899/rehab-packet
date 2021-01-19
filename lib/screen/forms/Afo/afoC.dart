import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:image_pixels/image_pixels.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:project/main.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'dart:ui' as ui;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class AfoC extends StatefulWidget {
  static const routeName = '/afoc';

  @override
  _AfoCState createState() => _AfoCState();
}

class _AfoCState extends State<AfoC> {
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
      final ByteData bytes = await rootBundle.load('assets/images/REHAB.jpg');
      final Uint8List list = bytes.buffer.asUint8List();
      final x = PdfImage.file(doc.document, bytes: list);

      // doc.addPage(pw.Page(build: (pw.Context context)=>));

      doc.addPage(
        pw.MultiPage(
            margin: pw.EdgeInsets.all(10),
            build: (pw.Context context) => [
                  pw.Header(
                    level: 0,
                    child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: <pw.Widget>[
                          pw.Text('AFO Form', textScaleFactor: 1),
                          pw.Image(x, width: 60, height: 60)
                        ]),
                  ),
                  pw.Center(
                    child: pw.Image(
                      image,
                      height: 600,
                    ),
                  )
                ]),
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

    final ref =
        FirebaseStorage.instance.ref().child(args["username"]).child("AFO.pdf");
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
          .doc("AFO")
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

  // void onTapDown(BuildContext context, TapDownDetails details) {
  //   print('${details.globalPosition}');
  //   final RenderBox box = context.findRenderObject();
  //   final Offset localOffset = box.globalToLocal(details.globalPosition);
  //   setState(() {
  //     posx = localOffset.dx;
  //     posy = localOffset.dy;
  //   });
  // }

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
        title: Text("Test1"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .8,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: Zoom(
                      initZoom: 0,
                      // zoomSensibility: 2.0,
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
                                        top: 190,
                                        left: 470,
                                        height: 20,
                                        width: 100,
                                        child: Container(
                                          // color: Colors.white,
                                          width: 20,
                                          child: TextField(
                                            decoration:
                                                InputDecoration(hintText: "a"),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 50,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 430,
                                        left: 470,
                                        height: 20,
                                        width: 100,
                                        child: Container(
                                          // color: Colors.white,
                                          width: 20,
                                          child: TextField(
                                            decoration:
                                                InputDecoration(labelText: "b"),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 50,
                                                fontWeight: FontWeight.bold),
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
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 50,
                                                fontWeight: FontWeight.bold),
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
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 50,
                                                fontWeight: FontWeight.bold),
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
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 50,
                                                fontWeight: FontWeight.bold),
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
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 50,
                                                fontWeight: FontWeight.bold),
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
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 50,
                                                fontWeight: FontWeight.bold),
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
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 50,
                                                fontWeight: FontWeight.bold),
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
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 50,
                                                fontWeight: FontWeight.bold),
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
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 50,
                                                fontWeight: FontWeight.bold),
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
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 50,
                                                fontWeight: FontWeight.bold),
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
                  child: TextButton(
                    child: loading
                        ? CircularProgressIndicator()
                        : Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                    onPressed: () {
                      // convertWidgetToImage();
                      if (args['bytelist'].length > 2) {
                        args['bytelist'].removeLast();
                      }
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
