import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;
import 'package:project/screen/forms/elbowOrthosis/elbowOrthosis.dart';
import 'package:project/screen/forms/elbowOrthosis/elbowOrthosisC.dart';

class ElbowOrthosisB extends StatefulWidget {
  static const routeName = '/elbowOrthosisB';
  var bytelist;
  var username;
  ElbowOrthosisB({@required this.bytelist, @required this.username});

  @override
  _ElbowOrthosisBState createState() => _ElbowOrthosisBState();
}

class _ElbowOrthosisBState extends State<ElbowOrthosisB> {
  var _mcpAssistanceNeeded;
  var _mcpStaticControls;
  var _material;
  var _humeralClosure;
  var _forarmClosure;
  var _handClosure;
  var _trimline;
  var _paddingMaterial;

  final doc = pw.Document();

  bool loading = false;
  GlobalKey _containerKey = GlobalKey();
  Future<Uint8List> _capturePng() async {
    RenderRepaintBoundary boundary =
        _containerKey.currentContext.findRenderObject();

    ui.Image image;
    bool catched = false;
    try {
      image = await boundary.toImage();
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

  void _printPngBytes() async {
    var pngBytes = await _capturePng();
    if (widget.bytelist.length > 1) {
      widget.bytelist.removeLast();
    }
    await widget.bytelist.add(pngBytes);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => ElbowOrthosisC(
            bytelist: widget.bytelist, username: widget.username)));
    // print(bs64);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Elbow Orthosis"),
        actions: [
          IconButton(
              icon: Icon(Icons.navigate_next_rounded),
              onPressed: () {
                _printPngBytes();
              })
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          // height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      StaticControls(staticControls2: _mcpStaticControls),
                      Divider(),
                      AssistanceNeeded(assistanceNeeded2: _mcpAssistanceNeeded),
                      Divider(),
                      Material(
                        material2: _material,
                      ),
                      Divider(),
                      Text(
                        "CLOSURES",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            "Humeral Closure",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Closures(closure2: _humeralClosure),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Forarm Closure",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Closures(closure2: _forarmClosure),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Hand Closure",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Closures(closure2: _handClosure),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hand\nTrimline",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Trimline(trimline2: _trimline),
                        ],
                      ),
                      Divider(),
                      PaddingMaterial(paddingMaterial2: _paddingMaterial)
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
          RadioListTile(
              title: Text("Low Temp ThermoPlastic"),
              activeColor: Colors.green,
              value: 0,
              groupValue: widget._material,
              onChanged: (val) {
                setState(() {
                  widget._material = val;
                });
              }),
          RadioListTile(
              title: Text("High Temp ThermoPlastic"),
              activeColor: Colors.green,
              value: 1,
              groupValue: widget._material,
              onChanged: (val) {
                setState(() {
                  widget._material = val;
                });
              }),
          Container(
            width: 250,
            child: TextField(
              decoration: InputDecoration(labelText: "Others"),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ]);
  }
}

class Closures extends StatefulWidget {
  Closures({
    Key key,
    @required closure2,
  })  : _closure = closure2,
        super(key: key);

  var _closure;

  @override
  _ClosuresState createState() => _ClosuresState();
}

class _ClosuresState extends State<Closures> {
  @override
  Widget build(BuildContext context) {
    return Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Radio(
                  // title: Text("Flexible"),
                  activeColor: Colors.green,
                  value: 0,
                  groupValue: widget._closure,
                  onChanged: (val) {
                    setState(() {
                      widget._closure = val;
                    });
                  }),
              Text("Flexible")
            ],
          ),
          Row(
            children: [
              Radio(
                  activeColor: Colors.green,
                  value: 1,
                  groupValue: widget._closure,
                  onChanged: (val) {
                    setState(() {
                      widget._closure = val;
                    });
                  }),
              Text("Rigid")
            ],
          ),
        ]);
  }
}

class Trimline extends StatefulWidget {
  Trimline({
    Key key,
    @required trimline2,
  })  : _trimline = trimline2,
        super(key: key);

  var _trimline;

  @override
  _TrimlineState createState() => _TrimlineState();
}

class _TrimlineState extends State<Trimline> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Row(
                children: [
                  Radio(
                      activeColor: Colors.green,
                      value: 0,
                      groupValue: widget._trimline,
                      onChanged: (val) {
                        setState(() {
                          widget._trimline = val;
                        });
                      }),
                  Text("Full Handpice"),
                ],
              ),
              Row(
                children: [
                  Radio(
                      activeColor: Colors.green,
                      value: 1,
                      groupValue: widget._trimline,
                      onChanged: (val) {
                        setState(() {
                          widget._trimline = val;
                        });
                      }),
                  Text("MCP Trimline"),
                ],
              ),
            ],
          ),
          Container(
            width: 250,
            child: TextField(
              decoration: InputDecoration(labelText: "Others"),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ]);
  }
}

class PaddingMaterial extends StatefulWidget {
  PaddingMaterial({
    Key key,
    @required paddingMaterial2,
  })  : _paddingMaterial = paddingMaterial2,
        super(key: key);

  var _paddingMaterial;

  @override
  _PaddingMaterialState createState() => _PaddingMaterialState();
}

class _PaddingMaterialState extends State<PaddingMaterial> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "REQUIRED PADDING MATERIAL",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Row(
                children: [
                  Radio(
                      activeColor: Colors.green,
                      value: 0,
                      groupValue: widget._paddingMaterial,
                      onChanged: (val) {
                        setState(() {
                          widget._paddingMaterial = val;
                        });
                      }),
                  Text("Ethaflex"),
                ],
              ),
              Row(
                children: [
                  Radio(
                      activeColor: Colors.green,
                      value: 1,
                      groupValue: widget._paddingMaterial,
                      onChanged: (val) {
                        setState(() {
                          widget._paddingMaterial = val;
                        });
                      }),
                  Text("Plasterzote"),
                ],
              ),
            ],
          ),
          Container(
            width: 250,
            child: TextField(
              decoration: InputDecoration(labelText: "Others"),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ]);
  }
}
