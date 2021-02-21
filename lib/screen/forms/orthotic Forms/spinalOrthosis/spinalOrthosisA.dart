import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;
import 'package:project/screen/forms/FormType/orthotic.dart';
import 'package:project/screen/forms/orthotic%20Forms/spinalOrthosis/spinalOrthosisB.dart';

class SpinalOrthosisA extends StatefulWidget {
  static const routeName = 'spinalOrthosisA';
  final username;
  SpinalOrthosisA(this.username);
  @override
  _SpinalOrthosisAState createState() => _SpinalOrthosisAState();
}

class _SpinalOrthosisAState extends State<SpinalOrthosisA> {
  final doc = pw.Document();
  bool _tlsoType = false;

  bool loading = false;
  GlobalKey _containerKey = GlobalKey();
  List bytList = [];
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

  void _printPngBytes(String username) async {
    var pngBytes = await _capturePng();
    // var bs64 = base64Encode(pngBytes);
    ;
    if (bytList.length > 0) {
      bytList.removeLast();
    }
    bytList.add(pngBytes);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) =>
            SpinalOrthosisB(bytelist: bytList, username: username)));
    // print(bs64);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spinal Orthosis"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Diagnosis:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                              child: TextField(
                            textAlignVertical: TextAlignVertical.top,
                          ))
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Prescription:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                              child: TextField(
                            textAlignVertical: TextAlignVertical.top,
                          )),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "X-ray Diagnosis:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                              child: TextField(
                            textAlignVertical: TextAlignVertical.top,
                          )),
                        ],
                      ),
                      TlsoType(tlsoType2: _tlsoType),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Brace Design:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                              child: TextField(
                            textAlignVertical: TextAlignVertical.top,
                          ))
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Axilla Extension:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                              child: TextField(
                            textAlignVertical: TextAlignVertical.top,
                          ))
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Thoracic Pad:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                              child: TextField(
                            textAlignVertical: TextAlignVertical.top,
                          ))
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Lumbar Pad",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                              child: TextField(
                            textAlignVertical: TextAlignVertical.top,
                          ))
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Trochanter Extension:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                              child: TextField(
                            textAlignVertical: TextAlignVertical.top,
                          ))
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Curve Type:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                              child: TextField(
                            maxLines: 3,
                            textAlignVertical: TextAlignVertical.top,
                          ))
                        ],
                      ),
                      Text(
                        "Orthotic Options:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Straps:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                              child: TextField(
                            textAlignVertical: TextAlignVertical.top,
                          ))
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Lapel:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                              child: TextField(
                            textAlignVertical: TextAlignVertical.top,
                          ))
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Abdominal Strap  :",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                              child: TextField(
                            textAlignVertical: TextAlignVertical.top,
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _printPngBytes(widget.username);
        },
        label: Text('Next'),
        icon: Icon(Icons.arrow_forward),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class TlsoType extends StatefulWidget {
  TlsoType({
    Key key,
    @required tlsoType2,
  })  : _tlsoType = tlsoType2,
        super(key: key);

  var _tlsoType;

  @override
  _TlsoTypeState createState() => _TlsoTypeState();
}

class _TlsoTypeState extends State<TlsoType> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              "Type Of TLSO ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Row(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                    activeColor: Colors.green,
                    value: 0,
                    groupValue: widget._tlsoType,
                    onChanged: (val) {
                      setState(() {
                        widget._tlsoType = val;
                      });
                    }),
                Text(
                  "Body\nJacket",
                  textAlign: TextAlign.justify,
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                    activeColor: Colors.green,
                    value: 1,
                    groupValue: widget._tlsoType,
                    onChanged: (val) {
                      setState(() {
                        widget._tlsoType = val;
                      });
                    }),
                Text(
                  "Scoliosis\nBrace",
                  textAlign: TextAlign.justify,
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                    activeColor: Colors.green,
                    value: 2,
                    groupValue: widget._tlsoType,
                    onChanged: (val) {
                      setState(() {
                        widget._tlsoType = val;
                      });
                    }),
                Text(
                  "Cad-Cam\nBrace",
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ]),
          Row(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                      activeColor: Colors.green,
                      value: 4,
                      groupValue: widget._tlsoType,
                      onChanged: (val) {
                        setState(() {
                          widget._tlsoType = val;
                        });
                      }),
                  if (widget._tlsoType != 4) Text("Others")
                ],
              ),
              if (widget._tlsoType == 4)
                Container(
                    width: 200,
                    child: TextField(
                      decoration: InputDecoration(hintText: "Others"),
                    ))
            ],
          ),
        ]);
  }
}
