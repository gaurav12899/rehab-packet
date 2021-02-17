import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;
import 'package:project/screen/forms/CosmeticRestorationHand/cosmeticRestorationHandB.dart';

class CosmeticRestorationHandA extends StatefulWidget {
  static const routeName = '/cosmeticRestorationHandA';

  @override
  _CosmeticRestorationHandAState createState() =>
      _CosmeticRestorationHandAState();
}

class _CosmeticRestorationHandAState extends State<CosmeticRestorationHandA> {
  GlobalKey _containerKey = GlobalKey();

  var _type;

  final doc = pw.Document();
  List bytList = [];
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

  void _printPngBytes(String username) async {
    var pngBytes = await _capturePng();
    if (bytList.length > 0) {
      bytList.removeLast();
    }
    bytList.add(pngBytes);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) =>
            CosmeticRestorationHandB(bytelist: bytList, username: username)));

    // print(bs64);
  }

  @override
  Widget build(BuildContext context) {
    final String username = ModalRoute.of(context).settings.arguments;
    if (bytList.length > 0) {
      bytList.removeLast();
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.navigate_next),
              onPressed: () {
                _printPngBytes(username);
              })
        ],
        title: Text("Partial Hand Prosthesis "),
      ),
      body: SingleChildScrollView(
        child: RepaintBoundary(
          key: _containerKey,
          child: Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(border: Border.all(width: 2)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Patient Registration Numb:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                          child: TextField(
                        keyboardType: TextInputType.number,
                      ))
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Cause Of Amputation:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(child: TextField())
                    ],
                  ),
                  Type(type2: _type),
                  SkinCode(),
                  HandCasting(),
                  Text(
                    "Hand Measurements-",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Circumference Measurement",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "At Wrist Level",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text("2 cm above Wrist"),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(child: TextField())
                    ],
                  ),
                  Row(
                    children: [
                      Text("4 cm above Wrist"),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(child: TextField())
                    ],
                  ),
                  Text(
                    "At metcarpophalangeal level",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 100,
                          ),
                          Text(
                            "DIP-1",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 100,
                          ),
                          Text("PIP-1",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("1",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 80,
                          ),
                          Container(width: 80, child: TextField()),
                          SizedBox(
                            width: 70,
                          ),
                          Container(width: 80, child: TextField()),
                        ],
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("2",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 80,
                          ),
                          Container(width: 80, child: TextField()),
                          SizedBox(
                            width: 70,
                          ),
                          Container(width: 80, child: TextField()),
                        ],
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("3",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 80,
                          ),
                          Container(width: 80, child: TextField()),
                          SizedBox(
                            width: 70,
                          ),
                          Container(width: 80, child: TextField()),
                        ],
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("4",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 80,
                          ),
                          Container(width: 80, child: TextField()),
                          SizedBox(
                            width: 70,
                          ),
                          Container(width: 80, child: TextField()),
                        ],
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("5",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 80,
                          ),
                          Container(width: 80, child: TextField()),
                          SizedBox(
                            width: 70,
                          ),
                          Container(width: 80, child: TextField()),
                        ],
                      )
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

class SkinCode extends StatefulWidget {
  var _actLevel;

  @override
  _SkinCodeState createState() => _SkinCodeState();
}

class _SkinCodeState extends State<SkinCode> {
  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Skin-Code\n   For:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
                activeColor: Colors.green,
                value: 0,
                groupValue: widget._actLevel,
                onChanged: (val) {
                  setState(() {
                    widget._actLevel = val;
                  });
                }),
            Text(
              "Palmar",
              textAlign: TextAlign.justify,
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
                activeColor: Colors.green,
                value: 1,
                groupValue: widget._actLevel,
                onChanged: (val) {
                  setState(() {
                    widget._actLevel = val;
                  });
                }),
            Text(
              "Dorsal",
              textAlign: TextAlign.justify,
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
                activeColor: Colors.green,
                value: 2,
                groupValue: widget._actLevel,
                onChanged: (val) {
                  setState(() {
                    widget._actLevel = val;
                  });
                }),
            Text(
              "Knuckles",
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ],
    );
  }
}

class Type extends StatefulWidget {
  Type({
    @required type2,
  }) : _type = type2;

  var _type;

  @override
  _TypeState createState() => _TypeState();
}

class _TypeState extends State<Type> {
  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Type ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
                activeColor: Colors.green,
                value: 0,
                groupValue: widget._type,
                onChanged: (val) {
                  setState(() {
                    widget._type = val;
                  });
                }),
            Text(
              "Pre- Fabricated",
              textAlign: TextAlign.justify,
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
                activeColor: Colors.green,
                value: 1,
                groupValue: widget._type,
                onChanged: (val) {
                  setState(() {
                    widget._type = val;
                  });
                }),
            Text(
              "Customised",
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ],
    );
  }
}

class HandCasting extends StatefulWidget {
  @override
  _HandCastingState createState() => _HandCastingState();
}

class _HandCastingState extends State<HandCasting> {
  var _socketType;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Hand Casting",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                        activeColor: Colors.green,
                        value: 2,
                        groupValue: _socketType,
                        onChanged: (val) {
                          setState(() {
                            _socketType = val;
                          });
                        }),
                    Text(
                      "Alginate",
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                    width: 80,
                    child: TextField(
                      decoration: InputDecoration(hintText: "Others"),
                    ))
              ],
            ),
          ],
        ),
      ],
    );
  }
}
