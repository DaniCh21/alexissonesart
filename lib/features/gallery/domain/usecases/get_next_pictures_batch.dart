import 'package:alexis_art/core/error/failures.dart';
import 'package:alexis_art/core/usecases/usecase.dart';
import 'package:alexis_art/features/gallery/domain/entities/pictures_batch.dart';
import 'package:alexis_art/features/gallery/domain/repositories/gallery_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';

class GetNextPicturesBatch implements UseCase<PicturesBatch, Params> {
  GalleryRepository repository;

  GetNextPicturesBatch(this.repository);

  @override
  Future<Either<Failure, PicturesBatch>> call(Params params) async {
    return await repository.getNextPicturesBatch(
        year: params.year,
        category: params.category,
        numOfPictures: params.numOfPictures,
        subCategory: params.subCategory,
        lastVisible: params.lastVisible);
  }
}

class Params extends Equatable {
  final String year;
  final String category;
  final String subCategory;
  final int numOfPictures;
  final DocumentSnapshot lastVisible;

  Params(
      {@required this.subCategory,
      @required this.lastVisible,
      @required this.category,
      @required this.numOfPictures,
      @required this.year})
      : super([year, category, numOfPictures, subCategory, lastVisible]);
}
