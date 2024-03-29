import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;
import 'package:project/screen/forms/FormType/orthotic.dart';
import 'package:project/screen/forms/orthotic%20Forms/wristHandOrthosis/wristHandOrthosisB.dart';

class WristHandOrthosisA extends StatefulWidget {
  static const routeName = '/wristHandOrthosisA';
  final username;
  WristHandOrthosisA(this.username);

  @override
  _WristHandOrthosisAState createState() => _WristHandOrthosisAState();
}

class _WristHandOrthosisAState extends State<WristHandOrthosisA> {
  bool _bloodCondition = false;
  bool _side = false;
  bool _material = false;
  bool _whoType = false;
  bool _coverType = false;
  bool _wristJoint = false;
  bool _mcp = false;
  bool _ipJoint = false;
  bool _wristJointAssistance = false;
  bool _mcpAssistance = false;
  bool _ipJointAssistance = false;

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
      image = await boundary.toImage(pixelRatio:1.0);
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
            WristHandOrthosisB(bytelist: bytList, username: username)));

    // print(bs64);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wrist Hand Orthosis"),
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
                      SideOfAmputation(side2: _side),
                      Material(material2: _material),
                      BloodCondition(bloodCondition2: _bloodCondition),
                      WHOType(whoType2: _whoType),
                      CoverType(coverType2: _coverType),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              "Splinting Position Of Joints",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          Text(
                            "Wrist Joint",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          JointPositions(jointPositions2: _wristJoint),
                          Text(
                            "MCP",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          JointPositions(jointPositions2: _mcp),
                          Text(
                            "IP Joint",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          JointPositions(jointPositions2: _ipJoint),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              "Assistance Needed to Joints",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  "Wrist Joint",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                AssistanceNeeded(
                                    assistanceNeeded2: _wristJointAssistance)
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "MCP",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          AssistanceNeeded(assistanceNeeded2: _mcpAssistance)
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "IP Joint",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          AssistanceNeeded(
                              assistanceNeeded2: _ipJointAssistance)
                        ],
                      )
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

class Material extends StatefulWidget {
  Material({
    Key key,
    @required material2,
  })  : _material = material2,
        super(key: key);

  var _material;

  @override
  _MaterialState createState() => _MaterialState();
}

class _MaterialState extends State<Material> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "MATERIAL",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: RadioListTile(
                    title: Text(
                      "Low Temp\nThermoPlastic",
                      style: TextStyle(fontSize: 11),
                    ),
                    activeColor: Colors.green,
                    dense: true,
                    value: 0,
                    groupValue: widget._material,
                    onChanged: (val) {
                      setState(() {
                        widget._material = val;
                      });
                    }),
              ),
              Expanded(
                child: RadioListTile(
                    title: Text(
                      "High Temp\nThermoPlastic",
                      style: TextStyle(fontSize: 11),
                    ),
                    activeColor: Colors.green,
                    dense: true,
                    value: 1,
                    groupValue: widget._material,
                    onChanged: (val) {
                      setState(() {
                        widget._material = val;
                      });
                    }),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 15,
              ),
              Row(
                children: [
                  Radio(
                      activeColor: Colors.green,
                      value: 4,
                      groupValue: widget._material,
                      onChanged: (val) {
                        setState(() {
                          widget._material = val;
                        });
                      }),
                  if (widget._material != 4)
                    Text(
                      "Others",
                      textAlign: TextAlign.justify,
                    )
                ],
              ),
              if (widget._material == 4)
                Container(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(hintText: "Others"),
                  ),
                ),
            ],
          ),
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
                "Blood \nCondition",
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              "Affected Side ",
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
                  "Bilateral",
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ]),
        ]);
  }
}

class WHOType extends StatefulWidget {
  WHOType({
    Key key,
    @required whoType2,
  })  : _whoType = whoType2,
        super(key: key);

  var _whoType;

  @override
  _WHOTypeState createState() => _WHOTypeState();
}

