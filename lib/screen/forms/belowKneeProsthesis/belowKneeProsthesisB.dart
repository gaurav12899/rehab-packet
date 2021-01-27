import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;
import 'package:project/screen/forms/belowKneeProsthesis/belowKneeProsthesisC.dart';

class BelowKneeProsthesisB extends StatefulWidget {
  static const routeName = '/belowKneeProsthesisB';

  @override
  _BelowKneeProsthesisBState createState() => _BelowKneeProsthesisBState();
}

class _BelowKneeProsthesisBState extends State<BelowKneeProsthesisB> {
  bool gelLiner = false;
  bool bullLock = false;
  bool kneeSleeve = false;
  bool eversion = false;
  bool thighCorset = false;
  bool sealInSuspension = false;
  bool suction = false;
  bool variablePressure = false;

  bool thirtyMm = false;
  bool thirtyFourMm = false;
  bool stainlessSteel = false;
  bool titanium = false;
  bool aluminium = false;
  bool fourProngAdaptor = false;
  bool threeProngAdoptor = false;
  bool fourHoleAdaptor = false;
  bool pyramid = false;
  bool receiver = false;

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

    if (args['bytelist'].length > 1) {
      args['bytelist'].removeLast();
    }
    await args['bytelist'].add(pngBytes);
    Navigator.of(context).pushNamed(BelowKneeProsthesisC.routeName, arguments: {
      "bytelist": args["bytelist"],
      "username": args["username"]
    });

    // print(bs64);
  }

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    print(args['bytelist'].length);

    // if (args['bytelist'].length > 1) {
    //   args['bytelist'].removeLast();
    // }

    // args.values.toList()
    return Scaffold(
      appBar: AppBar(
        title: Text("Below Knee Prosthesis"),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pop(context);
        //     if (args['bytelist'].length > 1) {
        //       args['bytelist'].removeLast();
        //     }
        //   },
        // ),
        actions: [
          IconButton(
              icon: Icon(Icons.navigate_next_rounded),
              onPressed: () {
                _printPngBytes(args);
              })
        ],
      ),
      body: SingleChildScrollView(
        child: RepaintBoundary(
          key: _containerKey,
          child: Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Type Of Suspension:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("Gel Liner with\nPin shuttle Lock"),
                            Checkbox(
                                activeColor: Colors.blue,
                                value: gelLiner,
                                onChanged: (bool value) {
                                  setState(() {
                                    gelLiner = value;
                                  });
                                }),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Bull Lock"),
                            Checkbox(
                                activeColor: Colors.blue,
                                value: bullLock,
                                onChanged: (bool value) {
                                  setState(() {
                                    bullLock = value;
                                  });
                                }),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("Knee Sleeve"),
                            Checkbox(
                                activeColor: Colors.blue,
                                value: kneeSleeve,
                                onChanged: (bool value) {
                                  setState(() {
                                    kneeSleeve = value;
                                  });
                                }),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Thigh Corser"),
                            Checkbox(
                                activeColor: Colors.blue,
                                value: thighCorset,
                                onChanged: (bool value) {
                                  setState(() {
                                    thighCorset = value;
                                  });
                                }),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("Seal In Suspension"),
                            Checkbox(
                                activeColor: Colors.blue,
                                value: sealInSuspension,
                                onChanged: (bool value) {
                                  setState(() {
                                    sealInSuspension = value;
                                  });
                                }),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Suction"),
                            Checkbox(
                                activeColor: Colors.blue,
                                value: suction,
                                onChanged: (bool value) {
                                  setState(() {
                                    suction = value;
                                  });
                                }),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Variable Pressure \n(Harmony / Limb logic)",
                    ),
                    Checkbox(
                        activeColor: Colors.blue,
                        value: variablePressure,
                        onChanged: (bool value) {
                          setState(() {
                            variablePressure = value;
                          });
                        }),
                  ],
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Other:"),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Component:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Pylon"),
                        Row(
                          children: [
                            Text("30mm"),
                            Checkbox(
                                activeColor: Colors.blue,
                                value: thirtyMm,
                                onChanged: (bool value) {
                                  setState(() {
                                    thirtyMm = value;
                                  });
                                }),
                          ],
                        ),
                        Row(
                          children: [
                            Text("34mm"),
                            Checkbox(
                                activeColor: Colors.blue,
                                value: thirtyFourMm,
                                onChanged: (bool value) {
                                  setState(() {
                                    thirtyFourMm = value;
                                  });
                                }),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("Stainless Steel"),
                            Checkbox(
                                activeColor: Colors.blue,
                                value: stainlessSteel,
                                onChanged: (bool value) {
                                  setState(() {
                                    stainlessSteel = value;
                                  });
                                }),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Titanium"),
                            Checkbox(
                                activeColor: Colors.blue,
                                value: titanium,
                                onChanged: (bool value) {
                                  setState(() {
                                    titanium = value;
                                  });
                                }),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Aluminium"),
                            Checkbox(
                                activeColor: Colors.blue,
                                value: aluminium,
                                onChanged: (bool value) {
                                  setState(() {
                                    aluminium = value;
                                  });
                                }),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  "Prosthetic Foot:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text("Foot Name:"),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: TextField())
                  ],
                ),
                Row(
                  children: [
                    Text("Part Code:"),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: TextField())
                  ],
                ),
                Row(
                  children: [
                    Text("Tubeclamp Adaptor Part Code:"),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: TextField())
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("Four Prong Adoptor"),
                        Checkbox(
                            activeColor: Colors.blue,
                            value: fourProngAdaptor,
                            onChanged: (bool value) {
                              setState(() {
                                fourProngAdaptor = value;
                              });
                            }),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Four Prong Adoptor"),
                        Checkbox(
                            activeColor: Colors.blue,
                            value: threeProngAdoptor,
                            onChanged: (bool value) {
                              setState(() {
                                threeProngAdoptor = value;
                              });
                            }),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("Four Hole Adoptor"),
                        Checkbox(
                            activeColor: Colors.blue,
                            value: fourHoleAdaptor,
                            onChanged: (bool value) {
                              setState(() {
                                fourHoleAdaptor = value;
                              });
                            }),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("Pyramid"),
                        Checkbox(
                            activeColor: Colors.blue,
                            value: pyramid,
                            onChanged: (bool value) {
                              setState(() {
                                pyramid = value;
                              });
                            }),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Receiver"),
                        Checkbox(
                            activeColor: Colors.blue,
                            value: receiver,
                            onChanged: (bool value) {
                              setState(() {
                                receiver = value;
                              });
                            }),
                      ],
                    ),
                  ],
                ),
                Text(
                  "Other Information that may affect prosthetic fitting:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextField(
                  maxLines: 3,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
