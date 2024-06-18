import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:download_pdf/check.permission.dart';
import 'package:download_pdf/directory_path.dart';
import 'package:download_pdf/favorite_page1.dart';
import 'package:download_pdf/favorite_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
//import 'package:pdfx/pdfx.dart';



class FileList extends StatefulWidget {
  const FileList({super.key});

  @override
  State<FileList> createState() => _FileListState();
}

class _FileListState extends State<FileList> {
  bool isPermission = false;
  var checkAllPermissions = CheckPermission();
 // late PdfControllerPinch pdfControllerPinch;

  checkPermission() async {
    var permission = await checkAllPermissions.isStoragePermission();
    if (permission) {
      setState(() {
        isPermission = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkPermission();
    
  }

  // List<Map> dataList = [
  //   { "assetName":"assets/bishri00.jpg",
  //     "fileName": "mafaatihul_jinaan.pdf",
  //     "id": "2",
  //     "title": "Mafaatihul Jinaan",
  //     "url": "https://firebasestorage.googleapis.com/v0/b/doll-xasida.appspot.com/o/pdf%2Fmafaatihul_jinaan.pdf?alt=media&token=8ce29875-8c55-4ef5-9bc7-38a152fe0928"
  //   },
  //   { "assetName":"assets/00.jpg",
  //   "fileName": "Mawaahibu",
  //     "id": "3",
  //     "title": "Mawaahibu",
  //     "url": "https://firebasestorage.googleapis.com/v0/b/doll-xasida.appspot.com/o/pdf%2F%D8%A3%D8%B3%D8%AA%D8%BA%D9%81%D8%B1%D8%A7%D9%84%D9%84%D9%87%20%D8%A8%D9%87%20(1).pdf?alt=media&token=6a389d57-e714-4cf8-a6d3-49635530c4d8"
  //   },
  //   {"assetName":"assets/fawzayni.png",
  //   "fileName": "Matlabul Fawzayni",
  //     "id": "4",
  //     "title": "Matlabul Fawzayni",
  //     "url": "https://firebasestorage.googleapis.com/v0/b/doll-xasida.appspot.com/o/pdf%2F%D8%A3%D9%84%D9%85%20%D9%86%D8%B4%D8%B1%D8%AD.pdf?alt=media&token=c6691b84-f7fd-4b5b-a286-adacb77ee68f"
  //   },
  //   {"assetName":"assets/alhaadi00.jpg",
  //   "fileName": "Alhaadii",
  //     "id": "5",
  //     "title": "Alhaadii",
  //     "url": "https://firebasestorage.googleapis.com/v0/b/doll-xasida.appspot.com/o/pdf%2F%D8%A8%D8%B3%D9%85%20%D8%A7%D9%84%D8%A5%D9%84%D9%87%20%D8%A7%D9%84%D8%B0%D9%8A?alt=media&token=f177b981-9165-431d-a92c-1e53fc465209"
  //   },
  //   {"assetName":"assets/bishri00.jpg",
  //     "id": "6",
  //     "title": "Faazat Xilaamii",
  //     "url":
  //         "https://firebasestorage.googleapis.com/v0/b/doll-xasida.appspot.com/o/pdf%2F%D9%81%D8%A7%D8%B2%D8%AA%20%D9%82%D9%84%D8%A7%D9%85%DB%92?alt=media&token=4d0498da-6648-4550-966c-4f7740a54064"
  //   },
  //   {"assetName":"assets/bishri00.jpg",
  //     "id": "10",
  //     "title": "Lisaanu Shukrii",
  //     "url": "https://firebasestorage.googleapis.com/v0/b/doll-xasida.appspot.com/o/pdf%2F%D9%84%D8%B3%D8%A7%D9%86%20%D8%B4%D9%83%D8%B1%DB%92?alt=media&token=8b44f816-44dc-471e-b488-d4e694957d19"
  //   },
  //   {"assetName":"assets/hisnul_abraar01.jpg",
  //     "id": "10",
  //     "title": "Hisnul Abraar",
  //     "url": "https://firebasestorage.googleapis.com/v0/b/doll-xasida.appspot.com/o/pdf%2F%D9%85%D8%AF%D8%A7%D9%84%D8%AE%D8%A8%D9%8A%D8%B1?alt=media&token=e66c2bad-acd5-4792-896e-ea61da5fa162"
  //   },
  //   {"assetName":"assets/bishri00.jpg",
  //     "id": "11",
  //     "title": "file PDF 9",
  //     "url":
  //         "https://www.iso.org/files/live/sites/isoorg/files/store/en/PUB100431.pdf"
  //   },
  //   {"assetName":"assets/bishri00.jpg",
  //     "id": "12",
  //     "title": "file PDF 10",
  //     "url": "https://www.tutorialspoint.com/java/java_tutorial.pdf"
  //   },
  //   {"assetName":"assets/bishri00.jpg",
  //     "id": "13",
  //     "title": "file PDF 12",
  //     "url": "https://www.irs.gov/pub/irs-pdf/p463.pdf"
  //   },
  //   {"assetName":"assets/bishri00.jpg",
  //     "id": "14",
  //     "title": "file PDF 11",
  //     "url": "https://www.tutorialspoint.com/css/css_tutorial.pdf"
  //   },
  // ];

  //     late final   provider = FavoriteProvider.of(context);
    

  
  @override
  Widget build(BuildContext context) {
    List<Map> dataList = [
    { "assetName":"assets/bishri00.jpg",
      "fileName": "mafaatihul_jinaan.pdf",
      "id": "2",
      "title": "Mafaatihul Jinaan",
      "url": "https://firebasestorage.googleapis.com/v0/b/doll-xasida.appspot.com/o/pdf%2Fmafaatihul_jinaan.pdf?alt=media&token=8ce29875-8c55-4ef5-9bc7-38a152fe0928"
    },
    { "assetName":"assets/00.jpg",
    "fileName": "Mawaahibu",
      "id": "3",
      "title": "Mawaahibu",
      "url": "https://firebasestorage.googleapis.com/v0/b/doll-xasida.appspot.com/o/pdf%2F%D8%A3%D8%B3%D8%AA%D8%BA%D9%81%D8%B1%D8%A7%D9%84%D9%84%D9%87%20%D8%A8%D9%87%20(1).pdf?alt=media&token=6a389d57-e714-4cf8-a6d3-49635530c4d8"
    },
    {"assetName":"assets/fawzayni.png",
    "fileName": "Matlabul Fawzayni",
      "id": "4",
      "title": "Matlabul Fawzayni",
      "url": "https://firebasestorage.googleapis.com/v0/b/doll-xasida.appspot.com/o/pdf%2F%D8%A3%D9%84%D9%85%20%D9%86%D8%B4%D8%B1%D8%AD.pdf?alt=media&token=c6691b84-f7fd-4b5b-a286-adacb77ee68f"
    },
    {"assetName":"assets/alhaadi00.jpg",
    "fileName": "Alhaadii",
      "id": "5",
      "title": "Alhaadii",
      "url": "https://firebasestorage.googleapis.com/v0/b/doll-xasida.appspot.com/o/pdf%2F%D8%A8%D8%B3%D9%85%20%D8%A7%D9%84%D8%A5%D9%84%D9%87%20%D8%A7%D9%84%D8%B0%D9%8A?alt=media&token=f177b981-9165-431d-a92c-1e53fc465209"
    },
    {"assetName":"assets/bishri00.jpg",
      "id": "6",
      "title": "Faazat Xilaamii",
      "url":
          "https://firebasestorage.googleapis.com/v0/b/doll-xasida.appspot.com/o/pdf%2F%D9%81%D8%A7%D8%B2%D8%AA%20%D9%82%D9%84%D8%A7%D9%85%DB%92?alt=media&token=4d0498da-6648-4550-966c-4f7740a54064"
    },
    {"assetName":"assets/bishri00.jpg",
      "id": "10",
      "title": "Lisaanu Shukrii",
      "url": "https://firebasestorage.googleapis.com/v0/b/doll-xasida.appspot.com/o/pdf%2F%D9%84%D8%B3%D8%A7%D9%86%20%D8%B4%D9%83%D8%B1%DB%92?alt=media&token=8b44f816-44dc-471e-b488-d4e694957d19"
    },
    {"assetName":"assets/hisnul_abraar01.jpg",
      "id": "10",
      "title": "Hisnul Abraar",
      "url": "https://firebasestorage.googleapis.com/v0/b/doll-xasida.appspot.com/o/pdf%2F%D9%85%D8%AF%D8%A7%D9%84%D8%AE%D8%A8%D9%8A%D8%B1?alt=media&token=e66c2bad-acd5-4792-896e-ea61da5fa162"
    },
    {"assetName":"assets/bishri00.jpg",
      "id": "11",
      "title": "file PDF 9",
      "url":
          "https://www.iso.org/files/live/sites/isoorg/files/store/en/PUB100431.pdf"
    },
    {"assetName":"assets/bishri00.jpg",
      "id": "12",
      "title": "file PDF 10",
      "url": "https://www.tutorialspoint.com/java/java_tutorial.pdf"
    },
    {"assetName":"assets/bishri00.jpg",
      "id": "13",
      "title": "file PDF 12",
      "url": "https://www.irs.gov/pub/irs-pdf/p463.pdf"
    },
    {"assetName":"assets/bishri00.jpg",
      "id": "14",
      "title": "file PDF 11",
      "url": "https://www.tutorialspoint.com/css/css_tutorial.pdf"
    },
  ];

  
    //final provider = FavoriteProvider.of(context);
    return Scaffold(backgroundColor: const Color.fromARGB(249, 10, 30, 121),
    appBar: AppBar(
      actions: [IconButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritePage1()));
      }, 
      icon: const Icon(Icons.favorite_border_sharp))],
    ),
        body: 
        //  isPermission
        //     ? 
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final data = dataList[index];
                    return TileList(
                      fileUrl: data['url']!,
                      title: data['title'],
                      assetName: data['assetName']!,
                    );
                  }),
                  
            ),
            bottomNavigationBar: const BottomAppBar(

            ),
            // : Padding(
            //   padding: const EdgeInsets.all(50.0),
            //   child: TextButton(
            //       onPressed: () {
            //         checkPermission();
            //       },
            //       child: const Text("Permission issue")),
            //)
            );
  }
}

