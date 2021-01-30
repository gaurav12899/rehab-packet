import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
// import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
// import './sharePdf.dart';

class PdfScreen extends StatefulWidget {
  PdfScreen(this.link);
  final String link;
  static const routeName = '/pdfscreen';

  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  bool _isLoading = true;
  PDFDocument document;
  // final url;

  @override
  void initState() {
    super.initState();
    changePDF(widget.link);
  }

  loadDocument() async {
    document = await PDFDocument.fromAsset('assets/sample.pdf');

    setState(() => _isLoading = false);
  }

  changePDF(url) async {
    setState(() => _isLoading = true);

    document = await PDFDocument.fromURL(
      url,
      cacheManager: CacheManager(
        Config(
          "customCacheKey",
          stalePeriod: const Duration(days: 2),
          maxNrOfCacheObjects: 10,
        ),
      ),
    );

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form'),
        actions: [
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () async {
                await Share.share(
                  widget.link,
                );
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => (SharePdf(widget.link))));
              })
        ],
      ),
      body: Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : PDFViewer(
                document: document,
                zoomSteps: 1,
              ),
      ),
    );
  }
}
