import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;
import 'package:project/screen/forms/orthotic%20Forms/spinalOrthosis/spinalOrthosisD.dart';
import 'package:zoom_widget/zoom_widget.dart';

class SpinalOrthosisC extends StatefulWidget {
  static const routeName = 'spinalOrthosisC';
  var bytelist;
  var username;
  SpinalOrthosisC({@required this.bytelist, @required this.username});

  @override
  _SpinalOrthosisCState createState() => _SpinalOrthosisCState();
}

class _SpinalOrthosisCState extends State<SpinalOrthosisC> {
  final doc = pw.Document();

  bool loading = false;
  GlobalKey _containerKey = GlobalKey();
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
    var pngBytes = await _capturePng();
    if (widget.bytelist.length > 2) {
      widget.bytelist.removeLast();
    }
    await widget.bytelist.add(pngBytes);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => SpinalOrthosisD(
            bytelist: widget.bytelist, username: widget.username)));
    // print(bs64);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spinal Prosthesis"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: Zoom(
                        initZoom: 0,
                        centerOnScale: true,
                        enableScroll: false,
                        width: 1000,
                        height: 1500,
                        doubleTapZoom: true,
                        zoomSensibility: 2,
                        backgroundColor: Colors.orange,
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
                                            "assets/images/spinalOrthosisA.png",
                                          ),
                                          fit: BoxFit.fill,
                                        ),

                                        Textfield(
                                          top: 480, //2/5,2.04
                                          left: 40,
                                          height: 20,
                                          width: 100,
                                        ),
                                        Textfield(
                                          top: 480, //2/5,2.04
                                          left: 150,
                                          height: 20,
                                          width: 100,
                                        ),
                                        Textfield(
                                          top: 610, //2/5,2.04
                                          left: 40,
                                          height: 20,
                                          width: 100,
                                        ),
                                        Textfield(
                                          top: 610, //2/5,2.04
                                          left: 150,
                                          height: 20,
                                          width: 100,
                                        ),
                                        Textfield(
                                          top: 740, //2/5,2.04
                                          left: 40,
                                          height: 20,
                                          width: 100,
                                        ),
                                        Textfield(
                                          top: 740, //2/5,2.04
                                          left: 150,
                                          height: 20,
                                          width: 100,
                                        ),
                                        Textfield(
                                          top: 890, //2/5,2.04
                                          left: 40,
                                          height: 20,
                                          width: 100,
                                        ),
                                        Textfield(
                                          top: 890, //2/5,2.04
                                          left: 150,
                                          height: 20,
                                          width: 100,
                                        ),
                                        Textfield(
                                          top: 1020, //2/5,2.04
                                          left: 40,
                                          height: 20,
                                          width: 100,
                                        ),
                                        Textfield(
                                          top: 1020, //2/5,2.04
                                          left: 150,
                                          height: 20,
                                          width: 100,
                                        ),
                                        Textfield(
                                          top: 950, //2/5,2.04
                                          left: 290,
                                          height: 20,
                                          width: 100,
                                        ),
                                        Textfield(
                                          top: 880, //2/5,2.04
                                          left: 630,
                                          height: 20,
                                          width: 100,
                                        ),
                                        Textfield(
                                          top: 780, //2/5,2.04
                                          left: 730,
                                          height: 20,
                                          width: 100,
                                        ),
                                        Textfield(
                                          top: 760, //2/5,2.04
                                          left: 850,
                                          height: 20,
                                          width: 100,
                                        ),
                                        Textfield(
                                          top: 580, //2/5,2.04
                                          left: 800,
                                          height: 20,
                                          width: 100,
                                        ),
                                        Textfield(
                                          top: 500, //2/5,2.04
                                          left: 870,
                                          height: 20,
                                          width: 100,
                                        ),
                                        Textfield(
                                          top: 1030, //2/5,2.04
                                          left: 870,
                                          height: 20,
                                          width: 100,
                                        ),
                                        Textfield(
                                          top: 1120, //2/5,2.04
                                          left: 700,
                                          height: 20,
                                          width: 100,
                                        ),
                                        Textfield(
                                          top: 1210, //2/5,2.04
                                          left: 780,
                                          height: 20,
                                          width: 100,
                                        ),
                                        Textfield(
                                          top: 1250, //2/5,2.04
                                          left: 530,
                                          height: 20,
                                          width: 100,
                                        ),
                                        Textfield(
                                          top: 1350, //2/5,2.04
                                          left: 870,
                                          height: 20,
                                          width: 100,
                                        ),
                                        Textfield(
                                          top: 1220, //2/5,2.04
                                          left: 40,
                                          height: 20,
                                          width: 100,
                                        ),

                                        Textfield(
                                          top: 1220, //2/5,2.04
                                          left: 150,
                                          height: 20,
                                          width: 100,
                                        ),

                                        Textfield(
                                          top: 1350, //2/5,2.04
                                          left: 40,
                                          height: 20,
                                          width: 100,
                                        ),
                                        Textfield(
                                          top: 1350, //2/5,2.04
                                          left: 150,
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
