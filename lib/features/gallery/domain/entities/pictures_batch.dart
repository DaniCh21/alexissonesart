import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class PicturesBatch {
  QuerySnapshot fetchedQuery;

  PicturesBatch({
    @required this.fetchedQuery,
  });

  factory PicturesBatch.fill(QuerySnapshot query) {
    return PicturesBatch(fetchedQuery: query);
  }
}
