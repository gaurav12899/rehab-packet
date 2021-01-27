import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/screen/homeScreen/new-or-old-patient.dart';
import 'package:project/screen/showImage/show-image.dart';
import 'package:project/view_pdf/select_form.dart';
import 'package:project/widgets/skeletonContainer.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfList extends StatefulWidget {
  static const routeName = '/pdfList';

  @override
  _PdfListState createState() => _PdfListState();
}

class _PdfListState extends State<PdfList> {
  bool _isLoading = false;
  TextEditingController _searchController = TextEditingController();
  List _allPatient = [];
  Future resultLoaded;
  List _searchResultList = [];
  @override
  void initState() {
    setState(() {
      resultLoaded = getUsers();
    });
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  _onSearchChanged() {
    generateSearchResultList();
    print(_searchController.text);
  }

  getUsers() async {
    if (mounted)
      setState(() {
        _isLoading = true;
      });
    var data = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid.toString())
        .collection("username")
        .get();
    if (mounted)
      setState(() {
        _isLoading = false;
        _allPatient = data.docs;
      });
    generateSearchResultList();
    return "complete";
  }

  generateSearchResultList() {
    var showResult = [];
    if (_searchController.text != '') {
      for (var patient in _allPatient) {
        var _patientName = patient['name'].toLowerCase();
        if (_patientName.contains(_searchController.text.toLowerCase())) {
          showResult.add(patient);
        }
      }
    } else {
      showResult = List.from(_allPatient);
    }

    if (mounted)
      setState(() {
        _searchResultList = showResult;
      });
  }

