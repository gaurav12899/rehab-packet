// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';

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

// class PdfScreen extends StatefulWidget {
//   static const routeName = '/pdfscreen';
//   PdfScreen(this.link);
//   final String link;
//   @override
//   _PdfScreenState createState() => _PdfScreenState();
// }

// class _PdfScreenState extends State<PdfScreen> with WidgetsBindingObserver {
//   String remotePDFpath = "";

//   @override
//   void initState() {
//     super.initState();
//     createFileOfPdfUrl().then((f) {
//       setState(() {
//         remotePDFpath = f.path;
//       });
//     });
//   }

//   final Completer<PDFViewController> _controller =
//       Completer<PDFViewController>();
//   int pages = 0;
//   int currentPage = 0;
//   bool isReady = false;
//   String errorMessage = '';

//   Future<File> createFileOfPdfUrl() async {
//     Completer<File> completer = Completer();
//     print("Start download file from internet!");
//     try {
//       // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
//       // final url = "https://pdfkit.org/docs/guide.pdf";
//       final url =
//           "https://firebasestorage.googleapis.com/v0/b/raheb-pocket.appspot.com/o/1611906599983355_AlgM4AOrakNmp6udsvm6B3uSdsH3%2FSpinalOrthosis.pdf?alt=media&token=277197d0-c2b1-4544-8ed9-6b7367c36cc2";
//       final filename = url.substring(url.lastIndexOf("/") + 1);
//       var request = await HttpClient().getUrl(Uri.parse(url));
//       var response = await request.close();
//       var bytes = await consolidateHttpClientResponseBytes(response);
//       var dir = await getApplicationDocumentsDirectory();
//       print("Download files");
//       print("${dir.path}/$filename");
//       File file = File("${dir.path}/$filename");

//       await file.writeAsBytes(bytes, flush: true);
//       completer.complete(file);
//     } catch (e) {
//       throw Exception('Error parsing asset file!');
//     }

//     return completer.future;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Document"),
//           actions: <Widget>[
//             IconButton(
//               icon: Icon(Icons.share),
//               onPressed: () {},
//             ),
//           ],
//         ),
//         body: Stack(
//           children: <Widget>[
//             PDFView(
//               filePath:
//                   "https://firebasestorage.googleapis.com/v0/b/raheb-pocket.appspot.com/o/1611906599983355_AlgM4AOrakNmp6udsvm6B3uSdsH3%2FSpinalOrthosis.pdf?alt=media&token=277197d0-c2b1-4544-8ed9-6b7367c36cc2",
//               enableSwipe: true,
//               swipeHorizontal: true,
//               autoSpacing: false,
//               pageFling: true,
//               pageSnap: true,
//               defaultPage: currentPage,
//               fitPolicy: FitPolicy.BOTH,
//               preventLinkNavigation:
//                   false, // if set to true the link is handled in flutter
//               onRender: (_pages) {
//                 setState(() {
//                   pages = _pages;
//                   isReady = true;
//                 });
//               },
//               onError: (error) {
//                 setState(() {
//                   errorMessage = error.toString();
//                 });
//                 print(error.toString());
//               },
//               onPageError: (page, error) {
//                 setState(() {
//                   errorMessage = '$page: ${error.toString()}';
//                 });
//                 print('$page: ${error.toString()}');
//               },
//               onViewCreated: (PDFViewController pdfViewController) {
//                 _controller.complete(pdfViewController);
//               },
//               onLinkHandler: (String uri) {
//                 print('goto uri: $uri');
//               },
//               onPageChanged: (int page, int total) {
//                 print('page change: $page/$total');
//                 setState(() {
//                   currentPage = page;
//                 });
//               },
//             ),
//             errorMessage.isEmpty
//                 ? !isReady
//                     ? Center(
//                         child: CircularProgressIndicator(),
//                       )
//                     : Container()
//                 : Center(
//                     child: Text(errorMessage),
//                   )
//           ],
//         ),
//         floatingActionButton: FutureBuilder<PDFViewController>(
//             future: _controller.future,
//             builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
//               if (snapshot.hasData) {
//                 return FloatingActionButton.extended(
//                   label: Text("Go to ${pages ~/ 2}"),
//                   onPressed: () async {
//                     await snapshot.data.setPage(pages ~/ 2);
//                   },
//                 );
//               }

//               return Container();
//             }));
//   }
// }
