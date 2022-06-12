import 'dart:async';

import 'package:alexis_art/core/error/failures.dart';
import 'package:alexis_art/core/network/network_info.dart';
import 'package:alexis_art/core/usecases/usecase.dart';
import 'package:alexis_art/features/process/data/repositories/process_repository_impl.dart';
import 'package:alexis_art/features/process/domain/entities/articles_batch.dart';
import 'package:alexis_art/features/process/domain/repositories/process_repository.dart';

import 'package:alexis_art/features/process/domain/usecases/get_articles_batch.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import './bloc.dart';

class ProcessBloc extends Bloc<ProcessEvent, ProcessState> {
 final GetArticlesBatch getArticlesBatch;

 ProcessBloc({@required this.getArticlesBatch}) : super(LoadingArticlesState());

 @override
 ProcessState get initialState => LoadingArticlesState();

 @override
 Stream<ProcessState> mapEventToState(
     ProcessEvent event,
     ) async* {
   if (event is GetArticlesEvent) {
     yield LoadingArticlesState();
     getBatch();
   }
 }

 void getBatch() async{
   final failureOrArticlesBatch = await getArticlesBatch(NoParams());
   //yield* _eitherLoadedOrErrorState(failureOrArticlesBatch);
 }

 Stream<ProcessState> _eitherLoadedOrErrorState(
     Either<Failure, ArticlesBatch> failureOrArticlesBatch,
     ) async* {
   yield failureOrArticlesBatch.fold(
         (failure) => ErrorState(message: 'Error appear'),
         (articlesBatch) => LoadedArticlesState(fetchedBatch: articlesBatch),
   );
 }

 dispose() {
   super.dispose();
 }
}
