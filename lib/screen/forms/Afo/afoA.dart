import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/screen/forms/Afo/afoB.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

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

  // final doc = pw.Document();

  bool loading = false;
  GlobalKey _containerKey = GlobalKey();
  List bytList = [];
  Future<Uint8List> _capturePng() async {
    RenderRepaintBoundary boundary =
        _containerKey.currentContext.findRenderObject();

    if (boundary.debugNeedsPaint) {
      await Future.delayed(const Duration(milliseconds: 20));
      return _capturePng();
    }

    var image = await boundary.toImage();
    var byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData.buffer.asUint8List();
  }

  void _printPngBytes(String username) async {
    var pngBytes = await _capturePng();
    if (bytList.length > 1) {
      bytList.removeLast();
    }
    bytList.add(pngBytes);
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (ctx) => AfoB(
                bytelist: bytList,
                username: username,
              )),
    );
    // Navigator.of(context).pushNamed(AfoB.routeName,
    //     arguments: {"bytelist": bytList, "username": username});
  }

  @override
  Widget build(BuildContext context) {
    final String username = ModalRoute.of(context).settings.arguments;
    if (bytList.length > 0) {
      bytList.removeLast();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("AFO"),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Diagnosis:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                              child: TextField(
                            decoration: InputDecoration(
                                isDense: true, border: OutlineInputBorder()),
                            maxLines: 2,
                            textAlignVertical: TextAlignVertical.top,
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Prescription:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: TextField(
                            decoration: InputDecoration(
                                isDense: true, border: OutlineInputBorder()),
                            maxLines: 2,
                          ))
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
                              Text("Everyday\nuse")
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
                              Text("Night\ntime")
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
                              Text("competitive\nsports")
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
                                  decoration: InputDecoration(
                                      hintText: "others", isDense: true),
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
                                  decoration: InputDecoration(
                                      hintText: "others", isDense: true),
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
                                  decoration: InputDecoration(
                                      hintText: "others", isDense: true),
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
                                  decoration: InputDecoration(
                                      hintText: "others", isDense: true),
                                ))
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
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
                            Expanded(
                                child: TextField(
                              decoration: InputDecoration(isDense: true),
                            )),
                            Expanded(
                                child: TextField(
                              decoration: InputDecoration(isDense: true),
                            )),
                            Expanded(
                                child: TextField(
                              decoration: InputDecoration(isDense: true),
                            )),
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
            ],
          ),
        ),
      ),
    );
  }
}
