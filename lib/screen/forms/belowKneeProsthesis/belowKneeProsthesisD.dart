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

    if (args['bytelist'].length > 3) {
      args['bytelist'].removeLast();
    }
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
    print(args['bytelist'].length);
    // if (args['bytelist'].length > 3) {
    //   args['bytelist'].removeLast();
    // }

    // args.values.toList()
    return Scaffold(
      appBar: AppBar(
        title: Text("Below Knee Prosthesis"),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //     if (args['bytelist'].length > 3) {
        //       args['bytelist'].removeLast();
        //     }
        //   },
        // ),
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
                      child: Zoom(
                        initZoom: 0,
                        centerOnScale: true,
                        enableScroll: false,
                        width: 1000,
                        height: 1500,
                        doubleTapZoom: true,
                        zoomSensibility: 2,
                        backgroundColor: Colors.white,
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
                                            "assets/images/belowKnee2.png",
                                          ),
                                          fit: BoxFit.fill,
                                        ),

                                        Textfield(
                                          top: 350,
                                          left: 40,
                                          height: 20,
                                          width: 120,
                                        ),
                                        Textfield(
                                          top: 600,
                                          left: 40,
                                          height: 20,
                                          width: 100,
                                        ),
                                        Textfield(
                                          top: 950,
                                          left: 40,
                                          height: 20,
                                          width: 120,
                                        ),

                                        Textfield(
                                          top: 1220,
                                          left: 40,
                                          height: 20,
                                          width: 120,
                                        ),

                                        Textfield(
                                          top: 250,
                                          left: 220,
                                          height: 20,
                                          width: 100,
                                        ),
                                        Textfield(
                                          top: 1200,
                                          left: 250,
                                          height: 20,
                                          width: 100,
                                        ),

                                        Textfield(
                                          top: 700,
                                          left: 670,
                                          height: 20,
                                          width: 100,
                                        ),

                                        Textfield(
                                          top: 1070,
                                          left: 670,
                                          height: 20,
                                          width: 100,
                                        ),
                                        Textfield(
                                            top: 260,
                                            left: 850,
                                            height: 20,
                                            width: 100),
                                        Textfield(
                                            top: 450,
                                            left: 850,
                                            height: 20,
                                            width: 100),
                                        Textfield(
                                          top: 680,
                                          left: 850,
                                          height: 20,
                                          width: 100,
                                        ),
                                        Textfield(
                                          top: 1050,
                                          left: 850,
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
        width: 50,
        child: TextField(
          decoration: InputDecoration(isDense: true),
          style: TextStyle(
              color: Colors.black,
              backgroundColor: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
