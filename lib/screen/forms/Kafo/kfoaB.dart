import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
// import 'package:image_pixels/image_pixels.dart';
import 'package:project/screen/forms/Afo/afoC.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;
import 'package:project/screen/forms/Kafo/kfoac.dart';

class KafoB extends StatefulWidget {
  static const routeName = '/KafoB';
  var bytelist;
  var username;
  KafoB({@required this.bytelist, @required this.username});

  @override
  _KafoBState createState() => _KafoBState();
}

class _KafoBState extends State<KafoB> {
  bool dorsi = false;
  bool planter = false;
  bool inversion = false;
  bool eversion = false;
  bool fixed = false;
  bool flexible = false;
  bool adduction = false;
  bool abduction = false;
  bool varus = false;
  bool valgus = false;

  final doc = pw.Document();

  bool loading = false;
  GlobalKey _containerKey = GlobalKey();
  Future<Uint8List> _capturePng() async {
    RenderRepaintBoundary boundary =
        _containerKey.currentContext.findRenderObject();

    ui.Image image;
    bool catched = false;
    try {
      image = await boundary.toImage();
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
    if (widget.bytelist.length > 1) {
      widget.bytelist.removeLast();
    }
    await widget.bytelist.add(pngBytes);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) =>
            KafoC(bytelist: widget.bytelist, username: widget.username)));

    // print(bs64);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("KAFO"),
        actions: [
          IconButton(
              icon: Icon(Icons.navigate_next_rounded),
              onPressed: () {
                _printPngBytes();
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            RepaintBoundary(
              key: _containerKey,
              child: Container(
                margin: EdgeInsets.all(5),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Other Modification:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: TextField()),
                          Expanded(child: TextField()),
                          Expanded(child: TextField()),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Foot Size:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: TextField())
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Knee Position:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Column(
                          children: [
                            Checkbox(
                                activeColor: Colors.blue,
                                value: varus,
                                onChanged: (bool value) {
                                  setState(() {
                                    varus = value;
                                  });
                                }),
                            Text("varus")
                          ],
                        ),
                        Column(
                          children: [
                            Checkbox(
                                activeColor: Colors.blue,
                                value: valgus,
                                onChanged: (bool value) {
                                  setState(() {
                                    valgus = value;
                                  });
                                }),
                            Text("Valgus")
                          ],
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: TextField(
                                decoration: InputDecoration(
                                    hintText: "Needed correction"),
                              ))
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Ankle Position:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Column(
                          children: [
                            Checkbox(
                                activeColor: Colors.blue,
                                value: dorsi,
                                onChanged: (bool value) {
                                  setState(() {
                                    dorsi = value;
                                  });
                                }),
                            Text("Dorsi-flexion")
                          ],
                        ),
                        Column(
                          children: [
                            Checkbox(
                                activeColor: Colors.blue,
                                value: planter,
                                onChanged: (bool value) {
                                  setState(() {
                                    planter = value;
                                  });
                                }),
                            Text("Planter-flexion")
                          ],
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: TextField(
                                decoration: InputDecoration(hintText: "others"),
                              ))
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Heel Position:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Column(
                          children: [
                            Checkbox(
                                activeColor: Colors.blue,
                                value: inversion,
                                onChanged: (bool value) {
                                  setState(() {
                                    inversion = value;
                                  });
                                }),
                            Text("Inversion")
                          ],
                        ),
                        Column(
                          children: [
                            Checkbox(
                                activeColor: Colors.blue,
                                value: eversion,
                                onChanged: (bool value) {
                                  setState(() {
                                    eversion = value;
                                  });
                                }),
                            Text("Eversion")
                          ],
                        ),
                        Column(
                          children: [
                            Checkbox(
                                activeColor: Colors.blue,
                                value: fixed,
                                onChanged: (bool value) {
                                  setState(() {
                                    fixed = value;
                                  });
                                }),
                            Text("Fixed")
                          ],
                        ),
                        Column(
                          children: [
                            Checkbox(
                                activeColor: Colors.blue,
                                value: flexible,
                                onChanged: (bool value) {
                                  setState(() {
                                    flexible = value;
                                  });
                                }),
                            Text("Flexible")
                          ],
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Forefoot:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Column(
                          children: [
                            Checkbox(
                                activeColor: Colors.blue,
                                value: adduction,
                                onChanged: (bool value) {
                                  setState(() {
                                    adduction = value;
                                  });
                                }),
                            Text("Adduction")
                          ],
                        ),
                        Column(
                          children: [
                            Checkbox(
                                activeColor: Colors.blue,
                                value: abduction,
                                onChanged: (bool value) {
                                  setState(() {
                                    abduction = value;
                                  });
                                }),
                            Text("Abduction")
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 200,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Other Information:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: TextField()),
                          Expanded(child: TextField()),
                          Expanded(child: TextField()),
                          Expanded(child: TextField()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
