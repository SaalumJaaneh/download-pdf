// import 'dart:async';
// import 'dart:io';

// import 'package:download_pdf/directory_path.dart';
// import 'package:download_pdf/favorite_provider.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';


// class FavoritePage extends StatelessWidget {
//   const FavoritePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//   String fileName = "";
//     final provider = FavoriteProvider.of(context);
//     final dataList = provider.data;
//       late String filePath;
//         var getPathFile = DirectoryPath();
//        // bool fileExists = false;
        


  
//     checkFileExit() async {
//     var storePath = await getPathFile.getPath();
//     filePath = '$storePath/$fileName';
//     // bool fileExistCheck = await File(filePath).exists();
//     // setState(() {
//     //   fileExists = fileExistCheck;
//     // });
//   }

//   // openfile() {
    
//      OpenFile.open(filePath);
//   //   print("fff $filePath");
    
//   // }

//   downloadFile(var filePath, var fileUrl) async {
// try {
//   /// setting filename 
//   final fileName = filePath;
//   String dir = (await getApplicationDocumentsDirectory()).path;
//   if (await File('$dir/$fileName').exists()) return File('$dir/$fileName');

//   String url = fileUrl;

//   /// requesting http to get url
//   var request = await HttpClient().getUrl(Uri.parse(url));

//   /// closing request and getting response
//   var response = await request.close();

//   /// getting response data in bytes
//   var bytes = await consolidateHttpClientResponseBytes(response);

//   /// generating a local system file with name as 'filename' and path as '$dir/$filename'
//   File file = new File('$dir/$fileName');

//   /// writing bytes data of response in the file.
//   await file.writeAsBytes(bytes);

//   return file;
// }
// catch (err) {
//   print(err);
// }
// }


//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Favorites'),
//       ),
//       body: ListView.builder(
//         itemCount: dataList.length,
//         itemBuilder: (context, index) {
          
//           final title = dataList[index];
//           final assetName = dataList[index];
//           final url = dataList[index];
//           return ListTile(
//             title: Text(title['title'].toString()),
//             leading: InkWell(child: Image(image: AssetImage(assetName['assetName'].toString()),),
//             onTap: () { if(filePath.isNotEmpty)
//                         {Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => PDFScreen(path: url['url'], name: title['title']),
//                           ),
//                         );
                      
              
//             }},),
//             trailing: InkWell(child:Icon(Icons.favorite),
//             onTap: ()  {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => PDFScreen(path: url['url'], name: fileName),
//                           ),
//                         );
                      
              
//             },),
//             // trailing: fileExists? IconButton(
//             //   onPressed: () {
//             //    // provider.toggleFavorite(data);
//             //   }, icon: Icon(Icons.favorite_border_sharp),
//             // )
//             // :IconButton(
//                 // onPressed: () {
//                 // //  fileExists && dowloading == false
//                 // //       ? openfile()
//                 // //       :
                
//                 //     if (fileExists==false)  { startDownload();
//                 //     }else  if (filePath.isNotEmpty) {
//                 //         Navigator.push(
//                 //           context,
//                 //           MaterialPageRoute(
//                 //             builder: (context) => PDFScreen(path: filePath, name: fileName),
//                 //           ),
//                 //         );
//                 //       }
//                 //      // downloadFile(filePath, widget.fileUrl);
//                 // },
//                 // )
//             // IconButton(
//             //   onPressed: () {
//             //     provider.toggleFavorite(data);
//             //   },
//             //   icon: 
//             //   //provider.isExist(data.toString())?
//             //       const Icon(Icons.favorite, color: Colors.red)
//             //       //: const Icon(Icons.favorite_border),
//             // ),
//           );
//         },
//       ),
//     );
//   }
// }




// class PDFScreen extends StatefulWidget {
//   final String? path;
//   final String? name;

//   PDFScreen({Key? key, this.path,  this.name,}) : super(key: key);

//   _PDFScreenState createState() => _PDFScreenState();
// }

// class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
//   final Completer<PDFViewController> _controller =
//       Completer<PDFViewController>();
//   int? pages = 0;
//   int? currentPage = 0;
//   bool isReady = false;
//   String errorMessage = '';


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.name!),
       
//       ),
//       body: Stack(
//         children: <Widget>[
//           PDFView(
//             filePath: widget.path,
//             enableSwipe: true,
//             swipeHorizontal: true,
//             autoSpacing: false,
//             pageFling: true,
//             pageSnap: true,
//             defaultPage: currentPage!,
//             fitPolicy: FitPolicy.BOTH,
//             preventLinkNavigation:
//                 false, // if set to true the link is handled in flutter
//             onRender: (_pages) {
//               setState(() {
//                 pages = _pages;
//                 isReady = true;
//               });
//             },
//             onError: (error) {
//               setState(() {
//                 errorMessage = error.toString();
//               });
//              // print(error.toString());
//             },
//             onPageError: (page, error) {
//               setState(() {
//                 errorMessage = '$page: ${error.toString()}';
//               });
//              // print('$page: ${error.toString()}');
//             },
//             onViewCreated: (PDFViewController pdfViewController) {
//               _controller.complete(pdfViewController);
//             },
//             onLinkHandler: (String? uri) {
//               //print('goto uri: $uri');
//             },
//             onPageChanged: (int? page, int? total) {
//             //  print('page change: $page/$total');
//               setState(() {
//                 currentPage = page;
//               });
//             },
//           ),
//           errorMessage.isEmpty
//               ? !isReady
//                   ? const Center(
//                       child: CircularProgressIndicator(),
//                     )
//                   : Container()
//               : Center(
//                   child: Text(errorMessage),
//                 )
//         ],
//       ),
//       floatingActionButton: FutureBuilder<PDFViewController>(
//         future: _controller.future,
//         builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
//           if (snapshot.hasData) {
//             return FloatingActionButton.extended(
//               label: Text("Go to ${pages! ~/ 2}"),
//               onPressed: () async {
//                 await snapshot.data!.setPage(pages! ~/ 2);
//               },
//             );
//           }

//           return Container();
//         },
//       ),
//     );
//   }
// }