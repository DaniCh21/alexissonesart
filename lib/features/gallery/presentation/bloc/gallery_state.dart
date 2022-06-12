import 'package:alexis_art/features/gallery/domain/entities/pictures_batch.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GalleryState extends Equatable {
  GalleryState([List props = const <dynamic>[]]) : super(props);
}

class InitialGalleryState extends GalleryState {}

class Loading extends GalleryState {}

class Loaded extends GalleryState {
  final PicturesBatch picturesBatch;

  Loaded({@required this.picturesBatch}) : super([picturesBatch]);
}

class Error extends GalleryState {
  final String message;

  Error({@required this.message}) : super([message]) {
    print(message);
  }
}
