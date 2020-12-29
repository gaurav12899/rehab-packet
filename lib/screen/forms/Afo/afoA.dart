import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/screen/forms/Afo/afoB.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
// import 'package:image_pixels/image_pixels.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;

class AfoA extends StatefulWidget {
  static const routeName = '/AfoA';

  @override
  _AfoAState createState() => _AfoAState();
}

class _AfoAState extends State<AfoA> {
  bool everyday = false;
  bool night = false;
  bool competitive = false;
  bool _static = false;
  bool _dynamic = false;
  bool _pls = false;

  bool pp = false;
  bool copp = false;
  bool carbon = false;
  bool overlap = false;
  bool tamarack = false;
  bool oklohama = false;
  bool camberaxis = false;
  bool hookloop = false;
  bool strapping = false;
  final doc = pw.Document();

  bool loading = false;
  GlobalKey _containerKey = GlobalKey();
  List bytList = [];
  Future<Uint8List> _capturePng() async {
    print("---------->1");
    RenderRepaintBoundary boundary =
        _containerKey.currentContext.findRenderObject();
    print("---------->2");

    if (boundary.debugNeedsPaint) {
      print("Waiting for boundary to be painted.");
      await Future.delayed(const Duration(milliseconds: 20));
      return _capturePng();
    }

    var image = await boundary.toImage();
    var byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData.buffer.asUint8List();
  }

  void _printPngBytes() async {
    var pngBytes = await _capturePng();
    // var bs64 = base64Encode(pngBytes);
    print(pngBytes);
    bytList.add(pngBytes);
    print(bytList);
    Navigator.of(context).pushNamed(AfoB.routeName, arguments: bytList);

    // print(bs64);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AFO"),
        actions: [
          IconButton(
              icon: Icon(Icons.navigate_next_rounded),
              onPressed: () {
                _printPngBytes();
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
                // color: Colors.blue.shade50,
                // height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                        Expanded(child: TextField())
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Worn for:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Column(
                          children: [
                            Checkbox(
                                activeColor: Colors.blue,
                                value: everyday,
                                onChanged: (bool value) {
                                  setState(() {
                                    everyday = value;
                                  });
                                }),
                            Text("Everyday use")
                          ],
                        ),
                        Column(
                          children: [
                            Checkbox(
                                activeColor: Colors.blue,
                                value: night,
                                onChanged: (bool value) {
                                  setState(() {
                                    night = value;
                                  });
                                }),
                            Text("Night time")
                          ],
                        ),
                        Column(
                          children: [
                            Checkbox(
                                activeColor: Colors.blue,
                                value: competitive,
                                onChanged: (bool value) {
                                  setState(() {
                                    competitive = value;
                                  });
                                }),
                            Text("competitive sports")
                          ],
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Type of AFO:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Column(
                          children: [
                            Checkbox(
                                activeColor: Colors.blue,
                                value: _static,
                                onChanged: (bool value) {
                                  setState(() {
                                    _static = value;
                                  });
                                }),
                            Text("Static")
                          ],
                        ),
                        Column(
                          children: [
                            Checkbox(
                                activeColor: Colors.blue,
                                value: _dynamic,
                                onChanged: (bool value) {
                                  setState(() {
                                    _dynamic = value;
                                  });
                                }),
                            Text("Dynamic")
                          ],
                        ),
                        Column(
                          children: [
                            Checkbox(
                                activeColor: Colors.blue,
                                value: _pls,
                                onChanged: (bool value) {
                                  setState(() {
                                    _pls = value;
                                  });
                                }),
                            Text("PLS")
                          ],
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: TextField(
                                decoration: InputDecoration(hintText: "others"),
                              ))
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
                          "Type of AFO material:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Column(
                          children: [
                            Checkbox(
                                activeColor: Colors.blue,
                                value: pp,
                                onChanged: (bool value) {
                                  setState(() {
                                    pp = value;
                                  });
                                }),
                            Text("PP")
                          ],
                        ),
                        Column(
                          children: [
                            Checkbox(
                                activeColor: Colors.blue,
                                value: copp,
                                onChanged: (bool value) {
                                  setState(() {
                                    copp = value;
                                  });
                                }),
                            Text("COPP")
                          ],
                        ),
                        Column(
                          children: [
                            Checkbox(
                                activeColor: Colors.blue,
                                value: carbon,
                                onChanged: (bool value) {
                                  setState(() {
                                    carbon = value;
                                  });
                                }),
                            Text("Carbon Fiber")
                          ],
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: TextField(
                                decoration: InputDecoration(hintText: "others"),
                              ))
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
                          "Type of Ankle Joint:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Checkbox(
                                          activeColor: Colors.blue,
                                          value: overlap,
                                          onChanged: (bool value) {
                                            setState(() {
                                              overlap = value;
                                            });
                                          }),
                                      Text("Overlap")
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Checkbox(
                                          activeColor: Colors.blue,
                                          value: tamarack,
                                          onChanged: (bool value) {
                                            setState(() {
                                              tamarack = value;
                                            });
                                          }),
                                      Text("Tamatack")
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Checkbox(
                                          activeColor: Colors.blue,
                                          value: oklohama,
                                          onChanged: (bool value) {
                                            setState(() {
                                              oklohama = value;
                                            });
                                          }),
                                      Text("Okhalama")
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Checkbox(
                                activeColor: Colors.blue,
                                value: camberaxis,
                                onChanged: (bool value) {
                                  setState(() {
                                    camberaxis = value;
                                  });
                                }),
                            Text("Camberaxis")
                          ],
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: TextField(
                                decoration: InputDecoration(hintText: "others"),
                              ))
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
                          "Strapping Type:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Column(
                          children: [
                            Checkbox(
                                activeColor: Colors.blue,
                                value: hookloop,
                                onChanged: (bool value) {
                                  setState(() {
                                    hookloop = value;
                                  });
                                }),
                            Text("Hook &\nLoop")
                          ],
                        ),
                        Column(
                          children: [
                            Checkbox(
                                activeColor: Colors.blue,
                                value: strapping,
                                onChanged: (bool value) {
                                  setState(() {
                                    strapping = value;
                                  });
                                }),
                            Text("Dynamic \nStraping")
                          ],
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: TextField(
                                decoration: InputDecoration(hintText: "others"),
                              ))
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 150,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Other Modification:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: TextField()),
                          Expanded(child: TextField()),
                          Expanded(child: TextField()),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //   width: 200,
            //   color: Colors.blue,
            //   child: FlatButton(
            //     onPressed: () {
            //       _printPngBytes();
            //       // Navigator.of(context).pushNamed(AfoB.routeName);
            //     },
            //     child: Text(
            //       "Next",
            //       style: TextStyle(color: Colors.white, fontSize: 20),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
