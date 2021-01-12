import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  static const routeName = '/show-image';
  @override
  Widget build(BuildContext context) {
    var url = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text("Image Preview"),
        ),
        body: Center(
          child: Hero(
            tag: "img1",
            child: Image.network(url),
          ),
        ));
  }
}
