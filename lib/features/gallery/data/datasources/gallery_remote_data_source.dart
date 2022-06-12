import 'dart:math';

import 'package:alexis_art/core/error/failures.dart';
import 'package:alexis_art/features/gallery/domain/entities/pictures_batch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

abstract class GalleryRemoteDataSource {
  /// Calls the firestore database fetching particular year, category and number of documents/pictures.
  Future<PicturesBatch> getNextPicturesBatch(
      {@required String year,
      @required String category,
      @required int numOfPictures,
      @required String subCategory,
      @required DocumentSnapshot lastVisible});
}

class GalleryRemoteDataSourceImpl implements GalleryRemoteDataSource {
  final firestore = Firestore.instance;

  @override
  Future<PicturesBatch> getNextPicturesBatch(
      {@required String year,
      @required String category,
      @required int numOfPictures,
      @required String subCategory,
      @required DocumentSnapshot lastVisible}) async {
    String path = determineCategoryPath(category);
    QuerySnapshot resultQS;

    print('``inside RemoteDS with year: ' +
        year.toString() +
        ' and subcategory: ' +
        subCategory);

    if (lastVisible == null) {
      await firestore
          .collection(path)
          .where('year', isEqualTo: year)
          .where('subCategory', isEqualTo: subCategory)
          .orderBy('name',
              descending: true) //TODO should we implement sorting by date?
          .limit(numOfPictures)
          .getDocuments()
          .then((QuerySnapshot docs) {
        if (docs.documents.isNotEmpty) {
          resultQS = docs;
        } else {
          resultQS = null;
        }
      });
    } else {
      await firestore
          .collection(path)
          .where('year', isEqualTo: year)
          .where('subCategory', isEqualTo: subCategory)
          .orderBy('name',
              descending: true) //TODO should we implement sorting by date?
          .startAfterDocument(lastVisible)
          .limit(numOfPictures)
          .getDocuments()
          .then((QuerySnapshot docs) {
        if (docs.documents.isNotEmpty) {
          resultQS = docs;
        } else {
          resultQS = null;
        }
      });
    }
    return PicturesBatch.fill(resultQS);
  }

  String determineCategoryPath(String category) {
    switch (category) {
      case 'Wordless Dimension':
        return '/users/alexis/categories/wordless dimension/pictures';
        break;
      case 'Figure Realm':
        return '/users/alexis/categories/figure realm/pictures';
        break;
      case 'Digital Universe':
        return '/users/alexis/categories/digital universe/pictures';
        break;
      default:
        return null;
    }
  }
}
