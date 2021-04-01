import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;
import 'package:project/screen/forms/orthotic%20Forms/HKAFO/hkafoB.dart';
import 'package:project/screen/forms/orthotic%20Forms/kneeOrthosis/kneeOrthosisB.dart';

class KneeOrthosisA extends StatefulWidget {
  static const routeName = '/KneeOrthosis';
  final username;
  KneeOrthosisA(this.username);

  @override
  _KneeOrthosisAState createState() => _KneeOrthosisAState();
}

class _KneeOrthosisAState extends State<KneeOrthosisA> {
  bool everyday = false;
  bool night = false;
  bool competitive = false;
  bool _right = false;
  bool _left = false;
  bool _bilateral = false;

  bool _literal = false;
  bool _medial = false;
  bool _both = false;

  bool _varus = false;
  bool _valgus = false;
  bool _hyperextension = false;
  bool _postSurgical = false;
  bool _flexion = false;

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
        builder: (ctx) =>
            KneeOrthosisB(bytelist: bytList, username: username)));

    // print(bs64);
  }

  @override
  Widget build(BuildContext context) {
    if (bytList.length > 0) {
      bytList.removeLast();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Knee Orthosis"),
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
                        children: [
                          Text(
                            "Patient Registration No. :",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                              child: TextField(
                            keyboardType: TextInputType.number,
                          ))
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Diagnosis :",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: TextField())
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Prescription :",
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
                              Text("Special\nActivity")
                            ],
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Affected Extremity:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Column(
                            children: [
                              Checkbox(
                                  activeColor: Colors.blue,
                                  value: _right,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _right = value;
                                    });
                                  }),
                              Text("Right")
                            ],
                          ),
                          Column(
                            children: [
                              Checkbox(
                                  activeColor: Colors.blue,
                                  value: _left,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _left = value;
                                    });
                                  }),
                              Text("Left")
                            ],
                          ),
                          Column(
                            children: [
                              Checkbox(
                                  activeColor: Colors.blue,
                                  value: _bilateral,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _bilateral = value;
                                    });
                                  }),
                              Text("Bilateral")
                            ],
                          ),
                        ],
                      ),
                      Divider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\nAffected Side:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: _literal,
                                      onChanged: (bool value) {
                                        setState(() {
                                          _literal = value;
                                        });
                                      }),
                                  Text("Lateral")
                                ],
                              ),
                              Column(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: _medial,
                                      onChanged: (bool value) {
                                        setState(() {
                                          _medial = value;
                                        });
                                      }),
                                  Text("Medial")
                                ],
                              ),
                              Column(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: _both,
                                      onChanged: (bool value) {
                                        setState(() {
                                          _both = value;
                                        });
                                      }),
                                  Text("Both")
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Knee Condition:",
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
                                      value: _varus,
                                      onChanged: (bool value) {
                                        setState(() {
                                          _varus = value;
                                        });
                                      }),
                                  Text("Varus")
                                ],
                              ),
                              Column(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: _valgus,
                                      onChanged: (bool value) {
                                        setState(() {
                                          _valgus = value;
                                        });
                                      }),
                                  Text("Valgus")
                                ],
                              ),
                              Column(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: _hyperextension,
                                      onChanged: (bool value) {
                                        setState(() {
                                          _hyperextension = value;
                                        });
                                      }),
                                  Text("Hyperextension")
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: _flexion,
                                      onChanged: (bool value) {
                                        setState(() {
                                          _flexion = value;
                                        });
                                      }),
                                  Text("Flexion")
                                ],
                              ),
                              Column(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: _postSurgical,
                                      onChanged: (bool value) {
                                        setState(() {
                                          _postSurgical = value;
                                        });
                                      }),
                                  Text("Post Surgical")
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      width: 100,
                                      child: TextField(
                                        decoration:
                                            InputDecoration(hintText: "others"),
                                      ))
                                ],
                              )
                            ],
                          )
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
  }
}
