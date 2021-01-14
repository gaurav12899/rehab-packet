import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
// import 'package:image_pixels/image_pixels.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;
import 'package:project/screen/forms/belowKneeProsthesis/belowKneeProsthesisE.dart';
import 'package:zoom_widget/zoom_widget.dart';

class BelowKneeProsthesisD extends StatefulWidget {
  static const routeName = '/belowKneeProsthesisD';

  @override
  _BelowKneeProsthesisDState createState() => _BelowKneeProsthesisDState();
}

class _BelowKneeProsthesisDState extends State<BelowKneeProsthesisD> {
  final doc = pw.Document();

  bool loading = false;
  GlobalKey _containerKey = GlobalKey();
  Future<Uint8List> _capturePng() async {
    RenderRepaintBoundary boundary =
        _containerKey.currentContext.findRenderObject();

    if (boundary.debugNeedsPaint) {
      print("Waiting for boundary to be painted.");
      await Future.delayed(const Duration(milliseconds: 20));
      return _capturePng();
    }

    var image = await boundary.toImage();
    var byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return byteData.buffer.asUint8List();
  }

  void _printPngBytes(dynamic args) async {
    var pngBytes = await _capturePng();
    await args['bytelist'].add(pngBytes);
    Navigator.of(context).pushNamed(BelowKneeProsthesisE.routeName, arguments: {
      "bytelist": args["bytelist"],
      "username": args["username"]
    });

    // print(bs64);
  }

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    if (args['bytelist'].length > 3) {
      args['bytelist'].removeLast();
    }
    // args.values.toList()
    return Scaffold(
      appBar: AppBar(
        title: Text("Below Knee Prosthesis"),
        actions: [
          IconButton(
              icon: Icon(Icons.navigate_next_rounded),
              onPressed: () {
                _printPngBytes(args);
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .8,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: RepaintBoundary(
                        key: _containerKey,
                        child: Zoom(
                          initZoom: 0,
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
                              Expanded(
                                child: GestureDetector(
                                  // onTapDown: (TapDownDetails details) =>
                                  //     onTapDown(context, details),
                                  child: Stack(
                                      fit: StackFit.expand,
                                      children: <Widget>[
                                        // Hack to expand stack to fill all the space. There must be a better
                                        // way to do it.
                                        Image(
                                          image: AssetImage(
                                            "assets/images/belowKnee2.png",
                                          ),
                                          fit: BoxFit.fill,
                                        ),

                                        Textfield(
                                            top: 80,
                                            left: 90,
                                            height: 90,
                                            width: 80,
                                            label: "test"),
                                        Textfield(
                                            top: 420,
                                            left: 470,
                                            height: 20,
                                            width: 100,
                                            label: "b"),
                                        Textfield(
                                            top: 510,
                                            left: 470,
                                            height: 20,
                                            width: 100,
                                            label: "c"),

                                        Textfield(
                                            top: 510,
                                            left: 600,
                                            height: 20,
                                            width: 100,
                                            label: "d"),

                                        Textfield(
                                            top: 610,
                                            left: 470,
                                            height: 20,
                                            width: 100,
                                            label: "e"),
                                        Textfield(
                                            top: 680,
                                            left: 470,
                                            height: 20,
                                            width: 100,
                                            label: "f"),
                                        Textfield(
                                            top: 680,
                                            left: 680,
                                            height: 20,
                                            width: 100,
                                            label: "g"),
                                        Textfield(
                                            top: 610,
                                            left: 750,
                                            height: 20,
                                            width: 100,
                                            label: "h"),

                                        Textfield(
                                            top: 540,
                                            left: 820,
                                            height: 20,
                                            width: 100,
                                            label: "i"),
                                        Textfield(
                                            top: 750,
                                            left: 620,
                                            height: 20,
                                            width: 100,
                                            label: "j"),
                                        Textfield(
                                            top: 820,
                                            left: 560,
                                            height: 20,
                                            width: 100,
                                            label: "j"),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
