import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class ArticlesBatch {
  QuerySnapshot fetchedQuery;

  ArticlesBatch({
    @required this.fetchedQuery,
  });

  factory ArticlesBatch.fill(QuerySnapshot query) {
    return ArticlesBatch(fetchedQuery: query);
  }
}
