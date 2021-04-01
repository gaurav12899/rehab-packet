import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;
import 'package:project/screen/forms/Cosmetic%20Forms/cosmeticRestorationFingers/cosmeticRestFingersB.dart';
import 'package:project/screen/forms/orthotic%20Forms/FootOrthosisForm/footOrthosisB.dart';

class FootOrthosisA extends StatefulWidget {
  static const routeName = '/cosmeticRestorationFingersA';
  final username;
  FootOrthosisA(this.username);

  @override
  _FootOrthosisAState createState() => _FootOrthosisAState();
}

class _FootOrthosisAState extends State<FootOrthosisA> {
  GlobalKey _containerKey = GlobalKey();

  var _type;
  bool everyday = false;
  bool night = false;
  bool competitive = false;

  bool diabeticShoes = false;
  bool customisedInholes = false;
  bool ucbl = false;
  bool smo = false;

  bool eva = false;
  bool mcr = false;
  bool plastazote = false;
  bool plastic = false;
  bool silicon = false;

  bool arcSupportL = false;
  bool metatarsalPadL = false;
  bool metatarsalBarL = false;
  bool heelPadL = false;
  bool heelWedgeL = false;
  bool toeFIllerL = false;
  bool mortonExtensionL = false;

  final doc = pw.Document();
  List bytList = [];
  Future<Uint8List> _capturePng() async {
    RenderRepaintBoundary boundary =
        _containerKey.currentContext.findRenderObject();

    ui.Image image;
    bool catched = false;
    try {
      image = await boundary.toImage(pixelRatio: 1.5);
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
            FootOrthosisB(bytelist: bytList, username: username)));

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
            // (
            //     MaterialPageRoute(builder: (_) => Cosmetic(widget.username)));
          },
        ),
        title: Text("Foot Orthosis"),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          Container(
                              width: 100,
                              child: TextField(
                                decoration: InputDecoration(hintText: "Other"),
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Shoe Size :",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: TextField())
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Shoe Type :",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: TextField())
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Orthosis Type (S):",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.center
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: diabeticShoes,
                                      onChanged: (bool value) {
                                        setState(() {
                                          diabeticShoes = value;
                                        });
                                      }),
                                  Text("Diabetic\nshoes")
                                ],
                              ),
                              Column(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: customisedInholes,
                                      onChanged: (bool value) {
                                        setState(() {
                                          customisedInholes = value;
                                        });
                                      }),
                                  Text("Customised\ninsoles")
                                ],
                              ),
                              Column(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: ucbl,
                                      onChanged: (bool value) {
                                        setState(() {
                                          ucbl = value;
                                        });
                                      }),
                                  Text("UCBL")
                                ],
                              ),
                              Column(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: smo,
                                      onChanged: (bool value) {
                                        setState(() {
                                          smo = value;
                                        });
                                      }),
                                  Text("SMO"),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Orthosis Material:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.center
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: eva,
                                      onChanged: (bool value) {
                                        setState(() {
                                          eva = value;
                                        });
                                      }),
                                  Text("EVA")
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: mcr,
                                      onChanged: (bool value) {
                                        setState(() {
                                          mcr = value;
                                        });
                                      }),
                                  Text("MCR")
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: plastazote,
                                      onChanged: (bool value) {
                                        setState(() {
                                          plastazote = value;
                                        });
                                      }),
                                  Text("Plastazote")
                                ],
                              ),
                            ],
                          ),
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.center
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: plastic,
                                      onChanged: (bool value) {
                                        setState(() {
                                          plastic = value;
                                        });
                                      }),
                                  Text("Plastic")
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: silicon,
                                      onChanged: (bool value) {
                                        setState(() {
                                          silicon = value;
                                        });
                                      }),
                                  Text("Silicon")
                                ],
                              ),
                              Container(
                                width: 100,
                                child: TextField(
                                  decoration:
                                      InputDecoration(hintText: "Other"),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Modification (L):",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.center
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: arcSupportL,
                                      onChanged: (bool value) {
                                        setState(() {
                                          arcSupportL = value;
                                        });
                                      }),
                                  Text("Arch\nSupport")
                                ],
                              ),
                              Column(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: metatarsalPadL,
                                      onChanged: (bool value) {
                                        setState(() {
                                          metatarsalPadL = value;
                                        });
                                      }),
                                  Text("Metatarsal\nPad")
                                ],
                              ),
                              Column(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: metatarsalBarL,
                                      onChanged: (bool value) {
                                        setState(() {
                                          metatarsalBarL = value;
                                        });
                                      }),
                                  Text("Metatarsal\nBar")
                                ],
                              ),
                              Column(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: heelPadL,
                                      onChanged: (bool value) {
                                        setState(() {
                                          heelPadL = value;
                                        });
                                      }),
                                  Text("Heel\nPad")
                                ],
                              ),
                            ],
                          ),
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.center
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: heelWedgeL,
                                      onChanged: (bool value) {
                                        setState(() {
                                          heelWedgeL = value;
                                        });
                                      }),
                                  Text("Heel\nWedge")
                                ],
                              ),
                              Column(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: toeFIllerL,
                                      onChanged: (bool value) {
                                        setState(() {
                                          toeFIllerL = value;
                                        });
                                      }),
                                  Text("Toe\nFiller")
                                ],
                              ),
                              Column(
                                children: [
                                  Checkbox(
                                      activeColor: Colors.blue,
                                      value: mortonExtensionL,
                                      onChanged: (bool value) {
                                        setState(() {
                                          mortonExtensionL = value;
                                        });
                                      }),
                                  Text("Morton's\nExtension")
                                ],
                              ),
                              Container(
                                width: 100,
                                child: TextField(
                                  decoration:
                                      InputDecoration(hintText: "Other"),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 100,
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
