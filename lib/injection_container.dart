import 'package:alexis_art/core/network/network_info.dart';
import 'package:alexis_art/features/gallery/data/datasources/gallery_remote_data_source.dart';
import 'package:alexis_art/features/gallery/data/repositories/gallery_repository_impl.dart';
import 'package:alexis_art/features/gallery/domain/repositories/gallery_repository.dart';
import 'package:alexis_art/features/gallery/domain/usecases/get_next_pictures_batch.dart';
import 'package:alexis_art/features/gallery/presentation/bloc/bloc.dart';
import 'package:alexis_art/features/process/domain/usecases/get_articles_batch.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';

import 'features/process/data/datasources/process_remote_data_source.dart';
import 'features/process/data/repositories/process_repository_impl.dart';
import 'features/process/domain/repositories/process_repository.dart';
import 'features/process/presentation/bloc/process_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => GalleryBloc(
      getNextPicturesBatch: sl(),
    ),
  );
  sl.registerFactory(
    () => ProcessBloc(
      getArticlesBatch: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetNextPicturesBatch(sl()));
  sl.registerLazySingleton(() => GetArticlesBatch(sl()));

  // Repository
  sl.registerLazySingleton<GalleryRepository>(
    () => GalleryRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<ProcessRepository>(
        () => ProcessRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  //TODO why not?
  sl.registerLazySingleton<GalleryRemoteDataSource>(
    () => GalleryRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<ProcessRemoteDataSource>(
        () => ProcessRemoteDataSourceImpl(),
  );

//  sl.registerLazySingleton(() => GalleryRemoteDataSourceImpl());

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => DataConnectionChecker());
}