  _makingPhoneCall(phone) async {
    var url = 'tel:+91$phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List x;
  formList(String user) async {
    var list = [];
    final result = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid.toString())
        .collection("username")
        .doc(user)
        .collection('formname')
        .get();
    // .then((value) => value.docs.forEach((element) {
    //       list.add(element.documentID);
    //     }));
    final List<DocumentSnapshot> documents = result.docs;
    documents.forEach((data) => list.add(data.id));
    return list;
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
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Patient Names'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, NewOrOldPatient.routeName, (route) => false);
              }),
        ),
        body: _isLoading
            ? buildSkeleton(context)
            : Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Container(
                        color: Colors.white,
                        child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                hintText: "Search your patient Name...",
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
                          return GestureDetector(
                            onLongPress: () {
                              return showDialog(
                                  context: context,
                                  builder: (BuildContext ctx) {
                                    return AlertDialog(
                                      title: Text('Are you sure?'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text(
                                                'Patient record will be deleted Permanently'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('cancel'),
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text(
                                            'Delete',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          onPressed: () async {
                                            x = await formList(
                                                _searchResultList[index]
                                                    .documentID);
                                            await FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(FirebaseAuth
                                                    .instance.currentUser.uid
                                                    .toString())
                                                .collection("username")
                                                .doc(_searchResultList[index]
                                                    .documentID)
                                                .delete();
                                            if (x.length > 0) {
                                              x.forEach((element) async {
                                                await FirebaseStorage.instance
                                                    .ref()
                                                    .child(FirebaseAuth.instance
                                                        .currentUser.uid
                                                        .toString())
                                                    .child(
                                                        _searchResultList[index]
                                                            .documentID)
                                                    .child("$element.pdf")
                                                    .delete();
                                              });
                                            }

                                            setState(() {
                                              resultLoaded = getUsers();

                                              Navigator.of(ctx).pop();
                                            });

                                            // });
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Column(
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
                                            width: 30,
                                            height: 30,
                                          ),
                                        ),
                                        title: Text(
                                            "${index + 1}. ${_searchResultList[index]["name"].toUpperCase()}",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            )),
                                        subtitle: Text(
                                            "Age:${_searchResultList[index]["age"].toUpperCase()}"),
                                      ),
                                      expandedCrossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          // color: Colors.blueGrey.shade300,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  Icons.picture_as_pdf,
                                                  color: Colors.red,
                                                  size: 50,
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        (SelectForm(
                                                            _searchResultList[
                                                                    index]
                                                                .documentID)),
                                                  ));
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.call,
                                                  color: Colors.green,
                                                  size: 50,
                                                ),
                                                onPressed: () {
                                                  _makingPhoneCall(
                                                      _searchResultList[index]
                                                          ["phone"]
                                                      // "989164151"
                                                      );
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Divider(),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        formDetail(index, "Age", 'age'),
                                        formDetail(index, "Gender", 'gender'),
                                        formDetail(index, "Address", 'address'),
                                        formDetail(index, "State", 'state'),
                                        formDetail(index, "Pincode", 'pincode'),
                                        formDetail(index, "Contact", 'contact'),
                                        formDetail(index, "Email", 'email'),
                                        formDetail(
                                            index, "Occupation", 'occupation'),
                                        formDetail(index, "Height", 'height'),
                                        formDetail(index, "Weight", 'weight'),
                                        formDetail(index, "Living Condition",
                                            'livingCondition'),
                                        formDetail(index, "ActivityLevel",
                                            'activityLevel'),
                                        formDetail(
                                            index, "Diagnosis", 'diagnosis'),
                                        formDetail(index, "Prescription",
                                            'prescription'),
                                        formDetail(index, "Past History",
                                            'pastHistory'),
                                        formDetail(index, "Occupation History",
                                            'occupationHistory'),
                                        formDetail(index, "Current Situation",
                                            'currentSituation'),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            if (_searchResultList[index]
                                                    ["imgUrl1"] !=
                                                null)
                                              GestureDetector(
                                                onTap: () => Navigator.push(
                                                    context, MaterialPageRoute(
                                                        builder: (context) {
                                                  return ShowImage(
                                                      _searchResultList[index]
                                                          ["imgUrl1"]);
                                                })),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border:
                                                          Border.all(width: 2)),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .27,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .2,
                                                  child: Hero(
                                                    tag: "img1",
                                                    child: Image.network(
                                                      _searchResultList[index]
                                                          ["imgUrl1"],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            if (_searchResultList[index]
                                                    ["imgUrl2"] !=
                                                null)
                                              GestureDetector(
                                                onTap: () => Navigator.push(
                                                    context, MaterialPageRoute(
                                                        builder: (context) {
                                                  return ShowImage(
                                                      _searchResultList[index]
                                                          ["imgUrl2"]);
                                                })),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border:
                                                          Border.all(width: 2)),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .27,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .2,
                                                  child: Hero(
                                                    tag: "img2",
                                                    child: Image.network(
                                                      _searchResultList[index]
                                                          ["imgUrl2"],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            if (_searchResultList[index]
                                                    ["imgUrl3"] !=
                                                null)
                                              GestureDetector(
                                                onTap: () => Navigator.push(
                                                    context, MaterialPageRoute(
                                                        builder: (context) {
                                                  return ShowImage(
                                                      _searchResultList[index]
                                                          ["imgUrl3"]);
                                                })),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border:
                                                          Border.all(width: 2)),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .27,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .2,
                                                  child: Hero(
                                                    tag: "img3",
                                                    child: Image.network(
                                                      _searchResultList[index]
                                                          ["imgUrl3"],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        formDetail(index, "Any Other Problem",
                                            'anyOtherProblem'),
                                        formDetail(index, 'Goals', 'goals'),
                                        formDetail(index, "Practitione Name",
                                            'practitionerName'),
                                        formDetail(
                                            index,
                                            'Practitioner Contact',
                                            'practitionerContact'),
                                        formDetail(index, 'Company', 'company'),
                                        formDetail(
                                            index, 'Location', 'location'),
                                        formDetail(index, "Physician",
                                            'physicianName'),
                                        formDetail(index, "Physician",
                                            'physicianContact'),
                                        formDetail(index, "Department", 'dept'),
                                        formDetail(
                                            index, 'Hospital', 'hospital'),
                                        formDetail(
                                            index,
                                            'Currently Taking Medicines',
                                            'currentlyTakingMedicines'),
                                        formDetail(
                                            index, 'User Status', 'userStatus'),
                                        formDetail(
                                            index,
                                            'Physical demand before',
                                            'phyDemandBefore'),
                                        formDetail(
                                            index,
                                            'Physical demand after',
                                            'phyDemandAfter'),
                                        formDetail(index, 'Standing Before',
                                            'standingPerBefore'),
                                        formDetail(index, 'Standing After',
                                            'standingPerAfter'),
                                        formDetail(index, 'Lifting Before',
                                            'liftingBefore'),
                                        formDetail(index, 'Lifting After',
                                            'liftingAfter'),
                                        formDetail(index, 'Walking Before',
                                            'walkingBefore'),
                                        formDetail(index, 'walking After',
                                            'walkingAfter'),
                                        formDetail(
                                            index,
                                            'walking Transition Before',
                                            'walkingTrainsBefore'),
                                        formDetail(
                                            index,
                                            'walking Transition After',
                                            'walkingTrainsAfter'),
                                      ],
                                    ),
                                  ),
                                ),

                                // Divider()
                              ],
                            ),
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

  formDetail(int index, String heading, String dbfield) {
    return Container(
      color: Colors.blue,
      padding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      width: MediaQuery.of(context).size.width,
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "$heading :",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${_searchResultList[index]["$dbfield"]}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

Widget buildSkeleton(BuildContext context) => ListView.separated(
    itemBuilder: (context, index) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SkeletonContainer.square(
              width: 70,
              height: 70,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SkeletonContainer.rounded(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 25,
                ),
                const SizedBox(height: 8),
                SkeletonContainer.rounded(
                  width: 60,
                  height: 13,
                ),
              ],
            ),
            SkeletonContainer.square(
              width: 15,
              height: 15,
            )
          ],
        ),
      );
    },
    separatorBuilder: (context, index) => Divider(),
    itemCount: 10);