class _WHOTypeState extends State<WHOType> {
  @override
  Widget build(BuildContext context) {
    return Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Type\nof Who",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Radio(
                  // title: Text("Flexible"),
                  activeColor: Colors.green,
                  value: 0,
                  groupValue: widget._whoType,
                  onChanged: (val) {
                    setState(() {
                      widget._whoType = val;
                    });
                  }),
              Text("Dynamic")
            ],
          ),
          Row(
            children: [
              Radio(
                  activeColor: Colors.green,
                  value: 1,
                  groupValue: widget._whoType,
                  onChanged: (val) {
                    setState(() {
                      widget._whoType = val;
                    });
                  }),
              Text("Static")
            ],
          ),
        ]);
  }
}

class CoverType extends StatefulWidget {
  CoverType({
    Key key,
    @required coverType2,
  })  : _coverType = coverType2,
        super(key: key);

  var _coverType;

  @override
  _CoverTypeState createState() => _CoverTypeState();
}

class _CoverTypeState extends State<CoverType> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Side To Cover",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(children: [
          Row(
            children: [
              Radio(
                  // title: Text("Flexible"),
                  activeColor: Colors.green,
                  value: 0,
                  groupValue: widget._coverType,
                  onChanged: (val) {
                    setState(() {
                      widget._coverType = val;
                    });
                  }),
              Text("Palmar\nPocket")
            ],
          ),
          Row(
            children: [
              Radio(
                  activeColor: Colors.green,
                  value: 1,
                  groupValue: widget._coverType,
                  onChanged: (val) {
                    setState(() {
                      widget._coverType = val;
                    });
                  }),
              Text("Dorsal\nPocket")
            ],
          ),
          Row(
            children: [
              Radio(
                  activeColor: Colors.green,
                  value: 2,
                  groupValue: widget._coverType,
                  onChanged: (val) {
                    setState(() {
                      widget._coverType = val;
                    });
                  }),
              Text("Ulnar\nPocket")
            ],
          )
        ]),
      ],
    );
  }
}

class JointPositions extends StatefulWidget {
  JointPositions({
    Key key,
    @required jointPositions2,
  })  : _jointPositions = jointPositions2,
        super(key: key);

  var _jointPositions;

  @override
  _JointPositionsState createState() => _JointPositionsState();
}

class _JointPositionsState extends State<JointPositions> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Row(
        children: [
          Radio(
              // title: Text("Flexible"),
              activeColor: Colors.green,
              value: 0,
              groupValue: widget._jointPositions,
              onChanged: (val) {
                setState(() {
                  widget._jointPositions = val;
                });
              }),
          Text("Flexion")
        ],
      ),
      Row(
        children: [
          Radio(
              // title: Text("Flexible"),
              activeColor: Colors.green,
              value: 1,
              groupValue: widget._jointPositions,
              onChanged: (val) {
                setState(() {
                  widget._jointPositions = val;
                });
              }),
          Text("Extension")
        ],
      ),
      Row(
        children: [
          Radio(
              // title: Text("Flexible"),
              activeColor: Colors.green,
              value: 2,
              groupValue: widget._jointPositions,
              onChanged: (val) {
                setState(() {
                  widget._jointPositions = val;
                });
              }),
          Text("Neutral")
        ],
      ),
    ]);
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
    return Row(children: [
      Row(
        children: [
          Radio(
              // title: Text("Flexible"),
              activeColor: Colors.green,
              value: 0,
              groupValue: widget._assistanceNeeded,
              onChanged: (val) {
                setState(() {
                  widget._assistanceNeeded = val;
                });
              }),
          Text("Flexion")
        ],
      ),
      Row(
        children: [
          Radio(
              // title: Text("Flexible"),
              activeColor: Colors.green,
              value: 1,
              groupValue: widget._assistanceNeeded,
              onChanged: (val) {
                setState(() {
                  widget._assistanceNeeded = val;
                });
              }),
          Text("Extension")
        ],
      ),
    ]);
  }
}
