import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:project/screen/homeScreen/home_screen.dart';
import 'package:intl/intl.dart';
import 'package:project/screen/homeScreen/new-or-old-patient.dart';
import 'package:project/screen/profile/editProfile.dart';

class Profile extends StatefulWidget {
  static const routeName = "/profile";

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var profileInfo = {
    'name': '',
    'address': '',
    'email': '',
    'phone': '',
    'dob': 'Date of birth',
    'gender': ''
  };
  static const _genderList = ['male', 'female', 'others'];
  String _selectedGender;
  var _formKey = GlobalKey<FormState>();
  _tryTOSubmit() async {
    _formKey.currentState.save();
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
              icon: Icon(Icons.edit, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProfile.routeName);
              },
            )
        ],
      ),
      body: Container(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
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
                                width: 130,
                                height: 130,
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
                            ListTile(
                              leading: (_readOnly)
                                  ? Text(
                                      '${profileInfo["sex"]}',
                                    )
                                  : DropdownButton(
                                      value: _selectedGender,
                                      items: _genderList.map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          _selectedGender = val;
                                          profileInfo['gender'] =
                                              _selectedGender;
                                          print(_selectedGender);
                                        });
                                      },
                                    ),
                              trailing: (_readOnly)
                                  ? Image(
                                      image: AssetImage(
                                        'assets/images/others.png',
                                      ),
                                      width: 40,
                                      height: 40,
                                    )
                                  : Container(
                                      width: size.width * .2,
                                    ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            buildTextFormField("Phone", 'phone'),
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
                            buildTextFormField("Pincode", 'pincode'),
                            SizedBox(
                              height: 10,
                            ),
                            buildTextFormField('E-mail', 'email'),
                            SizedBox(
                              height: 10,
                            ),
                            buildTextFormField('Height', 'height'),
                            SizedBox(
                              height: 10,
                            ),
                            buildTextFormField('Weight', 'weight'),
                            SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              leading: Text(
                                "${profileInfo['dob']}",
                              ),
                              trailing: (!_readOnly)
                                  ? GestureDetector(
                                      child: Icon(Icons.calendar_today),
                                      onTap: () => _chooseDate(context),
                                    )
                                  : Container(
                                      width: size.width * .2,
                                    ),
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

  Text buildTextFormField(String labelText, String fieldName) {
    return Text("Hello");
  }
}
