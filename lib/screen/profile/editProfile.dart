import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:project/screen/homeScreen/home_screen.dart';
import 'package:intl/intl.dart';
import 'package:project/screen/homeScreen/new-or-old-patient.dart';

class EditProfile extends StatefulWidget {
  static const routeName = "/editprofile";

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var profileInfo = {
    'name': '',
    'address': '',
    'email': '',
    'phone': '',
    'dob': 'Date of birth',
    'gender': '',
    'qualification': '',
    'state': '',
  };
  static const _genderList = ['male', 'female', 'others'];
  String _selectedGender;
  var _formKey = GlobalKey<FormState>();
  _tryTOSubmit() async {
    if (_formKey.currentState.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      _formKey.currentState.save();

      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));
    }
    print(profileInfo['name']);
    print(profileInfo['email']);
    print(profileInfo['dob']);
  }

  bool _readOnly = true;
  DateTime _selectedDate;
  DateTime _date = DateTime.now();
  _chooseDate(BuildContext context) async {
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
        setState(() {
          _selectedDate = pickedDate;
          profileInfo['dob'] = DateFormat.yMMMd().format(_selectedDate);
        });
      },
    );
  }

  DateTime _dateTime = DateTime.now();
  DateTime _pickedDate;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: _readOnly ? Text("Profile") : Text("Edit Profile"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () =>
              Navigator.of(context).pushNamed(NewOrOldPatient.routeName),
        ),
        actions: [
          if (_readOnly)
            IconButton(
              padding: EdgeInsets.symmetric(horizontal: 20),
              icon: Icon(Icons.save, color: Colors.white),
              onPressed: () {
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
                      child: Center(
                        child: Container(
                          child: Stack(
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 4,
                                    color: Colors.grey,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 2,
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10,
                                        offset: Offset(0, 10)),
                                  ],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage('assets/images/doctor.png'),
                                  ),
                                ),
                              ),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue,
                                      border: Border.all(
                                          width: 4, color: Colors.white),
                                    ),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: buildTextFormField(
                                        "First Name", 'firstName')),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: buildTextFormField(
                                        "Last Name", 'LastName')),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              child: ListTile(
                                  leading:
                                      //  (_readOnly)
                                      //     ? Text(
                                      //         '${profileInfo["sex"]}',
                                      //       )
                                      DropdownButton(
                                    value: _selectedGender,
                                    items: _genderList.map((value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(
                                          value.toUpperCase(),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        _selectedGender = val;
                                        profileInfo['gender'] = _selectedGender;

                                        print(_selectedGender);
                                      });
                                    },
                                  ),
                                  trailing: Image(
                                    image: AssetImage(
                                      'assets/images/$_selectedGender.png',
                                    ),
                                    width: 40,
                                    height: 40,
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            buildTextFormField("Phone", 'phone'),
                            SizedBox(
                              height: 10,
                            ),
                            buildTextFormField('E-mail', 'email'),
                            SizedBox(
                              height: 10,
                            ),
                            buildTextFormField("Address", 'address'),
                            SizedBox(
                              height: 10,
                            ),
                            buildTextFormField("State", 'state'),
                            SizedBox(
                              height: 10,
                            ),
                            buildTextFormField(
                                "Qualification", 'qualification'),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              child: ListTile(
                                  leading: Text(
                                    "${profileInfo['dob']}",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  trailing: GestureDetector(
                                    child: Icon(
                                      Icons.calendar_today,
                                      color: Colors.blue,
                                    ),
                                    onTap: () => _chooseDate(context),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              if (!_readOnly)
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: size.width * .3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue.shade50,
                        ),
                        child: TextButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            setState(() {
                              _readOnly = true;
                            });
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: size.width * .3,
                        child: TextButton(
                          child: Text(
                            "Update",
                            style: GoogleFonts.lato(color: Colors.white),
                          ),
                          onPressed: () {
                            _tryTOSubmit();
                          },
                        ),
                      )
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildTextFormField(
    String labelText,
    String fieldName,
  ) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 0.0),
        ),
        contentPadding: EdgeInsets.only(bottom: 3, left: 10),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefix: (fieldName == 'phone') ? Text("+91:") : null,
        labelText: labelText,
        hintStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      onSaved: (value) {
        profileInfo[fieldName] = value;
      },
      enableInteractiveSelection: false,
      keyboardType:
          (fieldName == 'phone') ? TextInputType.phone : TextInputType.text,
    );
  }
}
