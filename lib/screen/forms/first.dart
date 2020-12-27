import 'package:flutter/material.dart';
import 'package:project/screen/forms/knee_form.dart';

class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("first"),
      ),
      body: Column(
        children: [
          TextField(),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(KneeForm.routeName);
            },
            child: Text("Next"),
          )
        ],
      ),
    );
  }
}
