import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
  final int imageQuality;
  final void Function(
    File _pickedImage,
  ) imagePickFn;
  PickImage(this.imagePickFn, this.imageQuality);
  @override
  _PickImageState createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File _image;

  final _imagePicker = ImagePicker();
  Future _imgFromCamera() async {
    final _pickedFile = await _imagePicker.getImage(
      source: ImageSource.camera,
      imageQuality: widget.imageQuality,
    );
    setState(() {
      if (_pickedFile != null) {
        _image = File(_pickedFile.path);
        widget.imagePickFn(
          _image,
        );
      } else {
        print("no image selected");
      }
    });
  }

  Future _imgFromGallery() async {
    final _pickedFile = await _imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: widget.imageQuality);
    setState(() {
      if (_pickedFile != null) {
        _image = File(_pickedFile.path);
        widget.imagePickFn(_image);
      } else {
        print("no image selected");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.center,
              height: 100,
              width: 100,
              margin: EdgeInsets.only(top: 8, right: 10),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
              ),
              child: _image == null
                  ? Text(
                      "Select an Image",
                      textAlign: TextAlign.center,
                    )
                  : Image.file(
                      _image,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
            ),
            DropdownButton(
              hint: Text(
                "Add image",
              ),
              dropdownColor: Colors.blue,
              items: [
                DropdownMenuItem(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Camera", style: TextStyle(color: Colors.white)),
                        Icon(Icons.camera, color: Colors.white)
                      ]),
                  value: 0,
                ),
                DropdownMenuItem(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                )
              ],
              onChanged: (value) {
                if (value == 0) {
                  _imgFromCamera();
                } else {
                  _imgFromGallery();
                }
              },
            )
          ],
        ));
  }
}
