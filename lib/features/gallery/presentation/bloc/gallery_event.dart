import 'package:alexis_art/features/gallery/domain/entities/pictures_batch.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GalleryEvent extends Equatable {
  GalleryEvent([List props = const <dynamic>[]]) : super(props);
}

class GetPicturesEvent extends GalleryEvent {
  /// page
  final PicturesBatch batch;

  GetPicturesEvent(
    this.batch,
  );
}
