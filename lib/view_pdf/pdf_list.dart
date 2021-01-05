import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/view_pdf/select_form.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfList extends StatefulWidget {
  static const routeName = '/pdfList';

  @override
  _PdfListState createState() => _PdfListState();
}

class _PdfListState extends State<PdfList> {
  TextEditingController _searchController = TextEditingController();
  List _allPatient = [];
  Future resultLoaded;
  List _searchResultList = [];
  @override
  void initState() {
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  _onSearchChanged() {
    generateSearchResultList();
    print(_searchController.text);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultLoaded = getUsers();
  }

  getUsers() async {
    var data = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid.toString())
        .collection("username")
        .get();
    setState(() {
      _allPatient = data.docs;
      print(_allPatient[0]['name']);
    });
    generateSearchResultList();
    return "complete";
  }

  generateSearchResultList() {
    var showResult = [];
    if (_searchController.text != '') {
      for (var patient in _allPatient) {
        var _patientName = patient['name'].toLowerCase();
        print(_patientName);
        if (_patientName.contains(_searchController.text.toLowerCase())) {
          showResult.add(patient);
        }
      }
    } else {
      showResult = List.from(_allPatient);
    }

    setState(() {
      _searchResultList = showResult;
    });
  }

  _makingPhoneCall() async {
    const url = 'tel:9876543210';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentscope = FocusScope.of(context);
        if (!currentscope.hasPrimaryFocus) {
          currentscope.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Patient Names'),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Container(
                  color: Colors.white,
                  child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search your patient...",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: BorderSide(
                                width: 4,
                              )))),
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _searchResultList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: ExpansionTile(
                              title: ListTile(
                                // tileColor: Colors.blue.shade200,
                                leading: Container(
                                  child: SvgPicture.asset(
                                    'assets/images/patient.svg',
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                title: Text(
                                    "${index + 1}. ${_searchResultList[index]["name"].toUpperCase()}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    )),
                                subtitle: Text(
                                    "Age:${_searchResultList[index]["age"].toUpperCase()}"),
                              ),
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.picture_as_pdf,
                                        color: Colors.red,
                                        size: 40,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => (SelectForm(
                                              _searchResultList[index]
                                                  .documentID)),
                                        ));
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.call_outlined,
                                        color: Colors.green,
                                      ),
                                      onPressed: () {
                                        _makingPhoneCall();
                                      },
                                    )
                                  ],
                                ),
                                newMethod(index, "Age", 'age'),
                                newMethod(index, "Contact", 'contact'),
                                newMethod(index, "Occupation", 'occupation'),
                                newMethod(index, "Living Condition",
                                    'livingCondition'),
                                newMethod(index, "Address", 'address'),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    "Date: ${_searchResultList[index]["date"].toDate()}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                newMethod(index, "Pincode", 'pincode'),
                                newMethod(index, "Weight", 'weight'),
                                newMethod(index, "State", 'state'),
                              ],
                            ),
                          ),
                        ),
                        // Divider()
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding newMethod(int index, String heading, String dbfield) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        "$heading: ${_searchResultList[index]["$dbfield"].toUpperCase()}",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
