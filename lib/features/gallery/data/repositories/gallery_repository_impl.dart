import 'package:alexis_art/core/error/exeptions.dart';
import 'package:alexis_art/core/error/failures.dart';
import 'package:alexis_art/core/network/network_info.dart';
import 'package:alexis_art/features/gallery/data/datasources/gallery_remote_data_source.dart';
import 'package:alexis_art/features/gallery/domain/entities/pictures_batch.dart';
import 'package:alexis_art/features/gallery/domain/repositories/gallery_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class GalleryRepositoryImpl implements GalleryRepository {
  final GalleryRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  GalleryRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, PicturesBatch>> getNextPicturesBatch(
      {@required String year,
      @required String category,
      @required int numOfPictures,
      @required String subCategory,
      @required DocumentSnapshot lastVisible}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteBatch = await remoteDataSource.getNextPicturesBatch(
            year: year,
            category: category,
            numOfPictures: numOfPictures,
            subCategory: subCategory,
            lastVisible: lastVisible);
        if (remoteBatch.fetchedQuery == null) {
          return Left(InvalidRequestFailure());
        }
        return Right(remoteBatch);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }
}