class TileList extends StatefulWidget {
  TileList({super.key, required this.fileUrl, required this.title, required this.assetName,});
  final String fileUrl;
  final String title;
  final String assetName;
  //final provider = FavoriteProvider.of(context as BuildContext);
  //final document =  PdfDocument.openFile('/storage/emulated/0/Android/data/com.example.download_pdf/files/files');

  @override
  State<TileList> createState() => _TileListState();
}

class _TileListState extends State<TileList> {
  bool dowloading = false;
  bool fileExists = false;
  double progress = 0;
  String fileName = "";
  late String filePath;
  late FavoriteProvider provider = FavoriteProvider.of(context);
 // late CancelToken cancelToken;
  var getPathFile = DirectoryPath();

  startDownload() async {
   // cancelToken = CancelToken();
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/${fileName}';
    setState(() {
      dowloading = true;
      progress = 0;
    });

    try {
      await Dio().download(widget.fileUrl, filePath,
          onReceiveProgress: (count, total) {
        setState(() {
          progress = (count / total);
        });
      },
      // cancelToken: cancelToken
      );
      setState(() {
        dowloading = false;
        fileExists = true;
      });
    } catch (e) {
      print(e);
      setState(() {
        dowloading = false;
      });
    }
  }

  // cancelDownload() {
  //   //cancelToken.cancel();
  //   setState(() {
  //     dowloading = false;
  //   });
  // }

