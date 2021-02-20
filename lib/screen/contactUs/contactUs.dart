import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/screen/homeScreen/app-drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hexcolor/hexcolor.dart';

class ContactUs extends StatefulWidget {
  static const routeName = '/contactUs';

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  List<String> attachments = [];

  final _subjectController = TextEditingController(text: 'The subject');

  final _bodyController = TextEditingController(
    text: 'Mail body.',
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> send() async {
    final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: ["tarunsaini1510@gmail.com"],
      attachmentPaths: attachments,
      isHTML: false,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      home: Scaffold(
        backgroundColor: HexColor('4A6572'),
        drawer: AppDrawer(
          home: true,
          aboutUs: true,
          contactUs: false,
          myPatient: true,
          profile: true,
        ),
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Contact Us'),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(0),
              child: Column(
                mainAxisSize: MainAxisSize.max,

                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Container(
                  //   color: Colors.white,
                  //   child: Image(
                  //     image: AssetImage("assets/images/Rehab-without-bg.png"),
                  //     // width: 150,
                  //     height: 150,
                  //   ),
                  // ),
                  Card(
                    color: Colors.white,
                    elevation: 10,
                    child: ListTile(
                      title: Align(
                        alignment: Alignment.topLeft,
                        child: Chip(
                          backgroundColor: Colors.blue.shade100,
                          label: Text(
                            "+91 9315414056",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      leading: Text(
                        "Call us",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 20),
                      ),
                      trailing: Container(
                        child: Card(
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(400)),
                          color: Colors.blue,
                          child: IconButton(
                            color: Colors.white,
                            icon: Icon(
                              Icons.call,
                              // color: Colors.blue,
                            ),
                            onPressed: () async {
                              const url = 'tel:+919315414056';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .9,
                    child: Card(
                      color: Colors.white,
                      child: LayoutBuilder(builder: (context, constraint) {
                        return SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints(minHeight: constraint.maxHeight),
                            child: IntrinsicHeight(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "Mail us",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                          fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextField(
                                      style: TextStyle(color: Colors.black),
                                      controller: _subjectController,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.blue),
                                          ),
                                          border: OutlineInputBorder(),
                                          labelText: 'Subject',
                                          labelStyle:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextField(
                                        style: TextStyle(color: Colors.black),
                                        controller: _bodyController,
                                        maxLines: null,
                                        expands: true,
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.blue),
                                            ),
                                            border: OutlineInputBorder(),
                                            labelText: 'Emaill',
                                            labelStyle:
                                                TextStyle(color: Colors.black)),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        children: <Widget>[
                                          for (var i = 0;
                                              i < attachments.length;
                                              i++)
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    attachments[i],
                                                    softWrap: false,
                                                    overflow: TextOverflow.fade,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.remove_circle,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () =>
                                                      {_removeAttachment(i)},
                                                )
                                              ],
                                            ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              margin: EdgeInsets.all(10),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              width: 160,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.blue)),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Attach Files",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.blue),
                                                  ),
                                                  IconButton(
                                                    icon:
                                                        Icon(Icons.attach_file),
                                                    onPressed: _openImagePicker,
                                                    color: Colors.red,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => send(),
          label: Text(
            'Submit',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }

  void _openImagePicker() async {
    final pick = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 80);
    if (pick != null) {
      setState(() {
        attachments.add(pick.path);
      });
    }
  }

  void _removeAttachment(int index) {
    setState(() {
      attachments.removeAt(index);
    });
  }
}
