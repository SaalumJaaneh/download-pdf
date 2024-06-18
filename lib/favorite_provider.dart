import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class FavoriteProvider extends ChangeNotifier {
// List<Map> dataList = [
//     { "assetName":"assets/bishri00.jpg",
//       "fileName": "mafaatihul_jinaan.pdf",
//       "id": "2",
//       "title": "Mafaatihul Jinaan",
//       "url": "https://firebasestorage.googleapis.com/v0/b/doll-xasida.appspot.com/o/pdf%2Fmafaatihul_jinaan.pdf?alt=media&token=8ce29875-8c55-4ef5-9bc7-38a152fe0928"
//     },
//     { "assetName":"assets/00.jpg",
//     "fileName": "Mawaahibu",
//       "id": "3",
//       "title": "Mawaahibu",
//       "url": "https://firebasestorage.googleapis.com/v0/b/doll-xasida.appspot.com/o/pdf%2F%D8%A3%D8%B3%D8%AA%D8%BA%D9%81%D8%B1%D8%A7%D9%84%D9%84%D9%87%20%D8%A8%D9%87%20(1).pdf?alt=media&token=6a389d57-e714-4cf8-a6d3-49635530c4d8"
//     },
//     {"assetName":"assets/fawzayni.png",
//     "fileName": "Matlabul Fawzayni",
//       "id": "4",
//       "title": "Matlabul Fawzayni",
//       "url": "https://firebasestorage.googleapis.com/v0/b/doll-xasida.appspot.com/o/pdf%2F%D8%A3%D9%84%D9%85%20%D9%86%D8%B4%D8%B1%D8%AD.pdf?alt=media&token=c6691b84-f7fd-4b5b-a286-adacb77ee68f"
//     },
//     {"assetName":"assets/alhaadi00.jpg",
//     "fileName": "Alhaadii",
//       "id": "5",
//       "title": "Alhaadii",
//       "url": "https://firebasestorage.googleapis.com/v0/b/doll-xasida.appspot.com/o/pdf%2F%D8%A8%D8%B3%D9%85%20%D8%A7%D9%84%D8%A5%D9%84%D9%87%20%D8%A7%D9%84%D8%B0%D9%8A?alt=media&token=f177b981-9165-431d-a92c-1e53fc465209"
//     },
//     {"assetName":"assets/bishri00.jpg",
//       "id": "6",
//       "title": "Faazat Xilaamii",
//       "url":
//           "https://firebasestorage.googleapis.com/v0/b/doll-xasida.appspot.com/o/pdf%2F%D9%81%D8%A7%D8%B2%D8%AA%20%D9%82%D9%84%D8%A7%D9%85%DB%92?alt=media&token=4d0498da-6648-4550-966c-4f7740a54064"
//     },
//     {"assetName":"assets/bishri00.jpg",
//       "id": "10",
//       "title": "Lisaanu Shukrii",
//       "url": "https://firebasestorage.googleapis.com/v0/b/doll-xasida.appspot.com/o/pdf%2F%D9%84%D8%B3%D8%A7%D9%86%20%D8%B4%D9%83%D8%B1%DB%92?alt=media&token=8b44f816-44dc-471e-b488-d4e694957d19"
//     },
//     {"assetName":"assets/hisnul_abraar01.jpg",
//       "id": "10",
//       "title": "Hisnul Abraar",
//       "url": "https://firebasestorage.googleapis.com/v0/b/doll-xasida.appspot.com/o/pdf%2F%D9%85%D8%AF%D8%A7%D9%84%D8%AE%D8%A8%D9%8A%D8%B1?alt=media&token=e66c2bad-acd5-4792-896e-ea61da5fa162"
//     },
//     {"assetName":"assets/bishri00.jpg",
//       "id": "11",
//       "title": "file PDF 9",
//       "url":
//           "https://www.iso.org/files/live/sites/isoorg/files/store/en/PUB100431.pdf"
//     },
//     {"assetName":"assets/bishri00.jpg",
//       "id": "12",
//       "title": "file PDF 10",
//       "url": "https://www.tutorialspoint.com/java/java_tutorial.pdf"
//     },
//     {"assetName":"assets/bishri00.jpg",
//       "id": "13",
//       "title": "file PDF 12",
//       "url": "https://www.irs.gov/pub/irs-pdf/p463.pdf"
//     },
//     {"assetName":"assets/bishri00.jpg",
//       "id": "14",
//       "title": "file PDF 11",
//       "url": "https://www.tutorialspoint.com/css/css_tutorial.pdf"
//     },
//   ];
 
  List<Map> data = [];
  
  List<Map> get dataList => data;

  void toggleFavorite(Map dataList) {
    
    final isExist = data.contains(dataList);
    if (isExist) {
      data.remove(dataList);
    } else {
      data.add(dataList);
    }
    notifyListeners();
  }

  bool isExist(Map dataList) {
    final isExist = data.contains(dataList);
    return isExist;
  }

  void clearFavorite() {
    data = [];
    notifyListeners();
  }

  static FavoriteProvider of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<FavoriteProvider>(
      context,
      listen: listen,
    );
  }
}