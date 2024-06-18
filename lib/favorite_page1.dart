import 'dart:io';

import 'package:download_pdf/directory_path.dart';
import 'package:download_pdf/favorite_provider.dart';
import 'package:download_pdf/file.list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';




class FavoritePage1 extends StatefulWidget {
  FavoritePage1({Key? key}) : super(key: key);
  
  //final provider = FavoriteProvider.of(context as BuildContext);
  //final document =  PdfDocument.openFile('/storage/emulated/0/Android/data/com.example.download_pdf/files/files');

  @override
  State<FavoritePage1> createState() => _FavoritePage1State();
}

class _FavoritePage1State extends State<FavoritePage1> {
  bool dowloading = false;
  bool fileExists = false;
  double progress = 0;
  String fileName = "";
  late String filePath;
  late FavoriteProvider provider = FavoriteProvider.of(context);
 // late CancelToken cancelToken;
  var getPathFile = DirectoryPath();

  // startDownload() async {
  //  // cancelToken = CancelToken();
  //   var storePath = await getPathFile.getPath();
  //   filePath = '$storePath/${fileName}';
  //   setState(() {
  //     dowloading = true;
  //     progress = 0;
  //   });

  //   try {
  //     await Dio().download(widget.fileUrl, filePath,
  //         onReceiveProgress: (count, total) {
  //       setState(() {
  //         progress = (count / total);
  //       });
  //     },
  //     // cancelToken: cancelToken
  //     );
  //     setState(() {
  //       dowloading = false;
  //       fileExists = true;
  //     });
  //   } catch (e) {
  //     print(e);
  //     setState(() {
  //       dowloading = false;
  //     });
  //   }
  // }

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
     // fileName = p.basename(widget.fileUrl);
    });
    checkFileExit();
  }

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final dataList = provider.data;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yi may faral di durus'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          
          final title = dataList[index];
          final assetName = dataList[index];
          final url = dataList[index];
          return ListTile(
            title: Text(title['title']),
            leading: InkWell(child: Image(image: AssetImage(assetName[assetName]),),
            onTap: () { if(filePath.isNotEmpty)
                        {Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PDFScreen(path: url['url'], name: title['title']),
                          ),
                        );
                      
              
            }},),
            trailing: InkWell(child:Icon(Icons.favorite),
            onTap: ()  {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PDFScreen(path: filePath, name: fileName),
                          ),
                        );
                      
              
            },),
            // trailing: fileExists? IconButton(
            //   onPressed: () {
            //    // provider.toggleFavorite(data);
            //   }, icon: Icon(Icons.favorite_border_sharp),
            // )
            // :IconButton(
                // onPressed: () {
                // //  fileExists && dowloading == false
                // //       ? openfile()
                // //       :
                
                //     if (fileExists==false)  { startDownload();
                //     }else  if (filePath.isNotEmpty) {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => PDFScreen(path: filePath, name: fileName),
                //           ),
                //         );
                //       }
                //      // downloadFile(filePath, widget.fileUrl);
                // },
                // )
            // IconButton(
            //   onPressed: () {
            //     provider.toggleFavorite(data);
            //   },
            //   icon: 
            //   //provider.isExist(data.toString())?
            //       const Icon(Icons.favorite, color: Colors.red)
            //       //: const Icon(Icons.favorite_border),
            // ),
          );
        },
      ),
    );
    //  Card(margin: const EdgeInsetsDirectional.symmetric(horizontal: 25, vertical: 10),
    //   elevation: 10,
    //   shadowColor: Colors.grey.shade100,
    //   child: Padding(
    //     padding: const EdgeInsets.all(5.0),
    //     child: ListTile(
    //         title: Text(widget.title),
    //         leading: InkWell(child: Image(image: AssetImage(widget.assetName),),
    //         onTap: () {if (filePath.isNotEmpty) {
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                         builder: (context) => PDFScreen(path: filePath, name: fileName),
    //                       ),
    //                     );
    //                   }
              
    //         },),
    //         trailing: fileExists? IconButton(
    //           onPressed: () {
    //            provider.toggleFavorite({"name": fileName, "path": filePath});
    //           }, icon: Icon(Icons.favorite_border_sharp),
    //         )
    //         :IconButton(
    //             onPressed: () {
    //             //  fileExists && dowloading == false
    //             //       ? openfile()
    //             //       :
                
    //                 if (fileExists==false)  { startDownload();
    //                 }else  if (filePath.isNotEmpty) {
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                         builder: (context) => PDFScreen(path: filePath, name: fileName),
    //                       ),
    //                     );
    //                   }
    //                  // downloadFile(filePath, widget.fileUrl);
    //             },
    //             icon: dowloading
    //                     ? Stack(
    //                         alignment: Alignment.center,
    //                         children: [
    //                           CircularProgressIndicator(
    //                             value: progress,
    //                             strokeWidth: 3,
    //                             backgroundColor: Colors.grey,
    //                             valueColor: const AlwaysStoppedAnimation<Color>(
    //                                 Colors.blue),
    //                           ),
    //                           Text(
    //                             "${(progress * 100).toStringAsFixed(2)}",
    //                             style: const TextStyle(fontSize: 12),
    //                           )
    //                         ],
    //                       )
    //                     : const Icon(Icons.download))),
    //   ),
    // );
    
  }
 
}
