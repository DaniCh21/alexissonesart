import 'package:alexis_art/features/process/domain/entities/articles_batch.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProcessEvent extends Equatable {
  ProcessEvent([List props = const <dynamic>[]]) : super(props);
}

class GetArticlesEvent extends ProcessEvent {
  GetArticlesEvent();
}

class LoadingEvent extends ProcessEvent {}
