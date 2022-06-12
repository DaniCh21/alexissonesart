import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class Picture {
  final String category;
  final String subCategory;
  final String description;
  final String name;
  final String url;
  final String year;
  final String size;

  Picture({
    @required pictureDocSnap,
  })  : category =
            pictureDocSnap != null ? pictureDocSnap['category'] ?? '' : '',
        subCategory =
            pictureDocSnap != null ? pictureDocSnap['subCategory'] ?? '' : '',
        description =
            pictureDocSnap != null ? pictureDocSnap['description'] ?? '' : '',
        name = pictureDocSnap != null ? pictureDocSnap['name'] ?? '' : '',
          url = pictureDocSnap != null ? pictureDocSnap['url'] ?? '' : '',
        year = pictureDocSnap != null ? pictureDocSnap['year'] ?? '' : '',
        size = pictureDocSnap != null ? pictureDocSnap['size'] ?? '' : '';

  factory Picture.empty() {
    return Picture(pictureDocSnap: null);
  }
}
