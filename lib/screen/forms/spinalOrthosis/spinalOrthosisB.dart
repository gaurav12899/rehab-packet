import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;
import 'package:project/screen/forms/spinalOrthosis/spinalOrthosisA.dart';
import 'package:project/screen/forms/spinalOrthosis/spinalOrthosisC.dart';

class SpinalOrthosisB extends StatefulWidget {
  static const routeName = 'spinalorthosisB';
  @override
  _SpinalOrthosisBState createState() => _SpinalOrthosisBState();
}

class _SpinalOrthosisBState extends State<SpinalOrthosisB> {
  bool _guestMat = false;
  bool _opening = false;
  bool _offsetOpening = false;
  bool _lordosis = false;
  bool _lining = false;

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
    var byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData.buffer.asUint8List();
  }

  void _printPngBytes(dynamic args) async {
    var pngBytes = await _capturePng();
    await args['bytelist'].add(pngBytes);
    Navigator.of(context).pushNamed(SpinalOrthosisC.routeName, arguments: {
      "bytelist": args["bytelist"],
      "username": args["username"]
    });

    // print(bs64);
  }

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    if (args['bytelist'].length > 1) {
      args['bytelist'].removeLast();
    }
    // args.values.toList()
    return Scaffold(
      appBar: AppBar(
        title: Text("Spinal Orthosis"),
        actions: [
          IconButton(
              icon: Icon(Icons.navigate_next_rounded),
              onPressed: () {
                _printPngBytes(args);
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
                    GuestMaterialOnWindows(guestMaterial2: _guestMat),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "CutOut Location:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                            child: TextField(
                          textAlignVertical: TextAlignVertical.top,
                        ))
                      ],
                    ),
                    Divider(),
                    Opening(opening2: _opening),
                    OffsetOpening(offsetOpening2: _offsetOpening),
                    Lordosis(lordosis2: _lordosis),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Additional Info:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                            child: TextField(
                          maxLines: 3,
                          textAlignVertical: TextAlignVertical.top,
                        )),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Material:",
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
                          "Thickness:",
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
                          "Color/Transfer:",
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
                          "Lining:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                            child: TextField(
                          textAlignVertical: TextAlignVertical.top,
                        )),
                        Row(
                          children: [
                            Radio(
                                // title: Text("Flexible"),
                                activeColor: Colors.green,
                                value: 0,
                                groupValue: _lining,
                                onChanged: (val) {
                                  setState(() {
                                    _lining = val;
                                  });
                                }),
                            Text("3mm")
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                // title: Text("Flexible"),
                                activeColor: Colors.green,
                                value: 1,
                                groupValue: _lining,
                                onChanged: (val) {
                                  setState(() {
                                    _lining = val;
                                  });
                                }),
                            Text("6mm")
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Additional Info.",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          maxLines: 3,
                        )
                      ],
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

class GuestMaterialOnWindows extends StatefulWidget {
  GuestMaterialOnWindows({
    Key key,
    @required guestMaterial2,
  })  : _guestMaterial = guestMaterial2,
        super(key: key);

  var _guestMaterial;

  @override
  _GuestMaterialOnWindowsState createState() => _GuestMaterialOnWindowsState();
}

class _GuestMaterialOnWindowsState extends State<GuestMaterialOnWindows> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(
        "Guset Material\nOn Windows",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Row(
        children: [
          Radio(
              // title: Text("Flexible"),
              activeColor: Colors.green,
              value: 0,
              groupValue: widget._guestMaterial,
              onChanged: (val) {
                setState(() {
                  widget._guestMaterial = val;
                });
              }),
          Text("Yes")
        ],
      ),
      Row(
        children: [
          Radio(
              // title: Text("Flexible"),
              activeColor: Colors.green,
              value: 1,
              groupValue: widget._guestMaterial,
              onChanged: (val) {
                setState(() {
                  widget._guestMaterial = val;
                });
              }),
          Text("No")
        ],
      ),
    ]);
  }
}

class Opening extends StatefulWidget {
  Opening({
    Key key,
    @required opening2,
  })  : _opening = opening2,
        super(key: key);

  var _opening;

  @override
  _OpeningState createState() => _OpeningState();
}

class _OpeningState extends State<Opening> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Opening",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(children: [
          Row(
            children: [
              Radio(
                  // title: Text("Flexible"),
                  activeColor: Colors.green,
                  value: 1,
                  groupValue: widget._opening,
                  onChanged: (val) {
                    setState(() {
                      widget._opening = val;
                    });
                  }),
              Text("Anterior")
            ],
          ),
          Row(
            children: [
              Radio(
                  // title: Text("Flexible"),
                  activeColor: Colors.green,
                  value: 2,
                  groupValue: widget._opening,
                  onChanged: (val) {
                    setState(() {
                      widget._opening = val;
                    });
                  }),
              Text("Posterior")
            ],
          ),
          Row(
            children: [
              Radio(
                  // title: Text("Flexible"),
                  activeColor: Colors.green,
                  value: 0,
                  groupValue: widget._opening,
                  onChanged: (val) {
                    setState(() {
                      widget._opening = val;
                    });
                  }),
              Text("Bi-value")
            ],
          ),
        ]),
      ],
    );
  }
}

class Lordosis extends StatefulWidget {
  Lordosis({
    Key key,
    @required lordosis2,
  })  : _lordosis = lordosis2,
        super(key: key);

  var _lordosis;

  @override
  _LordosisState createState() => _LordosisState();
}

class _LordosisState extends State<Lordosis> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Opening",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(children: [
          Row(
            children: [
              Radio(
                  // title: Text("Flexible"),
                  activeColor: Colors.green,
                  value: 1,
                  groupValue: widget._lordosis,
                  onChanged: (val) {
                    setState(() {
                      widget._lordosis = val;
                    });
                  }),
              Text("0")
            ],
          ),
          Row(
            children: [
              Radio(
                  // title: Text("Flexible"),
                  activeColor: Colors.green,
                  value: 2,
                  groupValue: widget._lordosis,
                  onChanged: (val) {
                    setState(() {
                      widget._lordosis = val;
                    });
                  }),
              Text("10")
            ],
          ),
          Row(
            children: [
              Radio(
                  // title: Text("Flexible"),
                  activeColor: Colors.green,
                  value: 0,
                  groupValue: widget._lordosis,
                  onChanged: (val) {
                    setState(() {
                      widget._lordosis = val;
                    });
                  }),
              Text("15")
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: TextField(
            decoration: InputDecoration(hintText: "Other"),
          ))
        ]),
      ],
    );
  }
}

class OffsetOpening extends StatefulWidget {
  OffsetOpening({
    Key key,
    @required offsetOpening2,
  })  : _offsetOpening = offsetOpening2,
        super(key: key);

  var _offsetOpening;

  @override
  _OffsetOpeningState createState() => _OffsetOpeningState();
}

class _OffsetOpeningState extends State<OffsetOpening> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(
        "Offset Opening",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Row(
        children: [
          Radio(
              // title: Text("Flexible"),
              activeColor: Colors.green,
              value: 1,
              groupValue: widget._offsetOpening,
              onChanged: (val) {
                setState(() {
                  widget._offsetOpening = val;
                });
              }),
          Text("Right")
        ],
      ),
      Row(
        children: [
          Radio(
              // title: Text("Flexible"),
              activeColor: Colors.green,
              value: 2,
              groupValue: widget._offsetOpening,
              onChanged: (val) {
                setState(() {
                  widget._offsetOpening = val;
                });
              }),
          Text("Left")
        ],
      ),
    ]);
  }
}