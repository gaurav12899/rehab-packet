import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class UiImagePainter extends CustomPainter {
  final ui.Image image;

  UiImagePainter(this.image);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    // simple aspect fit for the image
    var hr = size.height / image.height;
    var wr = size.width / image.width;

    double ratio;
    double translateX;
    double translateY;
    if (hr < wr) {
      ratio = hr;
      translateX = (size.width - (ratio * image.width)) / 2;
      translateY = 0.0;
    } else {
      ratio = wr;
      translateX = 0.0;
      translateY = (size.height - (ratio * image.height)) / 2;
    }

    canvas.translate(translateX, translateY);
    canvas.scale(ratio, ratio);
    canvas.drawImage(image, new Offset(0.0, 0.0), new Paint());
  }

  @override
  bool shouldRepaint(UiImagePainter other) {
    return other.image != image;
  }
}

class UiImageDrawer extends StatelessWidget {
  final ui.Image image;

  const UiImageDrawer({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: UiImagePainter(image),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<OverRepaintBoundaryState> globalKey = GlobalKey();

  ui.Image image;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: image == null
            ? Capturer(
                overRepaintKey: globalKey,
              )
            : UiImageDrawer(image: image),
        floatingActionButton: image == null
            ? FloatingActionButton(
                child: Icon(Icons.camera),
                onPressed: () async {
                  var renderObject =
                      globalKey.currentContext.findRenderObject();

                  RenderRepaintBoundary boundary = renderObject;
                  ui.Image captureImage = await boundary.toImage();
                  setState(() => image = captureImage);
                },
              )
            : FloatingActionButton(
                onPressed: () => setState(() => image = null),
                child: Icon(Icons.remove),
              ),
      ),
    );
  }
}

class Capturer extends StatelessWidget {
  static final Random random = Random();

  final GlobalKey<OverRepaintBoundaryState> overRepaintKey;

  const Capturer({Key key, this.overRepaintKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: OverRepaintBoundary(
        key: overRepaintKey,
        child: RepaintBoundary(
          child: Column(
            children: List.generate(
              30,
              (i) => Container(
                color: Color.fromRGBO(random.nextInt(256), random.nextInt(256),
                    random.nextInt(256), 1.0),
                height: 100,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OverRepaintBoundary extends StatefulWidget {
  final Widget child;

  const OverRepaintBoundary({Key key, this.child}) : super(key: key);

  @override
  OverRepaintBoundaryState createState() => OverRepaintBoundaryState();
}

class OverRepaintBoundaryState extends State<OverRepaintBoundary> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
