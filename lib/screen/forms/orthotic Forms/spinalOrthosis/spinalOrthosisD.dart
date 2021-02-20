import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;
import 'package:project/screen/forms/orthotic%20Forms/spinalOrthosis/spinalOrthosisE.dart';

import 'package:zoom_widget/zoom_widget.dart';

class SpinalOrthosisD extends StatefulWidget {
  static const routeName = 'spinalOrthosisD';
  var bytelist;
  var username;
  SpinalOrthosisD({@required this.bytelist, @required this.username});
  @override
  _SpinalOrthosisDState createState() => _SpinalOrthosisDState();
}

class _SpinalOrthosisDState extends State<SpinalOrthosisD> {
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

    if (widget.bytelist.length > 3) {
      widget.bytelist.removeLast();
    }
    await widget.bytelist.add(pngBytes);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => SpinalOrthosisE(
            bytelist: widget.bytelist, username: widget.username)));

    // print(bs64);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spinal Orthosis"),
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
                        width: 1000,
                        height: 1500,
                        backgroundColor: Colors.orange,
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
                                            "assets/images/spinalOrthosisB.png",
                                          ),
                                          fit: BoxFit.fill,
                                        ),

                                        Textfield(
                                          top: 440,
                                          left: 260,
                                          height: 100,
                                          width: 120,
                                        ),
                                        Textfield(
                                          top: 720,
                                          left: 260,
                                          height: 100,
                                          width: 120,
                                        ),
                                        Textfield(
                                          top: 980,
                                          left: 260,
                                          height: 100,
                                          width: 120,
                                        ),
                                        Textfield(
                                          top: 1340,
                                          left: 260,
                                          height: 100,
                                          width: 120,
                                        ),

                                        Textfield(
                                          top: 440,
                                          left: 650,
                                          height: 100,
                                          width: 120,
                                        ),
                                        Textfield(
                                          top: 720,
                                          left: 650,
                                          height: 100,
                                          width: 120,
                                        ),
                                        Textfield(
                                          top: 980,
                                          left: 650,
                                          height: 100,
                                          width: 120,
                                        ),
                                        Textfield(
                                          top: 1340,
                                          left: 650,
                                          height: 100,
                                          width: 120,
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
