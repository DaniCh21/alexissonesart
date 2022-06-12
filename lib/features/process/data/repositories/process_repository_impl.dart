import 'package:alexis_art/core/error/exeptions.dart';
import 'package:alexis_art/core/error/failures.dart';
import 'package:alexis_art/core/network/network_info.dart';
import 'package:alexis_art/features/process/data/datasources/process_remote_data_source.dart';
import 'package:alexis_art/features/process/domain/entities/articles_batch.dart';
import 'package:alexis_art/features/process/domain/repositories/process_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class ProcessRepositoryImpl implements ProcessRepository {
  final ProcessRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProcessRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });



  @override
  Future<Either<Failure, ArticlesBatch>> getArticlesBatch() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteBatch = await remoteDataSource.getNextArticlesBatch();
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
