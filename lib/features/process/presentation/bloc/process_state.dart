import 'package:alexis_art/features/process/domain/entities/articles_batch.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProcessState extends Equatable {
  ProcessState([List props = const <dynamic>[]]) : super(props);
}

class InitialProcessState extends ProcessState {}

class LoadingArticlesState extends ProcessState {}

class LoadedArticlesState extends ProcessState {
  final ArticlesBatch fetchedBatch;

  LoadedArticlesState({@required this.fetchedBatch}) : super([fetchedBatch]);
}

class ErrorState extends ProcessState {
  final String message;

  ErrorState({@required this.message}) : super([message]) {
    print(message);
  }
}