import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;
import 'package:project/screen/forms/spinalOrthosis/spinalOrthosisB.dart';
import 'package:project/screen/forms/wristHandOrthosis/wristHandOrthosisB.dart';

class SpinalOrthosisA extends StatefulWidget {
  static const routeName = 'spinalOrthosisA';
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

    if (boundary.debugNeedsPaint) {
      print("Waiting for boundary to be painted.");
      await Future.delayed(const Duration(milliseconds: 20));
      return _capturePng();
    }

    var image = await boundary.toImage();
    var byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData.buffer.asUint8List();
  }

  void _printPngBytes(String username) async {
    var pngBytes = await _capturePng();
    // var bs64 = base64Encode(pngBytes);
    ;
    if (bytList.length > 0) {
      bytList.removeLast();
    }
    bytList.add(pngBytes);
    Navigator.of(context).pushNamed(SpinalOrthosisB.routeName,
        arguments: {"bytelist": bytList, "username": username});

    // print(bs64);
  }

  @override
  Widget build(BuildContext context) {
    final String username = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Spinal Orthosis"),
        actions: [
          IconButton(
              icon: Icon(Icons.navigate_next_rounded),
              onPressed: () {
                _printPngBytes(username);
              })
        ],
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
                            keyboardType: TextInputType.number,
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
                            keyboardType: TextInputType.number,
                            textAlignVertical: TextAlignVertical.top,
                          )),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "X-ray Diagnois:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                              child: TextField(
                            keyboardType: TextInputType.number,
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
                            keyboardType: TextInputType.number,
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
                            keyboardType: TextInputType.number,
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
                            keyboardType: TextInputType.number,
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
                            keyboardType: TextInputType.number,
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
                            keyboardType: TextInputType.number,
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
                            keyboardType: TextInputType.number,
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
                            keyboardType: TextInputType.number,
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
                            keyboardType: TextInputType.number,
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
                            keyboardType: TextInputType.number,
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
            margin: EdgeInsets.all(10),
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
                  "Scolosis\nBrace",
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
              Radio(
                  activeColor: Colors.green,
                  value: 3,
                  groupValue: widget._tlsoType,
                  onChanged: (val) {
                    setState(() {
                      widget._tlsoType = val;
                    });
                  }),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(hintText: "Others"),
                ),
              ),
            ],
          )
        ]);
  }
}
