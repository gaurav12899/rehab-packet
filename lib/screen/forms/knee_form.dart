import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:image_pixels/image_pixels.dart';
import 'package:pdf/pdf.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'dart:ui' as ui;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class KneeForm extends StatefulWidget {
  static const routeName = '/knee-form';
  @override
  _KneeFormState createState() => _KneeFormState();
}

class _KneeFormState extends State<KneeForm> {
  double posx = 00.0;
  double posy = 00.0;
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

    var image = await boundary.toImage();
    var byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData.buffer.asUint8List();
  }

  void _printPngBytes(List args) async {
    var pngBytes = await _capturePng();
    // var bs64 = base64Encode(pngBytes);
    print(pngBytes);
    args.add(pngBytes);

    print(args);
    for (int i = 0; i < args.length; i++) {
      final image = PdfImage.file(
        doc.document,
        bytes: args[i],
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
    print(docpath);

    file.writeAsBytesSync(doc.save(), mode: FileMode.append, flush: false);

    await FirebaseStorage.instance
        .ref("Img_${DateTime.now().day}.pdf")
        .putFile(file)
        .whenComplete(() => this.setState(() {
              loading = false;
            }));
    // print(bs64);
  }

  void onTapDown(BuildContext context, TapDownDetails details) {
    print('${details.globalPosition}');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    setState(() {
      posx = localOffset.dx;
      posy = localOffset.dy;
    });
  }

  @override
  Widget build(BuildContext context) {
    List args = ModalRoute.of(context).settings.arguments;
    print(args);

    return Scaffold(
      appBar: AppBar(
        title: Text("Test1"),
      ),
      body: RepaintBoundary(
        key: _containerKey,
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Zoom(
                  initZoom: 0,
                  // zoomSensibility: 2.0,
                  centerOnScale: true,
                  width: 1200,
                  height: 1200,
                  backgroundColor: Colors.white,
                  onPositionUpdate: (Offset position) {
                    print(position);
                  },
                  onScaleUpdate: (double scale, double zoom) {
                    print("$scale  $zoom");
                  },
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          "Hello world",
                          style: TextStyle(fontSize: 40, color: Colors.red),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTapDown: (TapDownDetails details) =>
                              onTapDown(context, details),
                          child: Stack(fit: StackFit.expand, children: <Widget>[
                            // Hack to expand stack to fill all the space. There must be a better
                            // way to do it.
                            Image(
                              image: AssetImage(
                                "assets/images/form1.png",
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
                                  decoration: InputDecoration(labelText: "a"),
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
                                  decoration: InputDecoration(labelText: "b"),
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
                                  decoration: InputDecoration(labelText: "c"),
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
                                  decoration: InputDecoration(labelText: "d"),
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
                                  decoration: InputDecoration(labelText: "e"),
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
                                  decoration: InputDecoration(labelText: "f"),
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
                                  decoration: InputDecoration(labelText: "g"),
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
                                  decoration: InputDecoration(labelText: "h"),
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
                                  decoration: InputDecoration(labelText: "i"),
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
                                  decoration: InputDecoration(labelText: "j"),
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
                                  decoration: InputDecoration(labelText: "j"),
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
    );
  }
}
