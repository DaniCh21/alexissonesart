import 'package:alexis_art/features/process/domain/entities/articles_batch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ArticlePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ArticlePageState();
  }
}

class ArticlePageState extends State<ArticlePage> {
  String text = 'Tap here twice to receive the order of articles';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: InkWell(
              //onTap: () => getNextArticlesBatch(),
              onTap: () async {
                getNextArticlesBatch();
                setState(() {
                  text = text;
                });
              },
              child: Text(text, style: TextStyle(fontSize: 15),),
            ),
          ),
        ),
      ),
    );
  }

  final firestore = Firestore.instance;

  Future<ArticlesBatch> getNextArticlesBatch(
      /*{@required String year,
        @required int numOfPictures,
        @required DocumentSnapshot lastVisible}*/
      ) async {
    QuerySnapshot resultQS;
    await firestore
        .collection('/users/alexis/articles')

        /// Previous implementation
        //     .where('articleYear', isEqualTo: '2019')
        //    .startAfterDocument(lastVisible)

        .orderBy('fullDate', descending: true)
        .limit(20)
        .getDocuments()
        .then((QuerySnapshot docs) {
      if (docs.documents.isNotEmpty) {
        text = '';
        resultQS = docs;
        print('RESULTING ARTICLE NAMES:');
        docs.documents.forEach((doc) {
          text = text + doc.data['name'] + '\n' + '\n';
          print(doc.data['fullDate'].toDate().toString() +
              ' and name = ' +
              doc.data['name']);
        });
        //print(docs.documents);
      } else {
        resultQS = null;
      }
    });

    return ArticlesBatch.fill(resultQS);
  }
}
