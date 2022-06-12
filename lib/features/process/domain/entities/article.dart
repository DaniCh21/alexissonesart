import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class Article {
  final String additionalPicture1Name;
  final String additionalPicture2Name;
  final String additionalPicture1Url;
  final String additionalPicture2Url;
  final String creatorAvatar;
  final String creatorName;
  final String date;
  final String name;
  final String pictureData;
  final String pictureDate;
  final String pictureName;
  final String pictureSize;
  final String text;
  final String timeToRead;
  final String url;
  final Timestamp fullDate;

  Article({
    @required articleDocSnap,
  })
      :
        additionalPicture1Name =
        articleDocSnap != null
            ? articleDocSnap['additionalPicture1Name'] ?? ''
            : '',
        additionalPicture2Name =
        articleDocSnap != null
            ? articleDocSnap['additionalPicture2Name'] ?? ''
            : '',
        additionalPicture1Url =
        articleDocSnap != null
            ? articleDocSnap['additionalPicture1Url'] ?? ''
            : '',
        additionalPicture2Url =
        articleDocSnap != null
            ? articleDocSnap['additionalPicture2Url'] ?? ''
            : '',
        creatorAvatar =
        articleDocSnap != null ? articleDocSnap['creatorAvatar'] ?? '' : '',
        creatorName =
        articleDocSnap != null ? articleDocSnap['creatorName'] ?? '' : '',
        date = articleDocSnap != null ? articleDocSnap['date'] ?? '' : '',
        name = articleDocSnap != null ? articleDocSnap['name'] ?? '' : '',
        pictureData = articleDocSnap != null ? articleDocSnap['pictureData'] ??
            '' : '',
        pictureDate = articleDocSnap != null ? articleDocSnap['pictureDate'] ??
            '' : '',
        pictureName = articleDocSnap != null ? articleDocSnap['pictureName'] ??
            '' : '',
        pictureSize = articleDocSnap != null ? articleDocSnap['pictureSize'] ??
            '' : '',
        text = articleDocSnap != null ? articleDocSnap['text'] ?? '' : '',
        timeToRead = articleDocSnap != null
            ? articleDocSnap['timeToRead'] ?? ''
            : '',
        url = articleDocSnap != null ? articleDocSnap['url'] ?? '' : '',
        fullDate = articleDocSnap != null? articleDocSnap['fullDate'] ?? '' : '';


  factory Article.empty() {
    return Article(articleDocSnap: null);
  }
}