import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;
import 'package:project/screen/forms/FormType/prosthetic.dart';
import 'package:project/screen/forms/prostheticForms/TransfemoralMeasurementForm/transfemoralMeasurmentFormB.dart';

class TransfemoralMeasurementA extends StatefulWidget {
  static const routeName = '/transfemoralMeasurementA';
  final username;
  TransfemoralMeasurementA(this.username);

  @override
  _TransfemoralMeasurementAState createState() =>
      _TransfemoralMeasurementAState();
}

class _TransfemoralMeasurementAState extends State<TransfemoralMeasurementA> {
  GlobalKey _containerKey = GlobalKey();

  var _side;
  var _actLevel;
  var _distalEndType;
  var _stumpType;
  var _socketType;
  var _castingType;

  final doc = pw.Document();
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
    if (bytList.length > 0) {
      bytList.removeLast();
    }
    bytList.add(pngBytes);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) =>
            TransfemoralMeasurementB(bytelist: bytList, username: username)));

    // print(bs64);
  }

  @override
  Widget build(BuildContext context) {
    if (bytList.length > 0) {
      bytList.removeLast();
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Transfemoral Measurement Form"),
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Patient Registration:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: TextField())
                      ],
                    ),
                    SideOfAmputation(side2: _side),
                    ActivityLevel(actLevel2: _actLevel),
                    Divider(),
                    DistalEndType(distalEndType2: _distalEndType),
                    Divider(),
                    StumpMuscleType(stumpMuscleType2: _stumpType),
                    Divider(),
                    SocketType(socketType2: _socketType),
                    Divider(),
                    CastingType(castingType2: _castingType),
                    Divider(),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
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

class ActivityLevel extends StatefulWidget {
  ActivityLevel({
    Key key,
    @required actLevel2,
  })  : _actLevel = actLevel2,
        super(key: key);

  var _actLevel;

  @override
  _ActivityLevelState createState() => _ActivityLevelState();
}

class _ActivityLevelState extends State<ActivityLevel> {
  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Activity Level ",
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
              "K1-K2",
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
              "K2-K3",
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
              "K3-K4",
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Stump\nMuscel Type",
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                    activeColor: Colors.green,
                    value: 3,
                    groupValue: widget._stumpMuscleType,
                    onChanged: (val) {
                      setState(() {
                        widget._stumpMuscleType = val;
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
              "Socket\nType",
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
                        groupValue: widget._socketType,
                        onChanged: (val) {
                          setState(() {
                            widget._socketType = val;
                          });
                        }),
                    Text(
                      "Quadilateral",
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
                      "Ischeal\nContainment",
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
                        groupValue: widget._socketType,
                        onChanged: (val) {
                          setState(() {
                            widget._socketType = val;
                          });
                        }),
                    Text(
                      "Hybrid",
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio(
                            activeColor: Colors.green,
                            value: 4,
                            groupValue: widget._socketType,
                            onChanged: (val) {
                              setState(() {
                                widget._socketType = val;
                              });
                            }),
                        if (widget._socketType != 4)
                          Text(
                            "Others",
                            textAlign: TextAlign.justify,
                          )
                      ],
                    ),
                    if (widget._socketType == 4)
                      Container(
                        width: 100,
                        child: TextField(
                          decoration: InputDecoration(hintText: "Others"),
                        ),
                      ),
                  ],
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class CastingType extends StatefulWidget {
  CastingType({
    Key key,
    @required castingType2,
  })  : _castingType = castingType2,
        super(key: key);

  var _castingType;

  @override
  _CastingTypeState createState() => _CastingTypeState();
}

class _CastingTypeState extends State<CastingType> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Casting Type",
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
                        groupValue: widget._castingType,
                        onChanged: (val) {
                          setState(() {
                            widget._castingType = val;
                          });
                        }),
                    Text(
                      "Hand Cast",
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
                        groupValue: widget._castingType,
                        onChanged: (val) {
                          setState(() {
                            widget._castingType = val;
                          });
                        }),
                    Text(
                      "Brim Cast",
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                        activeColor: Colors.green,
                        value: 2,
                        groupValue: widget._castingType,
                        onChanged: (val) {
                          setState(() {
                            widget._castingType = val;
                          });
                        }),
                    Text(
                      "CAD-CAM",
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
                        value: 3,
                        groupValue: widget._castingType,
                        onChanged: (val) {
                          setState(() {
                            widget._castingType = val;
                          });
                        }),
                    Text(
                      "Jig Cast",
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                        activeColor: Colors.green,
                        value: 4,
                        groupValue: widget._castingType,
                        onChanged: (val) {
                          setState(() {
                            widget._castingType = val;
                          });
                        }),
                    Text(
                      "Saddal Cast",
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio(
                            activeColor: Colors.green,
                            value: 100,
                            groupValue: widget._castingType,
                            onChanged: (val) {
                              setState(() {
                                widget._castingType = val;
                              });
                            }),
                        if (widget._castingType != 100)
                          Text(
                            "Others",
                            textAlign: TextAlign.justify,
                          )
                      ],
                    ),
                    if (widget._castingType == 100)
                      Container(
                        width: 100,
                        child: TextField(
                          decoration: InputDecoration(hintText: "Others"),
                        ),
                      ),
                  ],
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
