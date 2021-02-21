import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;
import 'package:project/screen/forms/FormType/orthotic.dart';
import 'package:project/screen/forms/orthotic%20Forms/Kafo/kfoaB.dart';

class KafoA extends StatefulWidget {
  static const routeName = '/KafoA';
  final username;
  KafoA(this.username);
  @override
  _KafoAState createState() => _KafoAState();
}

class _KafoAState extends State<KafoA> {
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
  bool anterior = false;
  bool exterior = false;

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
        builder: (ctx) => KafoB(bytelist: bytList, username: username)));

    // print(bs64);
  }

  @override
  Widget build(BuildContext context) {
    if (bytList.length > 0) {
      bytList.removeLast();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("KAFO"),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\nType of\n KAFO:",
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
                              Text("Drop\nLock")
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
                              Text("Offset")
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
                              Text(
                                "Automatic\nSpring Lever",
                                style: TextStyle(fontSize: 10),
                              )
                            ],
                          ),
                          Container(
                            width: 80,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: TextField(
                                  decoration:
                                      InputDecoration(hintText: "others"),
                                ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Type of KAFO material:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                              Container(
                                width: 100,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: TextField(
                                      decoration:
                                          InputDecoration(hintText: "others"),
                                    ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Divider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Type of Ankle Joint:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                                            Text("Oklahoma")
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
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(child: TextField())
                            ],
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Type of\nKAFO Design:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                            activeColor: Colors.blue,
                                            value: anterior,
                                            onChanged: (bool value) {
                                              setState(() {
                                                anterior = value;
                                              });
                                            }),
                                        Text(
                                            "Anterior calf shell +\nPosterior Thigh shell")
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                            activeColor: Colors.blue,
                                            value: exterior,
                                            onChanged: (bool value) {
                                              setState(() {
                                                exterior = value;
                                              });
                                            }),
                                        Text(
                                            "Posterior calf shell +\nAnterior Thigh shell")
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Strapping Type:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                              SizedBox(
                                width: 10,
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
                                      decoration:
                                          InputDecoration(hintText: "others"),
                                    ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
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
