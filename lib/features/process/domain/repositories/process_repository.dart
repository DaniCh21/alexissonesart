import 'package:alexis_art/core/error/failures.dart';
import 'package:alexis_art/features/process/domain/entities/articles_batch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

abstract class ProcessRepository {
  Future<Either<Failure, ArticlesBatch>> getArticlesBatch();
}
