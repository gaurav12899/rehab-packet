import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/screen/homeScreen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project/view_pdf/pdf_list.dart';
import '../../widgets/image_picker.dart';

class DemographicForm extends StatefulWidget {
  static const routeName = '/DemographicForm';

  @override
  _DemographicFormState createState() => _DemographicFormState();
}

class _DemographicFormState extends State<DemographicForm> {
  var _livingCondition;
  List livingCondition = ['assistance', 'no-assistance', 'with family'];

  var _currentlyTakingMedicines;
  List currentlyTakingMedicines = ['Yes', 'No'];

  var _gender;
  List gender = ['Male', 'Female', 'others'];

  var _userStatus;
  List userStatus = ['Existing Patient', 'New Patient', 'Primary User'];

  var _livingEnv;
  List livingEnv = [
    'Hilly area',
    'Plain Area',
  ];

  var _activityLevel;
  List activityLevel = ['K1', 'K2', 'K3', 'K4'];
  bool checkbox1 = false;
  bool checkbox2 = false;
  bool checkbox3 = false;
  bool checkbox4 = false;
  bool checkbox5 = false;
  bool checkbox6 = false;
  bool checkbox7 = false;
  bool checkbox8 = false;
  bool checkbox9 = false;
  bool checkbox10 = false;
  bool checkbox11 = false;
  bool checkbox12 = false;
  List anyOtherProblem = [];
  TextEditingController otherProblemText = TextEditingController();
  bool _loading = false;
  imagePickFn1(File _pickedImage) async {
    form["image1"] = _pickedImage;
  }

  imagePickFn2(File _pickedImage) async {
    form["image2"] = _pickedImage;
  }

