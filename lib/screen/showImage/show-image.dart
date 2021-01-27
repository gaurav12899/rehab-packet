import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  static const routeName = '/show-image';
  ShowImage(this.url);
  final url;

  @override
  Widget build(BuildContext context) {
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
