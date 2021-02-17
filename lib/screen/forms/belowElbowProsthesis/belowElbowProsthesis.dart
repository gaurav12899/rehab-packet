import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;
import 'package:project/screen/forms/TransfemoralMeasurementForm/transfemoralMeasurmentFormB.dart';
import 'package:project/screen/forms/belowElbowProsthesis/belowElbowProsthesisB.dart';

class BelowElbowProsthesis extends StatefulWidget {
  static const routeName = '/belowElbowProsthesis';

  @override
  _BelowElbowProsthesisState createState() => _BelowElbowProsthesisState();
}

class _BelowElbowProsthesisState extends State<BelowElbowProsthesis> {
  GlobalKey _containerKey = GlobalKey();

  var _side;
  var _stumpLength;
  var _distalEndType;
  var _stumpType;
  var _socketType;

  final doc = pw.Document();
  List bytList = [];
  _capturePng() async {
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
            BelowElbowProsthesisB(bytelist: bytList, username: username)));

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
        title: Text("Below Elbow Prosthesis"),
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      "Patient Registration No. :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(child: TextField())
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Date :    ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(hintText: "DD/MM/YY"),
                        keyboardType: TextInputType.datetime,
                      ),
                    )
                  ],
                ),
                SideOfAmputation(side2: _side),
                StumpLength(
                  stumpLength2: _stumpLength,
                ),
                Divider(),
                DistalEndType(distalEndType2: _distalEndType),
                Divider(),
                StumpMuscleType(stumpMuscleType2: _stumpType),
                Divider(),
                SocketType(socketType2: _socketType),
                Divider(),
                Row(
                  children: [
                    Text(
                      "Wrist Unit Type :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(child: TextField())
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Terminal\nDevice Type :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(child: TextField())
                  ],
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StumpLength extends StatefulWidget {
  StumpLength({
    Key key,
    @required stumpLength2,
  })  : _stumpLength = stumpLength2,
        super(key: key);

  var _stumpLength;

  @override
  _StumpLengthState createState() => _StumpLengthState();
}

class _StumpLengthState extends State<StumpLength> {
  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Stump Length ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
                activeColor: Colors.green,
                value: 0,
                groupValue: widget._stumpLength,
                onChanged: (val) {
                  setState(() {
                    widget._stumpLength = val;
                  });
                }),
            Text(
              "Short",
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
                groupValue: widget._stumpLength,
                onChanged: (val) {
                  setState(() {
                    widget._stumpLength = val;
                  });
                }),
            Text(
              "Long",
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
                groupValue: widget._stumpLength,
                onChanged: (val) {
                  setState(() {
                    widget._stumpLength = val;
                  });
                }),
            Text(
              "Ideal",
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ],
    );
  }
}

class SideOfAmputation extends StatefulWidget {
  SideOfAmputation({
    Key key,
    @required side2,
  })  : _side = side2,
        super(key: key);

  var _side;

  @override
  _SideOfAmputationState createState() => _SideOfAmputationState();
}

class _SideOfAmputationState extends State<SideOfAmputation> {
  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Side of\nAmputation ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
                activeColor: Colors.green,
                value: 0,
                groupValue: widget._side,
                onChanged: (val) {
                  setState(() {
                    widget._side = val;
                  });
                }),
            Text(
              "Left",
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
                groupValue: widget._side,
                onChanged: (val) {
                  setState(() {
                    widget._side = val;
                  });
                }),
            Text(
              "Right",
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
                groupValue: widget._side,
                onChanged: (val) {
                  setState(() {
                    widget._side = val;
                  });
                }),
            Text(
              "Biletral",
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ],
    );
  }
}

class DistalEndType extends StatefulWidget {
  DistalEndType({
    Key key,
    @required distalEndType2,
  })  : _distalEndType = distalEndType2,
        super(key: key);

  var _distalEndType;

  @override
  _DistalEndTypeState createState() => _DistalEndTypeState();
}

class _DistalEndTypeState extends State<DistalEndType> {
  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Distal End Type",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              // crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                    activeColor: Colors.green,
                    value: 0,
                    groupValue: widget._distalEndType,
                    onChanged: (val) {
                      setState(() {
                        widget._distalEndType = val;
                      });
                    }),
                Text(
                  "Conical",
                  // textAlign: TextAlign.justify,
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio(
                    activeColor: Colors.green,
                    value: 1,
                    groupValue: widget._distalEndType,
                    onChanged: (val) {
                      setState(() {
                        widget._distalEndType = val;
                      });
                    }),
                Text(
                  "Cylandrical",
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                    activeColor: Colors.green,
                    value: 2,
                    groupValue: widget._distalEndType,
                    onChanged: (val) {
                      setState(() {
                        widget._distalEndType = val;
                      });
                    }),
                Text(
                  "Bulbos",
                  textAlign: TextAlign.justify,
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                    activeColor: Colors.green,
                    value: 3,
                    groupValue: widget._distalEndType,
                    onChanged: (val) {
                      setState(() {
                        widget._distalEndType = val;
                      });
                    }),
                Text(
                  "Ideal",
                  textAlign: TextAlign.justify,
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}

class StumpMuscleType extends StatefulWidget {
  StumpMuscleType({
    Key key,
    @required stumpMuscleType2,
  })  : _stumpMuscleType = stumpMuscleType2,
        super(key: key);

  var _stumpMuscleType;

  @override
  _StumpMuscleTypeState createState() => _StumpMuscleTypeState();
}

class _StumpMuscleTypeState extends State<StumpMuscleType> {
  @override
  Widget build(BuildContext context) {
    return Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Stump Muscel Type",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                          activeColor: Colors.green,
                          value: 0,
                          groupValue: widget._stumpMuscleType,
                          onChanged: (val) {
                            setState(() {
                              widget._stumpMuscleType = val;
                            });
                          }),
                      Text(
                        "Bony",
                        // textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                          activeColor: Colors.green,
                          value: 1,
                          groupValue: widget._stumpMuscleType,
                          onChanged: (val) {
                            setState(() {
                              widget._stumpMuscleType = val;
                            });
                          }),
                      Text(
                        "Loose",
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                          activeColor: Colors.green,
                          value: 2,
                          groupValue: widget._stumpMuscleType,
                          onChanged: (val) {
                            setState(() {
                              widget._stumpMuscleType = val;
                            });
                          }),
                      Text(
                        "Firm",
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                ],
              ),
            ],
          )
        ]);
  }
}

class SocketType extends StatefulWidget {
  SocketType({
    Key key,
    @required socketType2,
  })  : _socketType = socketType2,
        super(key: key);

  var _socketType;

  @override
  _SocketTypeState createState() => _SocketTypeState();
}

class _SocketTypeState extends State<SocketType> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Socket Type",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                        activeColor: Colors.green,
                        value: 0,
                        groupValue: widget._socketType,
                        onChanged: (val) {
                          setState(() {
                            widget._socketType = val;
                          });
                        }),
                    Text(
                      "Northwestern",
                      // textAlign: TextAlign.justify,
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                        activeColor: Colors.green,
                        value: 1,
                        groupValue: widget._socketType,
                        onChanged: (val) {
                          setState(() {
                            widget._socketType = val;
                          });
                        }),
                    Text(
                      "Muenster",
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
