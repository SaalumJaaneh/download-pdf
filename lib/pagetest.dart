import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class LisaanuShukrii extends StatefulWidget {
  const LisaanuShukrii({super.key});

  @override
  State<LisaanuShukrii> createState() => _LisaanuShukriiState();
}

class _LisaanuShukriiState extends State<LisaanuShukrii> {
       //BannerAd? _bannerAd;
     
 // final String _adUnitId = 'ca-app-pub-3677873173815918/4292925616';
      

  @override
  void initState() {
    super.initState();
    //_loadAd();


    createFileOfPdfUrl().then((f) {
      setState(() {
        remotePDFpath = f.path;
      });
    });
  }



  String remotePDFpath = "";

 

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    try {
     
      const url = 'https://firebasestorage.googleapis.com/v0/b/doll-xasida.appspot.com/o/pdf%2F%D9%84%D8%B3%D8%A7%D9%86%20%D8%B4%D9%83%D8%B1%DB%92?alt=media&token=8b44f816-44dc-471e-b488-d4e694957d19';
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Lisaanu Shukrii '), centerTitle: true,
      
      ),
      body: 

 Center(child: Builder(
          builder: (BuildContext context) {
            return TextButton(
              child: const Text("Bësal fii ngir durus",
              style: TextStyle(fontSize: 20),),
              onPressed: () {
                if (remotePDFpath.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PDFScreen(path: remotePDFpath),
                    ),
                  );
                }
              },
            );
          },
        )),
      


    );
  }
  //      void _loadAd() async {
  //   BannerAd(
  //     adUnitId: _adUnitId,
  //     request: const AdRequest(),
  //     size: AdSize.banner,
  //     listener: BannerAdListener(
  //       onAdLoaded: (ad) {
  //         setState(() {
  //           _bannerAd = ad as BannerAd;
  //         });
  //       },
  //       onAdFailedToLoad: (ad, err) {
  //         ad.dispose();
  //       },
  //       onAdOpened: (Ad ad) {},
  //       onAdClosed: (Ad ad) {},
  //       onAdImpression: (Ad ad) {},
  //     ),
  //   ).load();
  // }

  // @override
  // void dispose() {
  //   _bannerAd?.dispose();
  //   super.dispose();
  // }  

  
 

  

 

}


class PdfViewerPage extends StatefulWidget {
  final File file;
  final String url;

  const PdfViewerPage({
    super.key,
    required this.file,
    required this.url,
  });

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        
      ),
      body: PDFView(
        filePath: widget.file.path,
      ),
    );
  }

}




class PDFScreen extends StatefulWidget {
  final String? path;

  const PDFScreen({super.key, this.path});

  @override
  PDFScreenState1 createState() => PDFScreenState1();
}

class PDFScreenState1 extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lisaanu Shukrii"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            enableSwipe: true,
            swipeHorizontal: false,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            defaultPage: currentPage!,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation:
                false, // if set to true the link is handled in flutter
            onRender: (pages) {
              setState(() {
                pages = pages;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onLinkHandler: (String? uri) {
            },
            onPageChanged: (int? page, int? total) {
              setState(() {
                currentPage = page;
              });
            },
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                )
        ],
      ),
      // floatingActionButton: FutureBuilder<PDFViewController>(
      //   future: _controller.future,
      //   builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
      //     if (snapshot.hasData) {
      //       return FloatingActionButton.extended(
      //         label: Text("Go to ${pages! ~/ 1}"),
      //         onPressed: () async {
      //           await snapshot.data!.setPage(pages! ~/ 1);
      //         },
      //       );
      //     }

      //     return Container();
      //   },
      // ),
    );
  }
}