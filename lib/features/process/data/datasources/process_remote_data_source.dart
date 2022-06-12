import 'package:alexis_art/features/gallery/domain/entities/pictures_batch.dart';
import 'package:alexis_art/features/process/domain/entities/articles_batch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProcessRemoteDataSource {
  /// Calls the firestore database fetching the process articles
  ///
  /// Throws a [ServerException]  for error codes.
  Future<ArticlesBatch> getNextArticlesBatch();
}

class ProcessRemoteDataSourceImpl implements ProcessRemoteDataSource {
  final firestore = Firestore.instance;

  @override
  Future<ArticlesBatch> getNextArticlesBatch() async {
    QuerySnapshot resultQS;
    await firestore
        .collection('/users/alexis/articles')
        .orderBy('fullDate', descending: true)
        .getDocuments()
        .then((QuerySnapshot docs) {
      if (docs.documents.isNotEmpty) {
        resultQS = docs;
      } else {
        resultQS = null;
      }
    });
    return ArticlesBatch.fill(resultQS);
  }
}
