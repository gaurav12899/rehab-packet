import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;
import 'package:project/screen/forms/FormType/prosthetic.dart';
import 'package:project/screen/forms/prostheticForms/aboveElbowProsthesis/aboveElbowProsthesisB.dart';

class AboveElbowProsthesis extends StatefulWidget {
  static const routeName = '/aboveElbowProsthesis';
  final username;
  AboveElbowProsthesis(this.username);

  @override
  _AboveElbowProsthesisState createState() => _AboveElbowProsthesisState();
}

class _AboveElbowProsthesisState extends State<AboveElbowProsthesis> {
  GlobalKey _containerKey = GlobalKey();

  var _side;
  var _stumpLength;
  var _distalEndType;
  var _stumpType;

  final doc = pw.Document();
  List bytList = [];
  _capturePng() async {
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
            AboveElbowProsthesisB(bytelist: bytList, username: username)));
    // print(bs64);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Above Elbow Prosthesis"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "PROSTHETIC COMPONENTS",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Divider(),
                      Row(
                        children: [
                          Text(
                            "Socket Type:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: TextField())
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Elbow Unit Type :",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: TextField())
                        ],
                      ),
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

    // );
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
              "Bilateral",
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
                  "Cylindrical",
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
                  "Bulbous",
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
            "Stump Muscle Type",
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
