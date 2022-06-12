import 'package:alexis_art/core/error/failures.dart';
import 'package:alexis_art/features/gallery/domain/entities/pictures_batch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

abstract class GalleryRepository {
  Future<Either<Failure, PicturesBatch>> getNextPicturesBatch(
      {@required String year,
      @required String category,
      @required int numOfPictures,
      @required String subCategory,
      @required DocumentSnapshot lastVisible});
}
