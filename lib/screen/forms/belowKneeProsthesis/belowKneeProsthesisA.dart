import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;
import 'package:project/screen/forms/belowKneeProsthesis/belowKneeProsthesisB.dart';

class BelowKneeProsthesisA extends StatefulWidget {
  static const routeName = '/belowKneeProsthesisA';

  @override
  _BelowKneeProsthesisAState createState() => _BelowKneeProsthesisAState();
}

class _BelowKneeProsthesisAState extends State<BelowKneeProsthesisA> {
  bool left = false;
  bool right = false;
  bool competitive = false;
  bool trialsocket = false;
  bool finalsocket = false;
  bool initialSocketLamination = false;
  bool finalSocketLamination = false;
  bool socketWithSoftInner = false;
  bool softInsertWithBuildup = false;
  bool siliconSocketWithCarbonFrame = false;
  bool socketWithPadelineLiner = false;

  final doc = pw.Document();

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
    print(pngBytes);
    bytList.add(pngBytes);
    print(bytList);
    print("bbk$username");
    Navigator.of(context).pushNamed(BelowKneeProsthesisB.routeName,
        arguments: {"bytelist": bytList, "username": username});

    // print(bs64);
  }

  @override
  Widget build(BuildContext context) {
    final String username = ModalRoute.of(context).settings.arguments;
    if (bytList.length > 0) {
      bytList.removeLast();
    }

    print("afoA$username");
    return Scaffold(
      appBar: AppBar(
        title: Text("Below Knee Prosthesis"),
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
                  // color: Colors.blue.shade50,
                  // height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Patient Registration No:",
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "side of\nAmuputation",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Checkbox(
                                        activeColor: Colors.blue,
                                        value: left,
                                        onChanged: (bool value) {
                                          setState(() {
                                            left = value;
                                          });
                                        }),
                                    Text("Left")
                                  ],
                                ),
                                Column(
                                  children: [
                                    Checkbox(
                                        activeColor: Colors.blue,
                                        value: right,
                                        onChanged: (bool value) {
                                          setState(() {
                                            right = value;
                                          });
                                        }),
                                    Text("Right")
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Socket Information:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Checkbox(
                                        activeColor: Colors.blue,
                                        value: trialsocket,
                                        onChanged: (bool value) {
                                          setState(() {
                                            trialsocket = value;
                                          });
                                        }),
                                    Text("Trial Socket")
                                  ],
                                ),
                                Column(
                                  children: [
                                    Checkbox(
                                        activeColor: Colors.blue,
                                        value: finalsocket,
                                        onChanged: (bool value) {
                                          setState(() {
                                            finalsocket = value;
                                          });
                                        }),
                                    Text("Final Socket")
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\nStump Details:",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("\nResidual limb\nflexion angle"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(child: TextField())
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Foot Sixe"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(child: TextField())
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Shoe Size"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(child: TextField())
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Heel Height"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(child: TextField())
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Socket Fabrication:",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text("Trial Socket"),
                              Checkbox(
                                  activeColor: Colors.blue,
                                  value: trialsocket,
                                  onChanged: (bool value) {
                                    setState(() {
                                      trialsocket = value;
                                    });
                                  }),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text("Initial Socket\nLamination"),
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: initialSocketLamination,
                                      onChanged: (bool value) {
                                        setState(() {
                                          initialSocketLamination = value;
                                        });
                                      }),
                                ],
                              ),
                              Text("Finish Socket\nLamination"),
                              Checkbox(
                                  activeColor: Colors.blue,
                                  value: finalSocketLamination,
                                  onChanged: (bool value) {
                                    setState(() {
                                      finalSocketLamination = value;
                                    });
                                  }),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text("Socket With\n Soft Inner"),
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: socketWithSoftInner,
                                      onChanged: (bool value) {
                                        setState(() {
                                          socketWithSoftInner = value;
                                        });
                                      }),
                                ],
                              ),
                              Text("Soft Insert\n with Buildup"),
                              Checkbox(
                                  activeColor: Colors.blue,
                                  value: softInsertWithBuildup,
                                  onChanged: (bool value) {
                                    setState(() {
                                      softInsertWithBuildup = value;
                                    });
                                  }),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text("Silicon Socket\nwith Carbon Frame"),
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: siliconSocketWithCarbonFrame,
                                      onChanged: (bool value) {
                                        setState(() {
                                          siliconSocketWithCarbonFrame = value;
                                        });
                                      }),
                                ],
                              ),
                              Text("Socket with\nPadeline Liner"),
                              Checkbox(
                                  activeColor: Colors.blue,
                                  value: socketWithPadelineLiner,
                                  onChanged: (bool value) {
                                    setState(() {
                                      socketWithPadelineLiner = value;
                                    });
                                  }),
                            ],
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Other",
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
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
    );
  }
}
