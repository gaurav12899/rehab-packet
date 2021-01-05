import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/screen/forms/knee_form.dart';
import 'package:project/screen/homeScreen/home_screen.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class DemographicForm extends StatefulWidget {
  static const routeName = '/DemographicForm';

  @override
  _DemographicFormState createState() => _DemographicFormState();
}

class _DemographicFormState extends State<DemographicForm> {
  var _livingCondition;
  List livingCondition = ['assistance', 'no-assistance', 'with family'];
  var _activityLevel;
  List activityLevel = ['K1', 'K2', 'K3', 'K4'];

  Map form = {
    'name': '',
    'age': '',
    'address': '',
    'state': '',
    'pincode': '',
    'contact': '',
    'email': '',
    'occupation': '',
    'height': '',
    'weight': '',
    'livingCondition': '',
  };

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

  void _printPngBytes() async {
    var pngBytes = await _capturePng();
    // var bs64 = base64Encode(pngBytes);
    print(pngBytes);
    bytList.add(pngBytes);
    print(bytList);
    Navigator.of(context).pushNamed(KneeForm.routeName, arguments: bytList);

    // print(bs64);
  }

  Future _saveForm(var form, String docId) async {
    final pdf = pw.Document();

    Directory directory = await getExternalStorageDirectory();
    String docpath = directory.path;
    final file = File('$docpath/${FirebaseAuth.instance.currentUser.uid}.pdf');
    file.writeAsBytesSync(pdf.save());
    print("saved");
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid.toString())
        .collection('username')
        .doc(docId)
        .set({
      'name': form['name'],
      'age': form['age'],
      'address': form['address'],
      'state': form['state'],
      'pincode': form['pincode'],
      'contact': form['contact'],
      'email': form['email'],
      'occupation': form['occupation'],
      'height': form['height'],
      'weight': form['weight'],
      'livingCondition': form['livingCondition'],
      'date': DateTime.now().toUtc(),
      'activityLevel': form['activityLevel'],
    });
    return docId;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Demographic Form"),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentscope = FocusScope.of(context);
            if (!currentscope.hasPrimaryFocus) {
              currentscope.unfocus();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RepaintBoundary(
              key: _containerKey,
              child: Column(
                children: [
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Name: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(child: TextFormField(
                                onChanged: (val) {
                                  form['name'] = val;
                                },
                              )),
                              Text(
                                "Age: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(child: TextFormField(
                                onChanged: (val) {
                                  form['age'] = val;
                                },
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Address: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(child: TextFormField(
                                onChanged: (val) {
                                  form['address'] = val;
                                },
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "State: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(child: TextFormField(
                                onChanged: (val) {
                                  form['state'] = val;
                                },
                              )),
                              Text(
                                "Pincode: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(child: TextFormField(
                                onChanged: (val) {
                                  form['pincode'] = val;
                                },
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Contact: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(child: TextFormField(
                                onChanged: (val) {
                                  form['contact'] = val;
                                },
                              )),
                              Text(
                                "E-mail: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(child: TextFormField(
                                onChanged: (val) {
                                  form['email'] = val;
                                },
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Occupation: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(child: TextFormField(
                                onChanged: (val) {
                                  form['occupation'] = val;
                                },
                              )),
                              Text(
                                "Height: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(child: TextFormField(
                                onChanged: (val) {
                                  form['height'] = val;
                                },
                              )),
                              Text(
                                "Weight: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(child: TextFormField(
                                onChanged: (val) {
                                  form['weight'] = val;
                                },
                              )),
                            ],
                          ),
                          LivingCondition(
                              livingCondition2: _livingCondition,
                              form: form,
                              livingCondition: livingCondition),
                          ActivityLevel(
                              activityLevel2: _activityLevel,
                              form: form,
                              activityLevel: activityLevel),
                          Row(
                            children: [
                              Text(
                                "Diagnosis: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(child: TextFormField(
                                onChanged: (val) {
                                  form['diagnosis'] = val;
                                },
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Description: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(child: TextFormField(
                                onChanged: (val) {
                                  form['description'] = val;
                                },
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Past History: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: TextFormField(
                                minLines: 3,
                                maxLines: 3,
                                onChanged: (val) {
                                  form['pastHistory'] = val;
                                },
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Occupation\nHistory: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: TextFormField(
                                minLines: 3,
                                maxLines: 3,
                                onChanged: (val) {
                                  form['Occupationistory'] = val;
                                },
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Current\nSituation: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: TextFormField(
                                minLines: 3,
                                maxLines: 3,
                                onChanged: (val) {
                                  form['currentSituation'] = val;
                                },
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                              "Have you had or do you have any of the following:",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          CheckboxListTile(
                            activeColor: Colors.red,
                            title: Text("Heart Problem"),
                            value: timeDilation != 1.0,
                            onChanged: (newValue) {
                              setState(() {
                                setState(() {
                                  timeDilation = newValue ? 2.0 : 1.0;
                                });
                              });
                            },
                          ),
                          CheckboxListTile(
                            activeColor: Colors.red,
                            title: Text("HyperTension/High BP"),
                            value: timeDilation != 1.0,
                            onChanged: (newValue) {
                              setState(() {
                                setState(() {
                                  timeDilation = newValue ? 2.0 : 1.0;
                                });
                              });
                            },
                          ),
                          CheckboxListTile(
                            activeColor: Colors.red,
                            title: Text("Neurological Problem"),
                            value: timeDilation != 1.0,
                            onChanged: (newValue) {
                              setState(() {
                                setState(() {
                                  timeDilation = newValue ? 2.0 : 1.0;
                                });
                              });
                            },
                          ),
                          CheckboxListTile(
                            activeColor: Colors.red,
                            title: Text("Vascular Diseases"),
                            value: timeDilation != 1.0,
                            onChanged: (newValue) {
                              setState(() {
                                setState(() {
                                  timeDilation = newValue ? 2.0 : 1.0;
                                });
                              });
                            },
                          ),
                          CheckboxListTile(
                            activeColor: Colors.red,
                            title: Text("Strok/TIA/CVA"),
                            value: timeDilation != 1.0,
                            onChanged: (newValue) {
                              setState(() {
                                setState(() {
                                  timeDilation = newValue ? 2.0 : 1.0;
                                });
                              });
                            },
                          ),
                          CheckboxListTile(
                            activeColor: Colors.red,
                            title: Text("Alcholism"),
                            value: false,
                            onChanged: (newValue) {
                              setState(() {
                                // newValue = !newValue;
                                print(newValue);
                                timeDilation = newValue ? 2.0 : 1.0;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: FlatButton(
                      color: Colors.blue,
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        // _printPngBytes();
                        String docId =
                            DateTime.now().microsecondsSinceEpoch.toString();

                        _saveForm(form, docId);
                        print("from demo${form["name"]}");
                        Navigator.of(context)
                            .pushNamed(HomeScreen.routeName, arguments: docId);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class LivingCondition extends StatefulWidget {
  LivingCondition({
    Key key,
    @required livingCondition2,
    @required this.form,
    @required this.livingCondition,
  })  : _livingCondition = livingCondition2,
        super(key: key);

  var _livingCondition;
  final Map form;
  final List livingCondition;

  @override
  _LivingConditionState createState() => _LivingConditionState();
}

class _LivingConditionState extends State<LivingCondition> {
  var _livingCondition;

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Living Condition: ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
                activeColor: Colors.green,
                value: 1,
                groupValue: widget._livingCondition,
                onChanged: (val) {
                  setState(() {
                    widget._livingCondition = val;
                    widget.form['livingCondition'] =
                        widget.livingCondition[val];
                  });
                }),
            Text(
              "\nAssistance",
              textAlign: TextAlign.justify,
            )
          ],
        ),
        Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
                activeColor: Colors.green,
                value: 2,
                groupValue: widget._livingCondition,
                onChanged: (val) {
                  setState(() {
                    widget._livingCondition = val;
                    widget.form['livingCondition'] =
                        widget.livingCondition[val];
                    print("2 selected");
                  });
                }),
            Text(
              "No\nassistance",
              textAlign: TextAlign.center,
            )
          ],
        ),
        Column(
          children: [
            Radio(
                value: 3,
                activeColor: Colors.green,
                groupValue: widget._livingCondition,
                onChanged: (val) {
                  setState(() {
                    _livingCondition = val;
                    widget.form['livingCondition'] =
                        widget.livingCondition[val];
                  });
                }),
            Text(
              "with\nFamily",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}

class ActivityLevel extends StatefulWidget {
  ActivityLevel({
    Key key,
    @required activityLevel2,
    @required this.form,
    @required this.activityLevel,
  })  : _activityLevel = activityLevel2,
        super(key: key);

  var _activityLevel;
  final Map form;
  final List activityLevel;

  @override
  _ActivityLevelState createState() => _ActivityLevelState();
}

class _ActivityLevelState extends State<ActivityLevel> {
  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "activityLevel: ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
                activeColor: Colors.green,
                value: 1,
                groupValue: widget._activityLevel,
                onChanged: (val) {
                  setState(() {
                    widget._activityLevel = val;
                    widget.form['livingCondition'] = widget.activityLevel[val];
                  });
                }),
            Text(
              "K1",
              textAlign: TextAlign.justify,
            )
          ],
        ),
        Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
                activeColor: Colors.green,
                value: 2,
                groupValue: widget._activityLevel,
                onChanged: (val) {
                  setState(() {
                    widget._activityLevel = val;
                    widget.form['activityLevel'] = widget.activityLevel[val];
                    print("2 selected");
                  });
                }),
            Text(
              "K2",
              textAlign: TextAlign.center,
            )
          ],
        ),
        Column(
          children: [
            Radio(
                value: 3,
                activeColor: Colors.green,
                groupValue: widget._activityLevel,
                onChanged: (val) {
                  setState(() {
                    widget._activityLevel = val;
                    widget.form['activityLevel'] = widget.activityLevel[val];
                  });
                }),
            Text(
              "K3",
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Column(
          children: [
            Radio(
                value: 4,
                activeColor: Colors.green,
                groupValue: widget._activityLevel,
                onChanged: (val) {
                  setState(() {
                    widget._activityLevel = val;
                    widget.form['activityLevel'] = widget.activityLevel[val];
                  });
                }),
            Text(
              "K4",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}
