import 'package:flutter/material.dart';
import 'package:share/share.dart';

class SharePdf extends StatefulWidget {
  static const routeName = 'sharePdf';
  final url;
  SharePdf(@required this.url);
  @override
  _SharePdfState createState() => _SharePdfState();
}

class _SharePdfState extends State<SharePdf> {
  String text = '';

  String subject = '';

  List<String> imagePaths = [];

  @override
  Widget build(BuildContext context) {
    // final String url = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Plugin Demo'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                labelText: 'Share text:',
                hintText: 'Enter some text and/or link to share',
              ),
              maxLines: 2,
              onChanged: (String value) => setState(() {
                text = value;
              }),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Share subject:',
                hintText: 'Enter Url',
              ),
              maxLines: 2,
              onChanged: (String value) => setState(() {
                subject = value;
              }),
            ),
            const Padding(padding: EdgeInsets.only(top: 12.0)),
            // ImagePreviews(imagePaths, onDelete: _onDeleteImage),

            const Padding(padding: EdgeInsets.only(top: 12.0)),
            Builder(
              builder: (BuildContext context) {
                return RaisedButton(
                  child: const Text('Share'),
                  onPressed: text.isEmpty && imagePaths.isEmpty
                      ? null
                      : () => _onShare(context),
                );
              },
            ),
            const Padding(padding: EdgeInsets.only(top: 12.0)),
            Builder(
              builder: (BuildContext context) {
                return RaisedButton(
                  child: const Text('Share'),
                  onPressed: () => _onShareWithEmptyOrigin(context),
                );
              },
            ),
          ],
        ),
      )),
    );
  }

  _onShare(BuildContext context) async {
    // A builder is used to retrieve the context immediately
    // surrounding the RaisedButton.
    //
    // The context's `findRenderObject` returns the first
    // RenderObject in its descendent tree when it's not
    // a RenderObjectWidget. The RaisedButton's RenderObject
    // has its position and size after it's built.
    final RenderBox box = context.findRenderObject();

    if (imagePaths.isNotEmpty) {
      await Share.shareFiles(imagePaths,
          text: text,
          subject: subject,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    } else {
      await Share.share(text,
          subject: subject,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }

  _onShareWithEmptyOrigin(BuildContext context) async {
    await Share.share("text");
  }
}
