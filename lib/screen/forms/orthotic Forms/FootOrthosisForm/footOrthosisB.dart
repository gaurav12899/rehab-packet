import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:project/screen/forms/Cosmetic%20Forms/cosmeticRestorationFingers/cosmeticRestFingersC.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;
import 'package:project/screen/forms/orthotic%20Forms/FootOrthosisForm/footOrthosisC.dart';

class FootOrthosisB extends StatefulWidget {
  static const routeName = '/cosmeticRestorationFingersB';

  var bytelist;
  var username;
  FootOrthosisB({@required this.bytelist, @required this.username});
  @override
  _FootOrthosisBState createState() => _FootOrthosisBState();
}

class _FootOrthosisBState extends State<FootOrthosisB> {
  GlobalKey _containerKey = GlobalKey();

  var _type;
  bool loading = false;
  bool arcSupportR = false;
  bool metatarsalPadR = false;
  bool metatarsalBarR = false;
  bool heelPadR = false;
  bool heelWedgeR = false;
  bool toeFIllerR = false;
  bool mortonExtensionR = false;

  final doc = pw.Document();
  List bytList = [];
  Future<Uint8List> _capturePng() async {
    RenderRepaintBoundary boundary =
        _containerKey.currentContext.findRenderObject();

    ui.Image image;
    bool catched = false;
    try {
      image = await boundary.toImage(pixelRatio: 1.50);
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

    await Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => FootOrthosisC(
            bytelist: widget.bytelist, username: widget.username)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Foot Orthosis"),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Modification (L):",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.center
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: arcSupportR,
                                      onChanged: (bool value) {
                                        setState(() {
                                          arcSupportR = value;
                                        });
                                      }),
                                  Text("Arch\nSupport")
                                ],
                              ),
                              Column(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: metatarsalPadR,
                                      onChanged: (bool value) {
                                        setState(() {
                                          metatarsalPadR = value;
                                        });
                                      }),
                                  Text("Metatarsal\nPad")
                                ],
                              ),
                              Column(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: metatarsalBarR,
                                      onChanged: (bool value) {
                                        setState(() {
                                          metatarsalBarR = value;
                                        });
                                      }),
                                  Text("Metatarsal\nBar")
                                ],
                              ),
                              Column(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: heelPadR,
                                      onChanged: (bool value) {
                                        setState(() {
                                          heelPadR = value;
                                        });
                                      }),
                                  Text("Heel\nPad")
                                ],
                              ),
                            ],
                          ),
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.center
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: heelWedgeR,
                                      onChanged: (bool value) {
                                        setState(() {
                                          heelWedgeR = value;
                                        });
                                      }),
                                  Text("Heel\nWedge")
                                ],
                              ),
                              Column(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: toeFIllerR,
                                      onChanged: (bool value) {
                                        setState(() {
                                          toeFIllerR = value;
                                        });
                                      }),
                                  Text("Toe\nFiller")
                                ],
                              ),
                              Column(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: mortonExtensionR,
                                      onChanged: (bool value) {
                                        setState(() {
                                          mortonExtensionR = value;
                                        });
                                      }),
                                  Text("Morton's\nExtension")
                                ],
                              ),
                              Container(
                                width: 100,
                                child: TextField(
                                  decoration:
                                      InputDecoration(hintText: "Other"),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dimension Of Components:(L) :",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                "L :",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(child: TextField()),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "R :",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(child: TextField()),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Special Accommodations :",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(child: TextField()),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Foot Length :",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(child: TextField()),
                            ],
                          ),
                          SizedBox(
                            height: 200,
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
            SizedBox(
              height: 100,
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
