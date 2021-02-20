import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;
import 'package:project/screen/forms/prostheticForms/aboveElbowProsthesis/aboveElbowProsthesisC.dart';

class AboveElbowProsthesisB extends StatefulWidget {
  static const routeName = '/aboveElbowProsthesisB';

  var bytelist;
  var username;
  AboveElbowProsthesisB({@required this.bytelist, @required this.username});
  @override
  _AboveElbowProsthesisBState createState() => _AboveElbowProsthesisBState();
}

class _AboveElbowProsthesisBState extends State<AboveElbowProsthesisB> {
  GlobalKey _containerKey = GlobalKey();

  final doc = pw.Document();

  bool loading = false;

  _capturePng() async {
    RenderRepaintBoundary boundary =
        _containerKey.currentContext.findRenderObject();

    ui.Image image;
    bool catched = false;
    try {
      image = await boundary.toImage(pixelRatio: 3.0);
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
    if (widget.bytelist.length > 1) {
      widget.bytelist.removeLast();
    }
    widget.bytelist.add(pngBytes);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => AboveElbowProsthesisC(
            bytelist: widget.bytelist, username: username)));

    // print(bs64);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Above Elbow Prosthesis"),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RepaintBoundary(
                key: _containerKey,
                child: Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(border: Border.all(width: 2)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ControlSystemType(),
                      Divider(),
                      SuspensionType(),
                      Divider(),
                      Text("NOTE",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Container(
                        height: 100,
                        child: TextField(
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                          maxLines: 3,
                        ),
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

class SuspensionType extends StatefulWidget {
  @override
  _SuspensionTypeState createState() => _SuspensionTypeState();
}

class _SuspensionTypeState extends State<SuspensionType> {
  var _suspensionType;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "\nSuspension\nType:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                        activeColor: Colors.green,
                        value: 0,
                        groupValue: _suspensionType,
                        onChanged: (val) {
                          setState(() {
                            _suspensionType = val;
                          });
                        }),
                    Text(
                      "Self\nSuspending",
                      // textAlign: TextAlign.justify,
                    )
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        activeColor: Colors.green,
                        value: 1,
                        groupValue: _suspensionType,
                        onChanged: (val) {
                          setState(() {
                            _suspensionType = val;
                          });
                        }),
                    Text(
                      "Locking\nLiner",
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Radio(
                        activeColor: Colors.green,
                        value: 2,
                        groupValue: _suspensionType,
                        onChanged: (val) {
                          setState(() {
                            _suspensionType = val;
                          });
                        }),
                    Text(
                      "Suction",
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        activeColor: Colors.green,
                        value: 3,
                        groupValue: _suspensionType,
                        onChanged: (val) {
                          setState(() {
                            _suspensionType = val;
                          });
                        }),
                    Text(
                      "Harnessing",
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio(
                        activeColor: Colors.green,
                        value: 4,
                        groupValue: _suspensionType,
                        onChanged: (val) {
                          setState(() {
                            _suspensionType = val;
                          });
                        }),
                    if (_suspensionType != 4)
                      Text(
                        "Others",
                        textAlign: TextAlign.justify,
                      )
                  ],
                ),
                if (_suspensionType == 4)
                  Container(
                    width: 200,
                    child: TextField(
                      decoration: InputDecoration(hintText: "Others"),
                    ),
                  ),
              ],
            )
          ],
        ),
      ],
    );
  }
}

class ControlSystemType extends StatefulWidget {
  @override
  _ControlSystemTypeState createState() => _ControlSystemTypeState();
}

class _ControlSystemTypeState extends State<ControlSystemType> {
  var _controlSystemType;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "\nControl\nSystem Type",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                        activeColor: Colors.green,
                        value: 0,
                        groupValue: _controlSystemType,
                        onChanged: (val) {
                          setState(() {
                            _controlSystemType = val;
                          });
                        }),
                    Text(
                      "Body\nPowered",
                      // textAlign: TextAlign.justify,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                            activeColor: Colors.green,
                            value: 2,
                            groupValue: _controlSystemType,
                            onChanged: (val) {
                              setState(() {
                                _controlSystemType = val;
                              });
                            }),
                        Text(
                          "Externally\nPowered",
                          textAlign: TextAlign.justify,
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                        activeColor: Colors.green,
                        value: 3,
                        groupValue: _controlSystemType,
                        onChanged: (val) {
                          setState(() {
                            _controlSystemType = val;
                          });
                        }),
                    Text(
                      "Hybrid",
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
