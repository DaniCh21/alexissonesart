import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class FetchedData extends StatelessWidget {
  final String path;
  final int year;

  const FetchedData({
    Key key,
    @required this.path,
    @required this.year,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('/categories/1/Pictures')
//          .collection('/categories/Wordless Dimension Category/WD Pictures')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: Text('Loading data from Firestore'));
        }
        //return Center(child: Text('Some data was fetched from Firestore'));
        else {
          function();
        }
        return Container(
          height: MediaQuery.of(context).size.height / 2,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Image(
              image: NetworkImage(snapshot.data.documents[0]['Url']),
            ),

            //child: Text(snapshot.data.documents[0]['Url']),
//            child: Text('Some shit'),
          ),
        );
      },
    );
  }

  Future function() async {
    String result;
    await Firestore.instance
        .collection(path)
        .where('Year', isEqualTo: year)
        .where('SubCategory', isEqualTo: '')
        .where('Category', isEqualTo: 'Kittens')
        .getDocuments()
        .then((QuerySnapshot docs) {
      docs.documents.forEach((doc) {
//        print(doc.data['Year']);
        print(doc.data['Name']);
//        print('///////////////');
      });
//      if (docs == null) {
//      print(docs);
//        print('``DOCS ARE Null');
//      } else if (docs != null) {
//        if (docs.documents.length == 0) {
//          print('``Length is equal to 0');
//        }
//        print('``DOCS ARE NOT NULL');
//      }

//      print('last name is: ' + docs.documents.last.data['Name']);

//      for (int i = 0; i < docs.documents.length; i++) {
//        ///result = docs.documents[0].data['Name'];
//        result = docs.documents[i].data['Name'];
//        printThatShit(result);
//      }
      //print(docs.documents.length);
    });
    return result;
  }

//  Future function() async {
//    String result;
//    await Firestore.instance
//        .collection('/categories/Wordless Dimension Category/WD Pictures')
//        .where('Year', isEqualTo: 2029)
//        .getDocuments()
//        .then((QuerySnapshot docs) {
////      docs.documents.forEach((doc) {
////        print(doc.data['Year']);
////        print(doc.data['Name']);
////        print('///////////////');
////
////      });
//      if (docs == null) {
////      print(docs);
//        print('DOCS ARE NUUUUUUUUUUULLLLLLLLLLLLLLLLLLL');
//      } else if (docs != null) {
//        if (docs.documents.length == 0) {
//          print('Length is equal to 0');
//        }
//        print('DOCS ARE NOT NULL');
//      }
//
////      print('last name is: ' + docs.documents.last.data['Name']);
//
////      for (int i = 0; i < docs.documents.length; i++) {
////        ///result = docs.documents[0].data['Name'];
////        result = docs.documents[i].data['Name'];
////        printThatShit(result);
////      }
//      //print(docs.documents.length);
//    });
//    return result;
//  }

  printThatShit(String result) {
    print(result);
  }
}
