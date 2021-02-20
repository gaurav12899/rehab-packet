import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;
import 'package:project/screen/forms/prostheticForms/belowKneeProsthesis/belowKneeProsthesisD.dart';
import 'package:zoom_widget/zoom_widget.dart';

class BelowKneeProsthesisC extends StatefulWidget {
  static const routeName = '/belowKneeProsC';
  var bytelist;
  var username;
  BelowKneeProsthesisC({@required this.bytelist, @required this.username});

  @override
  _BelowKneeProsthesisCState createState() => _BelowKneeProsthesisCState();
}

class _BelowKneeProsthesisCState extends State<BelowKneeProsthesisC> {
  final doc = pw.Document();

  bool loading = false;
  GlobalKey _containerKey = GlobalKey();
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

  void _printPngBytes() async {
    var pngBytes = await _capturePng();
    if (widget.bytelist.length > 2) {
      widget.bytelist.removeLast();
    }
    await widget.bytelist.add(pngBytes);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => BelowKneeProsthesisD(
            bytelist: widget.bytelist, username: widget.username)));

    // print(bs64);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Below Knee Prosthesis"),
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
                      child: Zoom(
                        // zoomSensibility: 2.0,
                        centerOnScale: true,
                        enableScroll: false,
                        width: 1000,
                        height: 1500,
                        doubleTapZoom: true,
                        zoomSensibility: 2,
                        initZoom: 0,
                        backgroundColor: Colors.white,
                        onPositionUpdate: (Offset position) {
                          print(position);
                        },
                        onScaleUpdate: (double scale, double zoom) {
                          print("$scale  $zoom");
                        },
                        child: RepaintBoundary(
                          key: _containerKey,
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
                                            "assets/images/belowKnee1.png",
                                          ),
                                          fit: BoxFit.fill,
                                        ),

                                        Textfield(
                                            top: 110,
                                            left: 450,
                                            height: 90,
                                            width: 80,
                                            label: "test"),
                                        Textfield(
                                            top: 340,
                                            left: 450,
                                            height: 20,
                                            width: 100,
                                            label: "b"),
                                        Textfield(
                                            top: 570,
                                            left: 450,
                                            height: 20,
                                            width: 100,
                                            label: "c"),

                                        Textfield(
                                            top: 740,
                                            left: 450,
                                            height: 20,
                                            width: 100,
                                            label: "d"),

                                        Textfield(
                                            top: 950,
                                            left: 450,
                                            height: 20,
                                            width: 100,
                                            label: "e"),
                                        Textfield(
                                            top: 250,
                                            left: 350,
                                            height: 20,
                                            width: 100,
                                            label: "f"),
                                        Textfield(
                                            top: 450,
                                            left: 350,
                                            height: 20,
                                            width: 100,
                                            label: "g"),
                                        Textfield(
                                            top: 650,
                                            left: 350,
                                            height: 20,
                                            width: 100,
                                            label: "h"),

                                        Textfield(
                                            top: 850,
                                            left: 350,
                                            height: 20,
                                            width: 100,
                                            label: "i"),
                                        Textfield(
                                            top: 1050,
                                            left: 350,
                                            height: 20,
                                            width: 100,
                                            label: "j"),
                                        Textfield(
                                            top: 1310,
                                            left: 500,
                                            height: 20,
                                            width: 100,
                                            label: "j"),
                                        Textfield(
                                            top: 1310,
                                            left: 700,
                                            height: 20,
                                            width: 100,
                                            label: "j"),
                                        Textfield(
                                            top: 110,
                                            left: 850,
                                            height: 20,
                                            width: 100,
                                            label: "j"),
                                        Textfield(
                                            top: 220,
                                            left: 850,
                                            height: 20,
                                            width: 100,
                                            label: "j"),
                                        Textfield(
                                            top: 330,
                                            left: 850,
                                            height: 20,
                                            width: 100,
                                            label: "j"),
                                        Textfield(
                                            top: 450,
                                            left: 850,
                                            height: 20,
                                            width: 100,
                                            label: "j"),
                                        Textfield(
                                            top: 560,
                                            left: 850,
                                            height: 20,
                                            width: 100,
                                            label: "j"),
                                        Textfield(
                                            top: 680,
                                            left: 850,
                                            height: 20,
                                            width: 100,
                                            label: "j"),
                                        Textfield(
                                            top: 780,
                                            left: 850,
                                            height: 20,
                                            width: 100,
                                            label: "j"),
                                        Textfield(
                                            top: 900,
                                            left: 850,
                                            height: 20,
                                            width: 100,
                                            label: "j"),
                                        Textfield(
                                            top: 1010,
                                            left: 850,
                                            height: 20,
                                            width: 100,
                                            label: "j"),
                                        Textfield(
                                            top: 1110,
                                            left: 850,
                                            height: 20,
                                            width: 100,
                                            label: "j"),
                                        Textfield(
                                            top: 1230,
                                            left: 850,
                                            height: 20,
                                            width: 100,
                                            label: "j"),
                                        Textfield(
                                            top: 1340,
                                            left: 850,
                                            height: 20,
                                            width: 100,
                                            label: "j"),
                                        Textfield(
                                            top: 1450,
                                            left: 850,
                                            height: 20,
                                            width: 100,
                                            label: "j"),
                                        Textfield(
                                            top: 600,
                                            left: 130,
                                            height: 20,
                                            width: 140,
                                            label: "j"),
                                        Textfield(
                                            top: 890,
                                            left: 130,
                                            height: 20,
                                            width: 140,
                                            label: "j"),
                                        Textfield(
                                            top: 1310,
                                            left: 250,
                                            height: 20,
                                            width: 100,
                                            label: "j"),
                                        Textfield(
                                            top: 1420,
                                            left: 250,
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _printPngBytes();
        },
        label: Text('Next'),
        icon: Icon(Icons.arrow_forward),
        backgroundColor: Colors.blue,
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
        width: 30,
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