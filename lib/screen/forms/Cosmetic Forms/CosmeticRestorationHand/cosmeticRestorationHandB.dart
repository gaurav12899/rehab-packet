import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:project/screen/forms/Cosmetic%20Forms/CosmeticRestorationHand/cosmeticRestorationHandC.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;

class CosmeticRestorationHandB extends StatefulWidget {
  static const routeName = '/cosmeticRestorationHandb';

  var bytelist;
  var username;
  CosmeticRestorationHandB({@required this.bytelist, @required this.username});
  @override
  _CosmeticRestorationHandBState createState() =>
      _CosmeticRestorationHandBState();
}

class _CosmeticRestorationHandBState extends State<CosmeticRestorationHandB> {
  GlobalKey _containerKey = GlobalKey();

  var _type;
  bool loading = false;

  final doc = pw.Document();
  List bytList = [];
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
    this.setState(() {
      loading = true;
    });
    var pngBytes = await _capturePng();
    if (widget.bytelist.length > 1) {
      widget.bytelist.removeLast();
    }
    await widget.bytelist.add(pngBytes);
    // print(widget.bytelist);

    await Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => CosmeticRestorationHandC(
            bytelist: widget.bytelist, username: widget.username)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text("Partial Hand Prosthesis"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RepaintBoundary(
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
                            "Linear Measurements :",
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
                            "Wrist crease to tip of middle fingers:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: TextField(),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 100,
                                height: 40,
                              ),
                              Text(
                                "MCP to tip of finger",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("1",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: 40,
                              ),
                              Expanded(child: TextField()),
                            ],
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("2",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: 40,
                              ),
                              Expanded(child: TextField()),
                            ],
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("3",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: 40,
                              ),
                              Expanded(child: TextField()),
                            ],
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("4",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: 40,
                              ),
                              Expanded(child: TextField()),
                            ],
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("5",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: 40,
                              ),
                              Expanded(child: TextField()),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Image(
                            image: AssetImage('assets/images/CRHand.png')),
                      ),
                    ]),
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
    Key key,
    @required type2,
  })  : _type = type2,
        super(key: key);

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
