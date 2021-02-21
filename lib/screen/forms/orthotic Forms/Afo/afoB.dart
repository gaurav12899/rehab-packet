import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;
import 'package:project/screen/forms/orthotic%20Forms/Afo/afoC.dart';

class AfoB extends StatefulWidget {
  static const routeName = '/AfoB';
  var bytelist;
  var username;
  AfoB({@required this.bytelist, @required this.username});
  @override
  _AfoBState createState() => _AfoBState();
}

class _AfoBState extends State<AfoB> {
  bool dorsi = false;
  bool planter = false;
  bool inversion = false;
  bool eversion = false;
  bool fixed = false;
  bool flexible = false;
  bool adduction = false;
  bool abduction = false;

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
    if (widget.bytelist.length > 1) {
      widget.bytelist.removeLast();
    }
    await widget.bytelist.add(pngBytes);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => AfoC(
              bytelist: widget.bytelist,
              username: widget.username,
            )));
  }

  @override
  Widget build(BuildContext context) {
    // args.values.toList()
    return Scaffold(
      appBar: AppBar(
        title: Text("AFO"),
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Ankle\nPosition:",
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
                            Text("Dorsi\nflexion")
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
                            Text("Planter\nflexion")
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
                                  hintText: "others",
                                  isDense: true,
                                ),
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
                          "Heel\nPosition:",
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
                          Expanded(
                              child: TextField(
                            decoration: InputDecoration(isDense: true),
                          )),
                          Expanded(
                              child: TextField(
                            decoration: InputDecoration(isDense: true),
                          )),
                          Expanded(
                              child: TextField(
                            decoration: InputDecoration(isDense: true),
                          )),
                          Expanded(
                              child: TextField(
                            decoration: InputDecoration(isDense: true),
                          )),
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
