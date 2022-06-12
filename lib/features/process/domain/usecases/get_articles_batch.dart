import 'package:alexis_art/core/error/failures.dart';
import 'package:alexis_art/core/usecases/usecase.dart';
import 'package:alexis_art/features/process/domain/entities/articles_batch.dart';
import 'package:alexis_art/features/process/domain/repositories/process_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';

class GetArticlesBatch implements UseCase<ArticlesBatch, NoParams> {
  ProcessRepository repository;

  GetArticlesBatch(this.repository);

  @override
  Future<Either<Failure, ArticlesBatch>> call(NoParams params) async {
    return await repository.getArticlesBatch();
  }
}
