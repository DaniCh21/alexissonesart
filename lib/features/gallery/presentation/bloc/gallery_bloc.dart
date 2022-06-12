import 'dart:async';

import 'package:alexis_art/core/network/api_response.dart';
import 'package:alexis_art/features/gallery/domain/entities/list_item.dart';
import 'package:alexis_art/features/gallery/domain/entities/picture.dart';
import 'package:alexis_art/features/gallery/domain/entities/pictures_batch.dart';
import 'package:alexis_art/features/gallery/domain/entities/year_header.dart';
import 'package:alexis_art/features/gallery/domain/usecases/get_next_pictures_batch.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import './bloc.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final GetNextPicturesBatch getNextPicturesBatch;

  StreamController _picturesListController;

  DocumentSnapshot lastVisible;
  int limitOfPictures = 5;

  String currentCategory = '';
  String currentSubCategory = '';

  int yearIndex = 0;
  bool isNextYear = true;
  bool isLast = false;
  bool isInitialLoading = true;

  bool isGrid = false;

  static List<String> _listOfYears = buildListOfYears();

  static List<String> buildListOfYears() {
    var dateParse = DateTime.parse(new DateTime.now().toString());
    int currentYear = dateParse.year;

    List<String> _tempListOfYears = new List();

    for(int i = currentYear; i >= 2010; i--){
      _tempListOfYears.add(i.toString());
    }
    return _tempListOfYears;
  }

  List<ListItem> _listOfItems = List();

  StreamSink<ApiResponse<List<ListItem>>> get picturesListSink =>
      _picturesListController.sink;

  Stream<ApiResponse<List<ListItem>>> get picturesListStream =>
      _picturesListController.stream;

  GalleryBloc({@required this.getNextPicturesBatch}) {
    _picturesListController = StreamController<ApiResponse<List<ListItem>>>();
  }

  @override
  GalleryState get initialState => InitialGalleryState();

  @override
  Stream<GalleryState> mapEventToState(
    GalleryEvent event,
  ) async* {
    if (event is GetPicturesEvent) {
      yield Loading();
      getNextBatch('');
    }
  }

  void getNextBatch(String criterion) async {
    switch (criterion) {
      case '':
        return;
        break;
      case 'IPad Paintings':
        currentSubCategory = criterion;
        currentCategory = 'Digital Universe';
        break;
      case 'Collages':
        currentSubCategory = criterion;
        currentCategory = 'Digital Universe';
        break;
      case 'Wordless Dimension':
        currentSubCategory = '';
        currentCategory = criterion;
        break;
      default:
        currentSubCategory = criterion;
        currentCategory = 'Figure Realm';
        break;
    }
    if (isInitialLoading) {
      picturesListSink.add(ApiResponse.loading('Fetching the gallery'));
      isInitialLoading = false;
    }

    final failureOrPictureBatch = await getNextPicturesBatch(Params(
      year: _listOfYears[yearIndex],
      subCategory: currentSubCategory,
      category: currentCategory,
      numOfPictures: limitOfPictures,
      lastVisible: lastVisible,
    ));

    failureOrPictureBatch.fold(
      (invalidRequestFailure) {
        continueOrEndFetchingData(fetchedBatch: null);
      },
      (pictureBatch) {
        continueOrEndFetchingData(fetchedBatch: pictureBatch);
      },
    );
  }

  void continueOrEndFetchingData({@required PicturesBatch fetchedBatch}) {
    if (fetchedBatch != null) {
      createHeaders();

      //PictureBatchQuerySnapshot
      final QuerySnapshot PBQSnap = fetchedBatch.fetchedQuery;

      if (PBQSnap.documents.length != 0 &&
          PBQSnap.documents.length < limitOfPictures) {
        lastVisible = null;

        List<ListItem> _tempListOfItems =
            querySnapToListOfPictures(querySnap: PBQSnap);

        _listOfItems.addAll(_tempListOfItems);

        //checking whether year is last or not
        if (yearIndex < _listOfYears.length - 1) {
          yearIndex++;
          isNextYear = true;

          getNextBatch(
              currentSubCategory == '' ? currentCategory : currentSubCategory);
        } else {
          return;
        }
      } else if (PBQSnap.documents.length == limitOfPictures) {
        lastVisible = PBQSnap.documents.last;

        List<ListItem> _tempListOfItems =
            querySnapToListOfPictures(querySnap: PBQSnap);

        _listOfItems.addAll(_tempListOfItems);
        picturesListSink.add(ApiResponse.completed(_listOfItems));
      }
    } else if (fetchedBatch == null) {
      //That means implementation of InvalidRequestFailure
      if (yearIndex < _listOfYears.length - 1) {
        yearIndex++;
        isNextYear = true;
        getNextBatch(
            currentSubCategory == '' ? currentCategory : currentSubCategory);
      } else
        isLast = true;
      picturesListSink.add(ApiResponse.completed(_listOfItems));
    }
  }

  void createHeaders() {
    if (lastVisible == null) {
      //variable to reset when current batch doesn't need a header
      List<ListItem> _tempListOfHeaders = new List();

      if (isNextYear) {
        ListItem tempListItem = ListItem.yearHeader(
            yearHeader: YearHeader(
          headerTitle: _listOfYears[yearIndex],
        ));
        _tempListOfHeaders.add(tempListItem);
        isNextYear = false;
      }
      //when lastVisible != null adding nothing
      _listOfItems.addAll(_tempListOfHeaders);
    }
  }

  List<ListItem> querySnapToListOfPictures(
      {@required QuerySnapshot querySnap}) {
    //receiving QuerySnapshot and transforming it to list of Picture widgets
    List<ListItem> _tempListOfPictures = new List();

    querySnap.documents.forEach((picDocSnap) {
      ListItem tempListItem = ListItem.picture(
        picture: Picture(pictureDocSnap: picDocSnap),
      );
      _tempListOfPictures.add(tempListItem);
    });
    return _tempListOfPictures;
  }

  dispose() {
    _picturesListController?.close();
    super.dispose();
  }
}
