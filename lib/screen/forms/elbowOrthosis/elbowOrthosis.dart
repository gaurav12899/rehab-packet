import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;
import 'package:project/screen/forms/elbowOrthosis/elbowOrthosisB.dart';

class ElbowOrthosisA extends StatefulWidget {
  static const routeName = '/elbowOrthosisA';

  @override
  _ElbowOrthosisAState createState() => _ElbowOrthosisAState();
}

class _ElbowOrthosisAState extends State<ElbowOrthosisA> {
  bool _side = false;
  bool _skinCondition = false;
  bool _bloodCondition = false;
  bool _limbSensation = false;
  bool _elbowStaticControls = false;
  bool _elbowAssistanceNeeded = false;
  bool _wristStaticControls = false;
  bool _wristAssistanceNeeded = false;

  final doc = pw.Document();

  bool loading = false;
  GlobalKey _containerKey = GlobalKey();
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
    // var bs64 = base64Encode(pngBytes);

    if (bytList.length > 0) {
      bytList.removeLast();
    }
    bytList.add(pngBytes);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) =>
            ElbowOrthosisB(bytelist: bytList, username: username)));

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
        title: Text("Elbow Orthosis"),
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          ))
                        ],
                      ),
                      SideOfAmputation(side2: _side),
                      SkinCondition(skinCondition2: _skinCondition),
                      Divider(),
                      BloodCondition(bloodCondition2: _bloodCondition),
                      Divider(),
                      LimbSensation(limbSensation2: _limbSensation),
                      Divider(),
                      StaticControls(staticControls2: _elbowStaticControls),
                      Divider(),
                      AssistanceNeeded(
                          assistanceNeeded2: _elbowAssistanceNeeded),
                      Divider(),
                      StaticControls(staticControls2: _wristStaticControls),
                      Divider(),
                      AssistanceNeeded(
                          assistanceNeeded2: _wristAssistanceNeeded)
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
    return Row(crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "\nSide of Amputation ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
          ),
        ]);
  }
}

class SkinCondition extends StatefulWidget {
  SkinCondition({
    Key key,
    @required skinCondition2,
  })  : _skinCondition = skinCondition2,
        super(key: key);

  var _skinCondition;

  @override
  _SkinConditionState createState() => _SkinConditionState();
}

class _SkinConditionState extends State<SkinCondition> {
  @override
  Widget build(BuildContext context) {
    return Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            children: [
              Text(
                "Affected\nSkin Condition",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                      activeColor: Colors.green,
                      value: 0,
                      groupValue: widget._skinCondition,
                      onChanged: (val) {
                        setState(() {
                          widget._skinCondition = val;
                        });
                      }),
                  Text(
                    "Poor",
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
                      groupValue: widget._skinCondition,
                      onChanged: (val) {
                        setState(() {
                          widget._skinCondition = val;
                        });
                      }),
                  Text(
                    "Fair",
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
                      groupValue: widget._skinCondition,
                      onChanged: (val) {
                        setState(() {
                          widget._skinCondition = val;
                        });
                      }),
                  Text(
                    "Good",
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            ],
          )
        ]);
  }
}

class BloodCondition extends StatefulWidget {
  BloodCondition({
    Key key,
    @required bloodCondition2,
  })  : _bloodCondition = bloodCondition2,
        super(key: key);

  var _bloodCondition;

  @override
  _BloodConditionState createState() => _BloodConditionState();
}

class _BloodConditionState extends State<BloodCondition> {
  @override
  Widget build(BuildContext context) {
    return Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "Affected\nBlood Condition",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                      activeColor: Colors.green,
                      value: 0,
                      groupValue: widget._bloodCondition,
                      onChanged: (val) {
                        setState(() {
                          widget._bloodCondition = val;
                        });
                      }),
                  Text(
                    "Poor",
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
                      groupValue: widget._bloodCondition,
                      onChanged: (val) {
                        setState(() {
                          widget._bloodCondition = val;
                        });
                      }),
                  Text(
                    "Fair",
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
                      groupValue: widget._bloodCondition,
                      onChanged: (val) {
                        setState(() {
                          widget._bloodCondition = val;
                        });
                      }),
                  Text(
                    "Good",
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            ],
          )
        ]);
  }
}

class LimbSensation extends StatefulWidget {
  LimbSensation({
    Key key,
    @required limbSensation2,
  })  : _limbSensation = limbSensation2,
        super(key: key);

  var _limbSensation;

  @override
  _LimbSensationState createState() => _LimbSensationState();
}

class _LimbSensationState extends State<LimbSensation> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Wrap(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          alignment: WrapAlignment.center,
          direction: Axis.horizontal,
          children: [
            Text(
              "Affected\nLimb Sensation",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                    activeColor: Colors.green,
                    value: 0,
                    groupValue: widget._limbSensation,
                    onChanged: (val) {
                      setState(() {
                        widget._limbSensation = val;
                      });
                    }),
                Text(
                  "Poor",
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
                    groupValue: widget._limbSensation,
                    onChanged: (val) {
                      setState(() {
                        widget._limbSensation = val;
                      });
                    }),
                Text(
                  "Fair",
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
                    groupValue: widget._limbSensation,
                    onChanged: (val) {
                      setState(() {
                        widget._limbSensation = val;
                      });
                    }),
                Text(
                  "Good",
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class StaticControls extends StatefulWidget {
  StaticControls({
    Key key,
    @required staticControls2,
  })  : _staticControls = staticControls2,
        super(key: key);

  var _staticControls;

  @override
  _StaticControlsState createState() => _StaticControlsState();
}

class _StaticControlsState extends State<StaticControls> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Static Controls",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(children: [
            Row(
              children: [
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                        activeColor: Colors.green,
                        value: 0,
                        groupValue: widget._staticControls,
                        onChanged: (val) {
                          setState(() {
                            widget._staticControls = val;
                          });
                        }),
                    Text(
                      "Limit\nExtension",
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                        activeColor: Colors.green,
                        value: 1,
                        groupValue: widget._staticControls,
                        onChanged: (val) {
                          setState(() {
                            widget._staticControls = val;
                          });
                        }),
                    Text(
                      "Limit\nFlexion",
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
                        groupValue: widget._staticControls,
                        onChanged: (val) {
                          setState(() {
                            widget._staticControls = val;
                          });
                        }),
                    Text(
                      "Full\nStop",
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
              ],
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 250,
                  child: TextField(
                    decoration: InputDecoration(labelText: "Others"),
                  ),
                ),
              ],
            ),
          ])
        ]),
      ],
    );
  }
}

class AssistanceNeeded extends StatefulWidget {
  AssistanceNeeded({
    Key key,
    @required assistanceNeeded2,
  })  : _assistanceNeeded = assistanceNeeded2,
        super(key: key);

  var _assistanceNeeded;

  @override
  _AssistanceNeededState createState() => _AssistanceNeededState();
}

class _AssistanceNeededState extends State<AssistanceNeeded> {
  @override
  Widget build(BuildContext context) {
    return Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "Assistance Needed",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                      activeColor: Colors.green,
                      value: 0,
                      groupValue: widget._assistanceNeeded,
                      onChanged: (val) {
                        setState(() {
                          widget._assistanceNeeded = val;
                        });
                      }),
                  Text(
                    "Extension",
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
                      groupValue: widget._assistanceNeeded,
                      onChanged: (val) {
                        setState(() {
                          widget._assistanceNeeded = val;
                        });
                      }),
                  Text(
                    "Flexion",
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            ],
          )
        ]);
  }
}
