import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:project/screen/homeScreen/new-or-old-patient.dart';
import 'dart:ui' as ui;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class CosmeticRestorationHandC extends StatefulWidget {
  static const routeName = '/cosmeticRestorationHandb';

  var bytelist;
  var username;
  CosmeticRestorationHandC({@required this.bytelist, @required this.username});
  @override
  _CosmeticRestorationHandCState createState() =>
      _CosmeticRestorationHandCState();
}

class _CosmeticRestorationHandCState extends State<CosmeticRestorationHandC> {
  GlobalKey _containerKey = GlobalKey();

  var _type;
  bool loading = false;

  final doc = pw.Document();
  List bytList = [];
  Future<Uint8List> _capturePng() async {
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

  var doctorInfo;
  var patientInfo;
  void _printPngBytes() async {
    this.setState(() {
      loading = true;
    });
    doctorInfo = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    patientInfo = await FirebaseFirestore.instance
        .collection("users")
        .doc("${FirebaseAuth.instance.currentUser.uid}")
        .collection("username")
        .doc(widget.username)
        .get();

    var pngBytes = await _capturePng();
    if (widget.bytelist.length > 2) {
      widget.bytelist.removeLast();
    }
    await widget.bytelist.add(pngBytes);

    final ByteData bytes = await rootBundle.load('assets/images/REHAB.jpg');
    final Uint8List list = bytes.buffer.asUint8List();
    final logo = PdfImage.file(doc.document, bytes: list);

    doc.addPage(pw.MultiPage(
        margin: pw.EdgeInsets.all(10),
        build: (pw.Context context) => [
              pw.Header(
                level: 0,
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      pw.Text('Partial Hand Prosthesis', textScaleFactor: 1),
                      pw.Image(logo, width: 60, height: 60)
                    ]),
              ),
              pw.Center(
                  child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                    pw.Column(children: [
                      pw.Text("Patient Information",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 35,
                            decoration: pw.TextDecoration.underline,
                          )),
                      pw.Text("PatientName: ${patientInfo['name']}",
                          style: pw.TextStyle(
                            fontStyle: pw.FontStyle.italic,
                            fontSize: 20,
                          )),
                      pw.Text("Age: ${patientInfo['age']}",
                          style: pw.TextStyle(
                            fontStyle: pw.FontStyle.italic,
                            fontSize: 20,
                          )),
                      pw.Text("Sex: ${patientInfo['gender']}",
                          style: pw.TextStyle(
                            fontStyle: pw.FontStyle.italic,
                            fontSize: 20,
                          )),
                    ]),
                    pw.Column(children: [
                      pw.Text("Doctor Information",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 35,
                            decoration: pw.TextDecoration.underline,
                          )),
                      pw.Text(
                          "BY:${doctorInfo['firstName']} ${doctorInfo['lastName']}",
                          style: pw.TextStyle(
                            fontStyle: pw.FontStyle.italic,
                            fontSize: 20,
                          )),
                      pw.Text("Phone:${doctorInfo['phone']} ",
                          style: pw.TextStyle(
                            fontStyle: pw.FontStyle.italic,
                            fontSize: 20,
                          )),
                      pw.Text("Address:${doctorInfo['address']} ",
                          style: pw.TextStyle(
                            fontStyle: pw.FontStyle.italic,
                            fontSize: 20,
                          )),
                    ])
                  ])),
              pw.Divider()
            ]));

    for (int i = 0; i < widget.bytelist.length; i++) {
      final image = PdfImage.file(
        doc.document,
        bytes: widget.bytelist[i],
      );

      doc.addPage(pw.MultiPage(
          margin: pw.EdgeInsets.all(10),
          build: (pw.Context context) => [
                pw.Header(
                  level: 0,
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: <pw.Widget>[
                        pw.Text('Partial Hand Prosthesis', textScaleFactor: 1),
                        pw.Image(logo, width: 60, height: 60)
                      ]),
                ),
                pw.Center(
                  child: pw.Image(image, height: 700, fit: pw.BoxFit.fill),
                ),
                pw.Divider(),
              ]));
    }

    Directory directory = await getExternalStorageDirectory();
    String docpath = directory.path;
    final file = File('$docpath/${FirebaseAuth.instance.currentUser.uid}.pdf');

    file.writeAsBytesSync(doc.save(), flush: true);

    final ref = FirebaseStorage.instance
        .ref()
        .child(FirebaseAuth.instance.currentUser.uid)
        .child(widget.username)
        .child("Partial Hand Prosthesis.pdf");
    await ref.putFile(file).whenComplete(() => this.setState(() {
          loading = false;
        }));
    final url = await ref.getDownloadURL();
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc("${FirebaseAuth.instance.currentUser.uid}")
          .collection("username")
          .doc(widget.username)
          .collection("formname")
          .doc("Partial Hand Prosthesis")
          .set({"form": url});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text("Form Submitted!!"),
        duration: Duration(seconds: 3),
      ));
    } on Exception catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text("Something went wrong!!"),
        ),
      );
    }
    await Navigator.of(context)
        .pushNamedAndRemoveUntil(NewOrOldPatient.routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text("Partial Hand Prosthesis"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RepaintBoundary(key: _containerKey, child: ImageContainers()),
            Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * .8,
              child: ElevatedButton(
                child: loading
                    ? Row(
                        children: [
                          Text("Generating Doc",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10)),
                          SizedBox(
                            width: 20,
                          ),
                          CircularProgressIndicator(),
                        ],
                      )
                    : Text("Submit",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                onPressed: loading
                    ? null
                    : () {
                        _printPngBytes();
                      },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ImageContainers extends StatefulWidget {
  @override
  _ImageContainersState createState() => _ImageContainersState();
}

class _ImageContainersState extends State<ImageContainers> {
  File _image1;
  File _image2;
  File _image3;

  final _imagePicker = ImagePicker();
  imagePickFn1(File _pickedImage) async {
    _image1 = _pickedImage;
  }

  imagePickFn2(File _pickedImage) async {
    _image2 = _pickedImage;
  }

  imagePickFn3(File _pickedImage) async {
    _image3 = _pickedImage;
  }

  Future _imgFromGallery(int x) async {
    final _pickedFile = await _imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 100);
    if (mounted)
      setState(() {
        if (_pickedFile != null) {
          if (x == 1) {
            _image1 = File(_pickedFile.path);
            imagePickFn1(_image1);
          } else if (x == 2) {
            _image2 = File(_pickedFile.path);
            imagePickFn2(_image2);
          } else if (x == 3) {
            _image3 = File(_pickedFile.path);
            imagePickFn3(_image3);
          }
        } else {
          print("no image selected");
        }
      });
  }

  Future _imgFromCamera(int x) async {
    final _pickedFile = await _imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 100);
    if (mounted)
      setState(() {
        if (_pickedFile != null) {
          if (x == 1) {
            _image1 = File(_pickedFile.path);
            imagePickFn1(_image1);
          } else if (x == 2) {
            _image2 = File(_pickedFile.path);
            imagePickFn2(_image2);
          } else if (x == 3) {
            _image3 = File(_pickedFile.path);
            imagePickFn1(_image3);
          }
        } else {
          print("no image selected");
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(border: Border.all(width: 2)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Picture of Hand in Sunlight"),
            Center(
              child: Container(
                // alignment: Alignment.center,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: DropdownButton(
                        hint: Text(
                          "Add image",
                          style: TextStyle(color: Colors.black),
                        ),
                        dropdownColor: Colors.blue,
                        items: [
                          DropdownMenuItem(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Camera",
                                      style: TextStyle(color: Colors.white)),
                                  Icon(Icons.camera, color: Colors.white)
                                ]),
                            value: 0,
                          ),
                          DropdownMenuItem(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Gallery",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.image,
                                    color: Colors.white,
                                  )
                                ]),
                            value: 1,
                          ),
                        ],
                        onChanged: (value) {
                          if (value == 0) {
                            _imgFromCamera(1);
                          } else {
                            _imgFromGallery(1);
                          }
                        },
                      ),
                    ),
                    if (_image1 != null)
                      Container(
                        child: Image.file(
                          _image1,
                          width: 230,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: Icon(
                          Icons.cancel,
                        ),
                        onPressed: () {
                          setState(() {
                            _image1 = null;
                          });
                        },
                      ),
                    )
                  ],
                ),
                width: 220,
                height: 200,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
              ),
            ),
            Text("Picture of Hand in Room light"),
            Center(
              child: Container(
                // alignment: Alignment.center,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: DropdownButton(
                        hint: Text(
                          "Add image",
                          style: TextStyle(color: Colors.black),
                        ),
                        dropdownColor: Colors.blue,
                        items: [
                          DropdownMenuItem(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Camera",
                                      style: TextStyle(color: Colors.white)),
                                  Icon(Icons.camera, color: Colors.white)
                                ]),
                            value: 0,
                          ),
                          DropdownMenuItem(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Gallery",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.image,
                                    color: Colors.white,
                                  )
                                ]),
                            value: 1,
                          ),
                        ],
                        onChanged: (value) {
                          if (value == 0) {
                            _imgFromCamera(2);
                          } else {
                            _imgFromGallery(2);
                          }
                        },
                      ),
                    ),
                    if (_image2 != null)
                      Container(
                        child: Image.file(
                          _image2,
                          width: 230,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: Icon(
                          Icons.cancel,
                        ),
                        onPressed: () {
                          setState(() {
                            _image2 = null;
                          });
                        },
                      ),
                    )
                  ],
                ),
                width: 220,
                height: 200,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
              ),
            ),
            Text("Hand Tracing, If reqired"),
            Center(
              child: Container(
                // alignment: Alignment.center,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: DropdownButton(
                        hint: Text(
                          "Add image",
                          style: TextStyle(color: Colors.black),
                        ),
                        dropdownColor: Colors.blue,
                        items: [
                          DropdownMenuItem(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Camera",
                                      style: TextStyle(color: Colors.white)),
                                  Icon(Icons.camera, color: Colors.white)
                                ]),
                            value: 0,
                          ),
                          DropdownMenuItem(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Gallery",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.image,
                                    color: Colors.white,
                                  )
                                ]),
                            value: 1,
                          ),
                        ],
                        onChanged: (value) {
                          if (value == 0) {
                            _imgFromCamera(3);
                          } else {
                            _imgFromGallery(3);
                          }
                        },
                      ),
                    ),
                    if (_image3 != null)
                      Container(
                        child: Image.file(
                          _image3,
                          width: 230,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: Icon(
                          Icons.cancel,
                        ),
                        onPressed: () {
                          setState(() {
                            _image3 = null;
                          });
                        },
                      ),
                    )
                  ],
                ),
                width: 220,
                height: 200,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
              ),
            ),
          ]),
    );
  }
}