  checkFileExit() async {
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    bool fileExistCheck = await File(filePath).exists();
    setState(() {
      fileExists = fileExistCheck;
    });
  }

  openfile() {
    OpenFile.open(filePath);
    print("fff $filePath");
    
  }

   downloadFile(var filePath, var fileUrl) async {
try {
  /// setting filename 
  final fileName = filePath;
  String dir = (await getApplicationDocumentsDirectory()).path;
  if (await File('$dir/$fileName').exists()) return File('$dir/$fileName');

  String url = fileUrl;

  /// requesting http to get url
  var request = await HttpClient().getUrl(Uri.parse(url));

  /// closing request and getting response
  var response = await request.close();

  /// getting response data in bytes
  var bytes = await consolidateHttpClientResponseBytes(response);

  /// generating a local system file with name as 'filename' and path as '$dir/$filename'
  File file =  File('$dir/$fileName');

  /// writing bytes data of response in the file.
  await file.writeAsBytes(bytes);

  return file;
}
catch (err) {
  print(err);
}
}

  @override
  void initState() {
    super.initState();
    setState(() {
      fileName = p.basename(widget.fileUrl);
    });
    checkFileExit();
  }

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    return Card(margin: const EdgeInsetsDirectional.symmetric(horizontal: 25, vertical: 10),
      elevation: 10,
      shadowColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
            title: Text(widget.title),
            leading: InkWell(child: Image(image: AssetImage(widget.assetName),),
            onTap: () {if (filePath.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PDFScreen(path: filePath, name: fileName),
                          ),
                        );
                      }
              
            },),
            trailing: fileExists? IconButton(
              onPressed: () {
               provider.toggleFavorite({"name": fileName, "path": filePath});
              }, icon: Icon(Icons.favorite_border_sharp),
            )
            :IconButton(
                onPressed: () {
                //  fileExists && dowloading == false
                //       ? openfile()
                //       :
                
                    if (fileExists==false)  { startDownload();
                    }else  if (filePath.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PDFScreen(path: filePath, name: fileName),
                          ),
                        );
                      }
                     // downloadFile(filePath, widget.fileUrl);
                },
                icon: dowloading
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: progress,
                                strokeWidth: 3,
                                backgroundColor: Colors.grey,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.blue),
                              ),
                              Text(
                                "${(progress * 100).toStringAsFixed(2)}",
                                style: const TextStyle(fontSize: 12),
                              )
                            ],
                          )
                        : const Icon(Icons.download))),
      ),
    );
    
  }
 
}


class PDFScreen extends StatefulWidget {
  final String? path;
  final String? name;

  PDFScreen({Key? key, this.path,  this.name,}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
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
        title: Text(widget.name!),
       
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            defaultPage: currentPage!,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation:
                false, // if set to true the link is handled in flutter
            onRender: (_pages) {
              setState(() {
                pages = _pages;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
             // print(error.toString());
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
             // print('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onLinkHandler: (String? uri) {
              //print('goto uri: $uri');
            },
            onPageChanged: (int? page, int? total) {
            //  print('page change: $page/$total');
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
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _controller.future,
        builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData) {
            return FloatingActionButton.extended(
              label: Text("Go to ${pages! ~/ 2}"),
              onPressed: () async {
                await snapshot.data!.setPage(pages! ~/ 2);
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}