import 'dart:io';
import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/screen/profile/profile.dart';

class EditProfile extends StatefulWidget {
  static const routeName = "/editprofile";

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File _image;

  final _imagePicker = ImagePicker();
  imagePickFn(File _pickedImage) async {
    _image = _pickedImage;
  }

  Future _imgFromGallery() async {
    final _pickedFile = await _imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 80);
    if (mounted)
      setState(() {
        if (_pickedFile != null) {
          _image = File(_pickedFile.path);
          imagePickFn(_image);
        } else {
          print("no image selected");
        }
      });
  }

  static const _genderList = ['male', 'female', 'others'];
  String fname,
      lname,
      address,
      email,
      phone,
      dob,
      gender,
      state,
      qualification,
      imageUrl;
  String url;

  _tryTOSubmit(Map profileInfo) async {
    _formKey.currentState.save();
    if (_image != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child(FirebaseAuth.instance.currentUser.uid.toString())
          .child("${profileInfo['firstName']}.jpg");

      await ref.putFile(_image);
      url = await ref.getDownloadURL();
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid.toString())
        .update({
      'firstName': fname ?? profileInfo['firstName'],
      'lastName': lname ?? profileInfo['lastName'],
      'address': address ?? profileInfo['address'],
      'emailID': email ?? profileInfo['email'],
      'phone': phone ?? profileInfo['phone'],
      'dob': dob ?? profileInfo['dob'],
      'gender': gender ?? profileInfo['gender'],
      'qualification': qualification ?? profileInfo['qualification'],
      'state': state ?? profileInfo['state'],
      'profileUrl': url ?? profileInfo['profileUrl']
    });
  }

  bool _readOnly = true;
  DateTime _selectedDate;
  DateTime _date = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  String _selectedGender;

  _chooseDate(BuildContext context, Map profileInfo) async {
    await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1940),
        lastDate: DateTime(_date.year + 1),
        builder: (BuildContext context, Widget child) {
          return Theme(
              data: ThemeData(
                  primaryColor: Colors.blue, accentColor: Colors.grey),
              child: child);
        }).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        if (mounted)
          setState(() {
            _selectedDate = pickedDate;
            dob = DateFormat.yMMMd().format(_selectedDate);
          });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;

    final size = MediaQuery.of(context).size;

    // profileInfo['gender'];

    var profileInfo = {
      'firstName': '',
      'address': '',
      'email': '',
      'phone': '',
      'dob': '',
      'gender': '',
      'qualification': '',
      'state': '',
      'lastName': '',
      'profileUrl': '',
    };
    profileInfo['firstName'] = args['firstName'];
    profileInfo['address'] = args['address'];
    profileInfo['email'] = args['emailID'];
    profileInfo['phone'] = args['phone'];
    profileInfo['dob'] = args['dob'];
    profileInfo['gender'] = args['gender'];
    profileInfo['qualification'] = args['qualification'];
    profileInfo['state'] = args['state'];
    profileInfo['lastName'] = args['lastName'];
    String alreadySelectedGender = profileInfo['gender'];
    profileInfo['profileUrl'] = args['profileUrl'];
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context)
                .pushNamedAndRemoveUntil(Profile.routeName, (route) => false)),
        actions: [
          if (_readOnly)
            IconButton(
              padding: EdgeInsets.symmetric(horizontal: 20),
              icon: Icon(Icons.save, color: Colors.white),
              onPressed: () {
                if (mounted)
                  setState(() {
                    _readOnly = false;
                  });
              },
            )
        ],
      ),
      body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus.unfocus();
            }
          },
          child: Form(
            key: _formKey,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.blueGrey,
                          child: Stack(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: (_image != null)
                                          ? FileImage(_image)
                                          : (profileInfo['profileUrl'] != '')
                                              ? NetworkImage(args['profileUrl'])
                                              : _image != null
                                                  ? FileImage(_image)
                                                  : AssetImage(
                                                      'assets/images/doctor.png'),
                                    ),
                                  ),
                                  height: 250,
                                  width: double.infinity,
                                  child: ClipRect(
                                    child: BackdropFilter(
                                      child: Container(
                                        decoration: new BoxDecoration(
                                          color: Colors.white.withOpacity(0.0),
                                        ),
                                      ),
                                      filter: ImageFilter.blur(
                                          sigmaX: 3.0, sigmaY: 3.0),
                                    ),
                                  )),
                              Container(
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 20,
                                      child: Container(
                                        width: 170,
                                        height: 170,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 4,
                                            color: Colors.white,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                                spreadRadius: 2,
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                blurRadius: 10,
                                                offset: Offset(0, 10)),
                                          ],
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: (_image != null)
                                                ? FileImage(_image)
                                                : (profileInfo['profileUrl'] !=
                                                        '')
                                                    ? NetworkImage(
                                                        args['profileUrl'])
                                                    : _image != null
                                                        ? FileImage(_image)
                                                        : AssetImage(
                                                            'assets/images/doctor.png'),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 125,
                                        left: 125,
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blue,
                                            border: Border.all(
                                                width: 4, color: Colors.white),
                                          ),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              _imgFromGallery();
                                            },
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 0.0),
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            bottom: 3, left: 10),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        hintText: profileInfo['firstName'],
                                        labelText: "First Name",
                                        hintStyle: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                      onChanged: (val) {
                                        print(val);
                                        if (mounted)
                                          setState(() {
                                            fname = val;
                                          });
                                        print(profileInfo['firstName']);
                                      },
                                      enableInteractiveSelection: false,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 0.0),
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            bottom: 3, left: 10),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        hintText: profileInfo['lastName'],
                                        labelText: "Last Name",
                                        hintStyle: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                      onChanged: (val) {
                                        if (mounted)
                                          setState(() {
                                            lname = val;
                                          });
                                      },
                                      enableInteractiveSelection: false,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)),
                                child: ListTile(
                                    leading: DropdownButton(
                                      value: _selectedGender ??
                                          alreadySelectedGender,
                                      items: _genderList.map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(
                                            value.toUpperCase(),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        if (mounted)
                                          setState(() {
                                            _selectedGender = val;
                                            gender = _selectedGender;
                                          });
                                      },
                                    ),
                                    trailing: Image(
                                      image: AssetImage(
                                        'assets/images/${_selectedGender ?? alreadySelectedGender}.png',
                                      ),
                                      width: 40,
                                      height: 40,
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 0.0),
                                  ),
                                  contentPadding:
                                      EdgeInsets.only(bottom: 3, left: 10),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: profileInfo['phone'],
                                  labelText: "Phone",
                                  hintStyle: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                onChanged: (val) {
                                  if (mounted)
                                    setState(() {
                                      phone = val;
                                    });
                                },
                                keyboardType: TextInputType.number,
                                enableInteractiveSelection: false,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 0.0),
                                  ),
                                  contentPadding:
                                      EdgeInsets.only(bottom: 3, left: 10),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: profileInfo['email'],
                                  labelText: "Email",
                                  hintStyle: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                onChanged: (val) {
                                  print(val);
                                  if (mounted)
                                    setState(() {
                                      email = val;
                                    });
                                },
                                enableInteractiveSelection: false,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 0.0),
                                  ),
                                  contentPadding:
                                      EdgeInsets.only(bottom: 3, left: 10),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: profileInfo['qualification'],
                                  labelText: "Qualification",
                                  hintStyle: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                onChanged: (val) {
                                  qualification = val;
                                },
                                enableInteractiveSelection: false,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 0.0),
                                  ),
                                  contentPadding:
                                      EdgeInsets.only(bottom: 3, left: 10),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: profileInfo['address'],
                                  labelText: "Address",
                                  hintStyle: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                onChanged: (val) {
                                  if (mounted)
                                    setState(() {
                                      address = val;
                                    });
                                },
                                enableInteractiveSelection: false,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 0.0),
                                  ),
                                  contentPadding:
                                      EdgeInsets.only(bottom: 3, left: 10),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: profileInfo['state'],
                                  labelText: "State",
                                  hintStyle: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                onChanged: (val) {
                                  state = val;
                                },
                                enableInteractiveSelection: false,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)),
                                child: ListTile(
                                    leading: ((profileInfo['dob'] == '') &&
                                            dob == null)
                                        ? Text("DOB")
                                        : Text(
                                            dob ?? profileInfo['dob'],
                                            style: TextStyle(fontSize: 20),
                                          ),
                                    trailing: GestureDetector(
                                        child: Icon(
                                          Icons.calendar_today,
                                          color: Colors.blue,
                                        ),
                                        onTap: () {
                                          if (mounted)
                                            setState(() {
                                              _chooseDate(context, profileInfo);
                                            });
                                        })),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  if (!_readOnly)
                    Container(
                      // margin:
                      //     EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      height: MediaQuery.of(context).size.height * .1,
                      color: Colors.blueGrey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: size.width * .4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue.shade50,
                            ),
                            child: TextButton(
                              child: Text("Cancel"),
                              onPressed: () {
                                if (mounted)
                                  setState(() {
                                    _readOnly = true;
                                  });
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    Profile.routeName, (route) => false);
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: size.width * .4,
                            child: TextButton(
                              child: Text(
                                "Update",
                                style: GoogleFonts.lato(color: Colors.white),
                              ),
                              onPressed: () {
                                _tryTOSubmit(profileInfo);
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    Profile.routeName, (route) => false);
                              },
                            ),
                          )
                        ],
                      ),
                    )
                ],
              ),
            ),
          )),
    );
  }
}