  imagePickFn3(File _pickedImage) async {
    form["image3"] = _pickedImage;
  }

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
    'prescription': '',
    'image1': null,
    'image2': null,
    'image3': null,
    'phyDemandBefore': '',
    'phyDemandAfter': '',
    'standingPerBefore': '',
    'standingPerAfter': '',
    'liftingBefore': '',
    'liftingAfter': '',
    'walkingBefore': '',
    'walkingAfter': '',
    'walkingTrainsBefore': '',
    'walkingTrainsAfter': '',
    'goals': '',
    'practitionerName': '',
    'practitionerContact': '',
    'company': '',
    'location': '',
    'physicianName': '',
    'physicianContact': '',
    'dept': '',
    'hospital': '',
    'description': '',
    'diagnosis': '',
    'pastHistory': '',
    'occupationHistory': '',
    'currentSituation': '',
    'currentlyTakingMedicines': '',
    'userStatus': '',
    'gender': ''
  };

  GlobalKey _containerKey = GlobalKey();

  Future _saveForm(var form, String docId, BuildContext context) async {
    String url1;
    String url2;
    String url3;
    if (_formKey.currentState.validate()) {
      setState(() {
        _loading = true;
      });
      _formKey.currentState.save();
      if (form["image1"] != null) {
        final ref1 = FirebaseStorage.instance
            .ref()
            .child(FirebaseAuth.instance.currentUser.uid.toString())
            .child("$docId")
            .child("Image1.jpg");
        await ref1.putFile(form['image1']).whenComplete(() async {
          url1 = await ref1.getDownloadURL();
        });
      }
      if (form["image2"] != null) {
        final ref2 = FirebaseStorage.instance
            .ref()
            .child(FirebaseAuth.instance.currentUser.uid.toString())
            .child("$docId")
            .child("Image2.jpg");
        await ref2.putFile(form['image2']).whenComplete(() async {
          url2 = await ref2.getDownloadURL();
        });
      }
      if (form["image3"] != null) {
        final ref3 = FirebaseStorage.instance
            .ref()
            .child(FirebaseAuth.instance.currentUser.uid.toString())
            .child("$docId")
            .child("Image3.jpg");
        await ref3.putFile(form['image3']).whenComplete(() async {
          url3 = await ref3.getDownloadURL();
        });
      }
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
        'imgUrl1': url1,
        'imgUrl2': url2,
        'imgUrl3': url3,
        'anyOtherProblem': anyOtherProblem,
        'diagnosis': form['diagnosis'],
        'description': form['description'],
        'pastHistory': form['pastHistory'],
        'occupationHistory': form['occupationHistory'],
        'currentSituation': form['currentSituation'],
        'goals': form['goals'],
        'practitionerName': form['practitionerName'],
        'practitionerContact': form['practitionerContact'],
        'company': form['company'],
        'location': form['location'],
        'physicianName': form['physicianName'],
        'physicianContact': form['physicianContact'],
        'dept': form['dept'],
        'hospital': form['hospital'],
        'currentlyTakingMedicines': form['currentlyTakingMedicines'],
        'userStatus': form['userStatus'],
        'phyDemandBefore': form['phyDemandBefore'],
        'phyDemandAfter': form['phyDemandAfter'],
        'standingPerBefore': form['standingPerBefore'],
        'standingPerAfter': form['standingPerAfter'],
        'liftingBefore': form['liftingBefore'],
        'liftingAfter': form['liftingAfter'],
        'walkingBefore': form['walkingBefore'],
        'walkingAfter': form['walkingAfter'],
        'walkingTrainsBefore': form['walkingTrainsBefore'],
        'walkingTrainsAfter': form['walkingTrainsAfter'],
        'prescription': form['prescription'],
        'gender': form['gender']
      }).whenComplete(() => showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Submitted!!"),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Patient List'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(PdfList.routeName);
                      },
                    ),
                    TextButton(
                      child: Text('Next'),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(HomeScreen.routeName, arguments: docId);
                      },
                    ),
                  ],
                );
              }));
      setState(() {
        _loading = false;
      });
      return docId;
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Demographic Form"),
          actions: [
            IconButton(
                icon: Icon(Icons.replay_outlined),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(DemographicForm.routeName);
                }),
            IconButton(
                icon: Icon(Icons.post_add),
                onPressed: () async {
                  String docId =
                      "${DateTime.now().microsecondsSinceEpoch.toString()}_${FirebaseAuth.instance.currentUser.uid.toString()}";

                  await _saveForm(form, docId, context);
                }),
          ],
        ),
        body: _loading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                ),
              )
            : GestureDetector(
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
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Name: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        decoration:
                                            InputDecoration(isDense: true),
                                        onSaved: (val) {
                                          form['name'] = val;
                                        },
                                      )),
                                      Text(
                                        "Age: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration:
                                            InputDecoration(isDense: true),
                                        onSaved: (val) {
                                          form['age'] = val;
                                        },
                                      )),
                                    ],
                                  ),
                                  Row(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Gender",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Radio(
                                              activeColor: Colors.green,
                                              value: 0,
                                              groupValue: _gender,
                                              onChanged: (val) {
                                                setState(() {
                                                  _gender = val;
                                                  form['gender'] = gender[val];
                                                });
                                              }),
                                          Text(
                                            "Male",
                                            textAlign: TextAlign.justify,
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Radio(
                                              activeColor: Colors.green,
                                              value: 1,
                                              groupValue: _gender,
                                              onChanged: (val) {
                                                setState(() {
                                                  _gender = val;
                                                  form['gender'] = gender[val];
                                                });
                                              }),
                                          Text(
                                            "Female",
                                            textAlign: TextAlign.justify,
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Radio(
                                              activeColor: Colors.green,
                                              value: 2,
                                              groupValue: _gender,
                                              onChanged: (val) {
                                                setState(() {
                                                  _gender = val;
                                                  form['gender'] = gender[val];
                                                });
                                              }),
                                          Text(
                                            "Other",
                                            textAlign: TextAlign.justify,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Address: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        decoration:
                                            InputDecoration(isDense: true),
                                        onSaved: (val) {
                                          form['address'] = val;
                                        },
                                      )),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "State: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration:
                                            InputDecoration(isDense: true),
                                        onChanged: (val) {
                                          form['state'] = val;
                                        },
                                      )),
                                      Text(
                                        "Pincode: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration:
                                            InputDecoration(isDense: true),
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration: InputDecoration(
                                          isDense: true,
                                        ),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        onChanged: (val) {
                                          form['contact'] = val;
                                        },
                                      )),
                                      Text(
                                        "E-mail: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration:
                                            InputDecoration(isDense: true),
                                        onChanged: (val) {
                                          form['email'] = val;
                                        },
                                      )),
                                    ],
                                  ),
                                  Row(children: [
                                    Text(
                                      "Occupation: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                        child: TextFormField(
                                      decoration:
                                          InputDecoration(isDense: true),
                                      onChanged: (val) {
                                        form['occupation'] = val;
                                      },
                                    )),
                                  ]),
                                  Row(
                                    children: [
                                      Text(
                                        "Height: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration:
                                            InputDecoration(isDense: true),
                                        onChanged: (val) {
                                          form['height'] = val;
                                        },
                                      )),
                                      Text(
                                        "Weight: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration:
                                            InputDecoration(isDense: true),
                                        onChanged: (val) {
                                          form['weight'] = val;
                                        },
                                      )),
                                    ],
                                  ),
                                  Row(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Living Condition: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Radio(
                                              activeColor: Colors.green,
                                              value: 0,
                                              groupValue: _livingCondition,
                                              onChanged: (val) {
                                                setState(() {
                                                  _livingCondition = val;
                                                  form['livingCondition'] =
                                                      livingCondition[val];
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
                                              value: 1,
                                              groupValue: _livingCondition,
                                              onChanged: (val) {
                                                setState(() {
                                                  _livingCondition = val;
                                                  form['livingCondition'] =
                                                      livingCondition[val];
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
                                              value: 2,
                                              activeColor: Colors.green,
                                              groupValue: _livingCondition,
                                              onChanged: (val) {
                                                setState(() {
                                                  _livingCondition = val;
                                                  form['livingCondition'] =
                                                      livingCondition[val];
                                                });
                                              }),
                                          Text(
                                            "with\nFamily",
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "activityLevel: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Column(
                                        // crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Radio(
                                              activeColor: Colors.green,
                                              value: 0,
                                              groupValue: _activityLevel,
                                              onChanged: (val) {
                                                setState(() {
                                                  _activityLevel = val;
                                                  form['livingCondition'] =
                                                      activityLevel[val];
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
                                              value: 1,
                                              groupValue: _activityLevel,
                                              onChanged: (val) {
                                                setState(() {
                                                  _activityLevel = val;
                                                  form['activityLevel'] =
                                                      activityLevel[val];
                                                });
                                              }),
                                          Text(
                                            " K2",
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Radio(
                                              value: 2,
                                              activeColor: Colors.green,
                                              groupValue: _activityLevel,
                                              onChanged: (val) {
                                                setState(() {
                                                  _activityLevel = val;
                                                  form['activityLevel'] =
                                                      activityLevel[val];
                                                });
                                              }),
                                          Text(
                                            " K3",
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Radio(
                                              value: 3,
                                              activeColor: Colors.green,
                                              groupValue: _activityLevel,
                                              onChanged: (val) {
                                                setState(() {
                                                  _activityLevel = val;
                                                  form['activityLevel'] =
                                                      activityLevel[val];
                                                });
                                              }),
                                          Text(
                                            "K4",
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "User Status? ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Radio(
                                              activeColor: Colors.green,
                                              value: 0,
                                              groupValue: _userStatus,
                                              onChanged: (val) {
                                                setState(() {
                                                  _userStatus = val;
                                                  form['userStatus'] =
                                                      userStatus[val];
                                                });
                                              }),
                                          Text(
                                            "Existing\n Patient",
                                            textAlign: TextAlign.justify,
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Radio(
                                              activeColor: Colors.green,
                                              value: 1,
                                              groupValue: _userStatus,
                                              onChanged: (val) {
                                                setState(() {
                                                  _userStatus = val;
                                                  form['userStatus'] =
                                                      userStatus[val];
                                                });
                                              }),
                                          Text(
                                            "New\nPatient",
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Radio(
                                              activeColor: Colors.green,
                                              value: 2,
                                              groupValue: _userStatus,
                                              onChanged: (val) {
                                                setState(() {
                                                  _userStatus = val;
                                                  form['userStatus'] =
                                                      userStatus[val];
                                                });
                                              }),
                                          Text(
                                            "Primary\nUser",
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Diagnosis: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration:
                                            InputDecoration(isDense: true),
                                        onChanged: (val) {
                                          form['diagnosis'] = val;
                                        },
                                      )),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Presciption: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration:
                                            InputDecoration(isDense: true),
                                        onChanged: (val) {
                                          form['prescription'] = val;
                                        },
                                      )),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Description: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration:
                                            InputDecoration(isDense: true),
                                        onChanged: (val) {
                                          form['description'] = val;
                                        },
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Past\nHistory: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration: InputDecoration(
                                            isDense: true,
                                            border: OutlineInputBorder()),
                                        minLines: 3,
                                        maxLines: 3,
                                        onChanged: (val) {
                                          form['pastHistory'] = val;
                                        },
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Occupation\nHistory: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration: InputDecoration(
                                            isDense: true,
                                            border: OutlineInputBorder()),
                                        minLines: 3,
                                        maxLines: 3,
                                        onChanged: (val) {
                                          form['occupationHistory'] = val;
                                        },
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Current\nSituation: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration: InputDecoration(
                                            isDense: true,
                                            border: OutlineInputBorder()),
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  CheckboxListTile(
                                      activeColor: Colors.red,
                                      title: Text("HEART PROBLEM"),
                                      value: checkbox1,
                                      onChanged: (newValue) {
                                        setState(() {
                                          checkbox1 = newValue;
                                        });
                                        if (checkbox1) {
                                          anyOtherProblem.add("HEART PROBLEM");
                                        }
                                        if (!checkbox1) {
                                          anyOtherProblem
                                              .remove("HEART PROBLEM");
                                        }
                                      }),
                                  CheckboxListTile(
                                      activeColor: Colors.red,
                                      title: Text("NEUROLOGICAL PROBLEM"),
                                      value: checkbox3,
                                      onChanged: (newValue) {
                                        setState(() {
                                          checkbox3 = newValue;
                                        });
                                        if (checkbox3) {
                                          anyOtherProblem
                                              .add("NEUROLOGICAL PROBLEM");
                                        }
                                        if (!checkbox3) {
                                          anyOtherProblem
                                              .remove("NEUROLOGICAL PROBLEM");
                                        }
                                      }),
                                  CheckboxListTile(
                                      activeColor: Colors.red,
                                      title: Text("VASCULAR DISEASE"),
                                      value: checkbox4,
                                      onChanged: (newValue) {
                                        setState(() {
                                          checkbox4 = newValue;
                                        });
                                        if (checkbox4) {
                                          anyOtherProblem
                                              .add("VASCULAR DISEASE");
                                        }
                                        if (!checkbox4) {
                                          anyOtherProblem
                                              .remove("VASCULAR DISEASE");
                                        }
                                      }),
                                  CheckboxListTile(
                                      activeColor: Colors.red,
                                      title: Text("ALCOHOLISM"),
                                      value: checkbox5,
                                      onChanged: (newValue) {
                                        setState(() {
                                          checkbox5 = newValue;
                                        });
                                        if (checkbox5) {
                                          anyOtherProblem.add("ALCOHOLISM");
                                        }
                                        if (!checkbox5) {
                                          anyOtherProblem.remove("ALCOHOLISM");
                                        }
                                      }),
                                  CheckboxListTile(
                                      activeColor: Colors.red,
                                      title: Text("RHEUMATOID ARTHRITIS"),
                                      value: checkbox6,
                                      onChanged: (newValue) {
                                        setState(() {
                                          checkbox6 = newValue;
                                        });
                                        if (checkbox6) {
                                          anyOtherProblem
                                              .add("RHEUMATOID ARTHRITIS");
                                        }
                                        if (!checkbox6) {
                                          anyOtherProblem
                                              .remove("RHEUMATOID ARTHRITIS");
                                        }
                                      }),
                                  CheckboxListTile(
                                      activeColor: Colors.red,
                                      title: Text("HYPERTENSION/ HIGH BP"),
                                      value: checkbox7,
                                      onChanged: (newValue) {
                                        setState(() {
                                          checkbox7 = newValue;
                                        });
                                        if (checkbox7) {
                                          anyOtherProblem
                                              .add("HYPERTENSION/ HIGH BP");
                                        }
                                        if (!checkbox7) {
                                          anyOtherProblem
                                              .remove("HYPERTENSION/ HIGH BP");
                                        }
                                      }),
                                  CheckboxListTile(
                                      activeColor: Colors.red,
                                      title: Text("DIABETES (TYPE 1 & TYPE 2)"),
                                      value: checkbox8,
                                      onChanged: (newValue) {
                                        setState(() {
                                          checkbox8 = newValue;
                                        });
                                        if (checkbox8) {
                                          anyOtherProblem.add(
                                              "DIABETES (TYPE 1 & TYPE 2)");
                                        }
                                        if (!checkbox8) {
                                          anyOtherProblem.remove(
                                              "DIABETES (TYPE 1 & TYPE 2)");
                                        }
                                      }),
                                  CheckboxListTile(
                                      activeColor: Colors.red,
                                      title: Text("OSTEOARTHRITIS"),
                                      value: checkbox9,
                                      onChanged: (newValue) {
                                        setState(() {
                                          checkbox9 = newValue;
                                        });
                                        if (checkbox9) {
                                          anyOtherProblem.add("OSTEOARTHRITIS");
                                        }
                                        if (!checkbox9) {
                                          anyOtherProblem
                                              .remove("OSTEOARTHRITIS");
                                        }
                                      }),
                                  CheckboxListTile(
                                      activeColor: Colors.red,
                                      title: Text("OSTEOPOROSIS"),
                                      value: checkbox10,
                                      onChanged: (newValue) {
                                        setState(() {
                                          checkbox10 = newValue;
                                        });
                                        if (checkbox10) {
                                          anyOtherProblem.add("OSTEOPOROSIS");
                                        }
                                        if (!checkbox10) {
                                          anyOtherProblem
                                              .remove("OSTEOPOROSIS");
                                        }
                                      }),
                                  CheckboxListTile(
                                      activeColor: Colors.red,
                                      title: Text("STROKE/TBI/CVA"),
                                      value: checkbox11,
                                      onChanged: (newValue) {
                                        setState(() {
                                          checkbox11 = newValue;
                                        });
                                        if (checkbox11) {
                                          anyOtherProblem.add("STROKE/TIA/CVA");
                                        }
                                        if (!checkbox11) {
                                          anyOtherProblem
                                              .remove("STROKE/TIA/CVA");
                                        }
                                      }),
                                  CheckboxListTile(
                                      activeColor: Colors.red,
                                      title: Text("SKIN PROBLEM"),
                                      value: checkbox12,
                                      onChanged: (newValue) {
                                        setState(() {
                                          checkbox12 = newValue;
                                        });
                                        if (checkbox12) {
                                          anyOtherProblem.add("SKIN PROBLEM");
                                        }
                                        if (!checkbox12) {
                                          anyOtherProblem
                                              .remove("SKIN PROBLEM");
                                        }
                                      }),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Any other condition that might affect your treatment ? ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                          child: TextFormField(
                                        decoration:
                                            InputDecoration(isDense: true),
                                        minLines: 1,
                                        controller: otherProblemText,
                                        maxLines: 3,
                                        onSaved: (val) {
                                          anyOtherProblem
                                              .add(otherProblemText.text);
                                        },
                                      )),
                                    ],
                                  ),
                                  PickImage(imagePickFn1),
                                  PickImage(imagePickFn2),
                                  PickImage(imagePickFn3),
                                  Row(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Currently\nTaking Medicines? ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Radio(
                                              activeColor: Colors.green,
                                              value: 0,
                                              groupValue:
                                                  _currentlyTakingMedicines,
                                              onChanged: (val) {
                                                setState(() {
                                                  _currentlyTakingMedicines =
                                                      val;
                                                  form['currentlyTakingMedicines'] =
                                                      currentlyTakingMedicines[
                                                          val];
                                                });
                                              }),
                                          Text(
                                            "Yes",
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
                                              value: 1,
                                              groupValue:
                                                  _currentlyTakingMedicines,
                                              onChanged: (val) {
                                                setState(() {
                                                  _currentlyTakingMedicines =
                                                      val;
                                                  form['currentlyTakingMedicines'] =
                                                      currentlyTakingMedicines[
                                                          val];
                                                });
                                              }),
                                          Text(
                                            "No",
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Living\nEnvironment ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Radio(
                                              activeColor: Colors.green,
                                              value: 0,
                                              groupValue: _livingEnv,
                                              onChanged: (val) {
                                                setState(() {
                                                  _livingEnv = val;
                                                  form['livingEnv'] =
                                                      livingEnv[val];
                                                });
                                              }),
                                          Text(
                                            "Hilly\narea",
                                            textAlign: TextAlign.justify,
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Radio(
                                              activeColor: Colors.green,
                                              value: 1,
                                              groupValue: _livingEnv,
                                              onChanged: (val) {
                                                setState(() {
                                                  _livingEnv = val;
                                                  form['livingEnv'] =
                                                      livingEnv[val];
                                                });
                                              }),
                                          Text(
                                            "Plain\narea",
                                            textAlign: TextAlign.justify,
                                          )
                                        ],
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: TextField(
                                          decoration: InputDecoration(
                                              hintText: "Others"),
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    "Daily Physical Demand:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Before: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration:
                                            InputDecoration(isDense: true),
                                        onChanged: (val) {
                                          form['phyDemandBefore'] = val;
                                        },
                                      )),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "After: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration:
                                            InputDecoration(isDense: true),
                                        onChanged: (val) {
                                          form['phyDemandAfter'] = val;
                                        },
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "50% OR MORE STANDING :",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Before: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration:
                                            InputDecoration(isDense: true),
                                        onChanged: (val) {
                                          form['standingPerBefore'] = val;
                                        },
                                      )),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "After: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration:
                                            InputDecoration(isDense: true),
                                        onChanged: (val) {
                                          form['standingPerAfter'] = val;
                                        },
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "LIFTING REUIREMENT OVER 10kg – 15kg ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Before: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration:
                                            InputDecoration(isDense: true),
                                        onChanged: (val) {
                                          form['liftingBefore'] = val;
                                        },
                                      )),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "After: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration:
                                            InputDecoration(isDense: true),
                                        onChanged: (val) {
                                          form['liftingAfter'] = val;
                                        },
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "WALKING FOR 2KM – 3KM or MORE  ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Before: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration:
                                            InputDecoration(isDense: true),
                                        onChanged: (val) {
                                          form['walkingBefore'] = val;
                                        },
                                      )),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "After: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration:
                                            InputDecoration(isDense: true),
                                        onChanged: (val) {
                                          form['walkingAfter'] = val;
                                        },
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "WALKING ON UNEVEN TRAINS : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Before: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration:
                                            InputDecoration(isDense: true),
                                        onChanged: (val) {
                                          form['walkingTrainsBefore'] = val;
                                        },
                                      )),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "After: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration:
                                            InputDecoration(isDense: true),
                                        onChanged: (val) {
                                          form['walkingTrainsAfter'] = val;
                                        },
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "GOALS FOR WHAT YOU WOULD LIKE TO BE ABLE TO DO WITH YOUR PROSTHESIS/ ORTHOSIS ?",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                        isDense: true,
                                        border: OutlineInputBorder()),
                                    maxLines: 3,
                                    minLines: 3,
                                    onChanged: (val) {
                                      form['goals'] = val;
                                    },
                                  ),
                                  Divider(),
                                  Row(
                                    children: [
                                      Text(
                                        "PRACTITIONER NAME : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration:
                                            InputDecoration(isDense: true),
                                        keyboardType: TextInputType.name,
                                        onChanged: (val) {
                                          form['practitionerName'] = val;
                                        },
                                      )),
                                      Text(
                                        "CONTACT: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration:
                                            InputDecoration(isDense: true),
                                        keyboardType: TextInputType.phone,
                                        onChanged: (val) {
                                          form['practitionerContact'] = val;
                                        },
                                      )),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "COMPANY : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration:
                                            InputDecoration(isDense: true),
                                        onChanged: (val) {
                                          form['company'] = val;
                                        },
                                      )),
                                      Text(
                                        "LOCATION: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration:
                                            InputDecoration(isDense: true),
                                        onChanged: (val) {
                                          form['location'] = val;
                                        },
                                      )),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "PHYSICIAN NAME : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration:
                                            InputDecoration(isDense: true),
                                        onChanged: (val) {
                                          form['physicianName'] = val;
                                        },
                                      )),
                                      Text(
                                        "Dept: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration:
                                            InputDecoration(isDense: true),
                                        onChanged: (val) {
                                          form['dept'] = val;
                                        },
                                      )),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "CONTACT : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        keyboardType: TextInputType.phone,
                                        decoration:
                                            InputDecoration(isDense: true),
                                        onChanged: (val) {
                                          form['physicianContact'] = val;
                                        },
                                      )),
                                      Text(
                                        "HOSPITAL: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration:
                                            InputDecoration(isDense: true),
                                        onChanged: (val) {
                                          form['hospital'] = val;
                                        },
                                      )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
  }
}
