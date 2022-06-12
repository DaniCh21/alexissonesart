import 'package:alexis_art/core/network/api_response.dart';
import 'package:alexis_art/features/gallery/domain/entities/list_item.dart';
import 'package:alexis_art/features/gallery/domain/entities/picture.dart';
import 'package:alexis_art/features/gallery/presentation/bloc/bloc.dart';
import 'package:alexis_art/features/gallery/presentation/widgets/gallery_picture_widget.dart';
import 'package:alexis_art/features/gallery/presentation/widgets/hero_sliver_app_bar_widget.dart';
import 'package:alexis_art/features/gallery/presentation/widgets/loading_widget.dart';
import 'package:alexis_art/features/gallery/presentation/widgets/refreshableDetailsWidget.dart';
import 'package:alexis_art/features/gallery/presentation/widgets/year_header_widget.dart';
import 'package:alexis_art/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

GlobalKey<_GalleryPageState> galleryPageGlobalKey = GlobalKey();

class GalleryPage extends StatefulWidget {

  final String path;
  final String tag;
  final String title;

  GalleryPage({
    @required this.title,
    @required this.path,
    @required this.tag,
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GalleryPageState(this.title, this.path, this.tag);
  }

  double _offset = 0.0;

  setOffsetMethod(double offset) {
    _offset = offset;
  }

  double getOffsetMethod() {
    return _offset;
  }
}

class _GalleryPageState extends State<GalleryPage> {
  GalleryBloc galleryBloc;
  ScrollController scrollController;
  List<Widget> previousSliversSnapshot = List();
  int _startAt = 0;
  bool isLoadingMore = false;
  bool isInitialCall = true;
  bool isGridInitialCall = true;

  set setStartAt(int startAt) {
    this._startAt = startAt;
  }

  int get getStartAt {
    return _startAt;
  }

  final String path;
  final String tag;
  final String title;

  _GalleryPageState(this.title, this.path, this.tag) {
    galleryBloc = sl<GalleryBloc>();
    scrollController = new ScrollController(keepScrollOffset: true);
  }

  bool isBackVisible = true;
  bool isGrid = false;
  int indexedStackIndex = 0;

  Picture selectedPicture = Picture.empty();

  RefreshableDetailsWidget refreshableDetailsWidget = RefreshableDetailsWidget(
    picture: Picture.empty(),
    backButtonCallback: () {}
  );

  @override
  void initState() {
    scrollController.addListener(() {
      setState(() {
        isBackVisible = scrollController.position.userScrollDirection ==
            ScrollDirection.forward;
      });
    });
    _getPictures();
    super.initState();
  }

  @override
  Wi  dget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<ApiResponse<List<ListItem>>>(
        stream: galleryBloc.picturesListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            isLoadingMore = false;
            switch (snapshot.data.status) {
              case Status.LOADING:
                return CustomScrollView(
                  controller: scrollController,
                  slivers: <Widget>[
                    HeroSliverAppBar(
                      title: title,
                      tag: tag,
                      imagePath: path,
                      isGrid: isGrid,
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 100.0),
                        child: LoadingWidget(
                            loadingMessage: snapshot.data.message),
                      ),
                    ),
                  ],
                );
                break;
              case Status.COMPLETED:
                print('``Inside completed status');
                scrollController = new ScrollController(
                    initialScrollOffset: widget.getOffsetMethod(),
                    keepScrollOffset: true);

                return isGrid
                    ? buildSimpleGridUIWithAppBar(
                        list: snapshot.data.data,
                        scrollController: scrollController,
                        callback: (offset) {
                          if (!galleryBloc.isLast && !isLoadingMore) {
                            isLoadingMore = true;
                            widget.setOffsetMethod(offset);
                            galleryBloc.getNextBatch(title);
                          }
                        },
                      )
                    : WillPopScope(
                        onWillPop: () async {
                          if (indexedStackIndex == 0) {
                            return true;
                          } else if (indexedStackIndex == 1) {
                            setState(() {
                              indexedStackIndex--;
                            });
                            return false;
                          }
                          return true;
                        },
                        child: IndexedStack(
                          index: indexedStackIndex,
                          children: <Widget>[
                            buildUIWithAppBar(
                              list: snapshot.data.data,
                              scrollController: scrollController,
                              callback: (offset) {
                                if (!galleryBloc.isLast && !isLoadingMore) {
                                  isLoadingMore = true;
                                  widget.setOffsetMethod(offset);
                                  galleryBloc.getNextBatch(title);
                                }
                              },
                            ),
                            refreshableDetailsWidget,
                          ],
                        ),
                      );
                break;
              case Status.ERROR:
                return Center(child: Text('Error appeared'));
                break;
            }
          }
          return Container();
        },
      ),
    );
  }

  void updateIndexedStack(){
//    if(indexedStackIndex == 1){
      setState(() {
        indexedStackIndex = 0;
      });
//    }
//    else {
//      setState(() {
//        indexedStackIndex++;
//      });
//    }
  }

  Widget buildSimpleGridUIWithAppBar(
      {@required List<ListItem> list,
      @required ScrollController scrollController,
      @required Function(double) callback}) {
    return NotificationListener(
      onNotification: (scrollNotification) {
        if (scrollController.offset >=
                scrollController.position.maxScrollExtent &&
            !scrollController.position.outOfRange) {
          callback(scrollController.offset);
          print('``Scroll notification');
          return true;
        }
        return false;
      },
      child: CustomScrollView(
        controller: scrollController,
        slivers: buildListOfGridsWithHeaders(list: list),
      ),
    );
  }

  List<Widget> buildListOfGridsWithHeaders({
    @required List<ListItem> list,
  }) {
    List<Widget> listOfWidgets = new List();
    listOfWidgets.add(HeroSliverAppBar(
      title: title,
      tag: tag,
      imagePath: path,
      iconOnTap: () {
        changeDisplayingScenario();
      },
      isGrid: isGrid,
    ));
    List<ListItem> tempListOfGridPics = new List();
    for (int listIndex = 0; listIndex < list.length; listIndex++) {
      print(listIndex.toString());

      if (list[listIndex].listItemType == ListItemType.PICTURE &&
          listIndex < list.length) {
        tempListOfGridPics.add(list[listIndex]);
        if (listIndex == list.length - 1) {
          listOfWidgets.add(
              buildGridWithCurrentPics(listOfGridPics: tempListOfGridPics));
        }
      } else if (list[listIndex].listItemType == ListItemType.YEAR_HEADER &&
          listIndex < list.length) {
        if (listIndex != 0) {
          tempListOfGridPics.forEach((picture) {
            print(picture.toString() + listIndex.toString());
          });
          listOfWidgets.add(
              buildGridWithCurrentPics(listOfGridPics: tempListOfGridPics));
          tempListOfGridPics = new List();
        }
        listOfWidgets.add(SliverToBoxAdapter(
          child: YearHeaderWidget(
              yearHeaderTitle: list[listIndex].yearHeader.headerTitle),
        ));
      }
    }
    return listOfWidgets;
  }

  Widget buildGridWithCurrentPics({@required List<ListItem> listOfGridPics}) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return GalleryPictureWidget(
          picture: listOfGridPics[index].picture,
          horizontalPadding: 6,
          verticalPadding: 12,
        );
      }, childCount: listOfGridPics.length),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    );
  }



  Widget buildUIWithAppBar(
      {@required List<ListItem> list,
      @required ScrollController scrollController,
      @required Function(double) callback}) {
    if (isInitialCall) {
      previousSliversSnapshot.add(HeroSliverAppBar(
        title: title,
        tag: tag,
        imagePath: path,
        iconOnTap: () {
          changeDisplayingScenario();
        },
        isGrid: isGrid,
      ));
      isInitialCall = false;
      previousSliversSnapshot.add(getSliverList(list: list));
      previousSliversSnapshot.add(SliverToBoxAdapter(
        child: LoadingWidget(
          loadingMessage: 'Loading more pictures',
        ),
      ));
    } else if (!galleryBloc.isLast) {
      previousSliversSnapshot.removeLast();
      //Creating and adding new SliverList to previousSliversSnapshot
      previousSliversSnapshot.add(getSliverList(list: list));
      previousSliversSnapshot.add(SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: LoadingWidget(
            loadingMessage: 'Loading more pictures',
          ),
        ),
      ));
    } else {
      previousSliversSnapshot.removeLast();
      previousSliversSnapshot.add(
        SliverToBoxAdapter(
          child: Center(
            child: Text(
              'Bottom navigation',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      );
    }

    return NotificationListener(
      onNotification: (scrollNotification) {
        if (scrollController.offset >=
                scrollController.position.maxScrollExtent &&
            !scrollController.position.outOfRange) {
          callback(scrollController.offset);
          print('``Scroll notification');
          return true;
        }
        return false;
      },
      child: CustomScrollView(
        controller: scrollController,
        slivers: previousSliversSnapshot,
      ),
    );
  }

  SliverList getSliverList({@required List<ListItem> list}) {
    int tempStartAt = getStartAt;
    setStartAt = list.length;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          switch (list[tempStartAt + index].listItemType) {
            case ListItemType.YEAR_HEADER:
              return KeepAlive(
                keepAlive: true,
                child: IndexedSemantics(
                  index: index,
                  child: YearHeaderWidget(
                      yearHeaderTitle:
                          list[tempStartAt + index].yearHeader.headerTitle),
                ),
              );
              break;
            case ListItemType.PICTURE:
              return KeepAlive(
                keepAlive: true,
                child: IndexedSemantics(
                  index: index,
                  child: GalleryPictureWidget(
                    picture: list[tempStartAt + index].picture,
                    horizontalPadding: 0,
                    verticalPadding: 24,
                    onTap: (picture) {
                      setState(() {
                        selectedPicture = picture;
                        refreshableDetailsWidget = RefreshableDetailsWidget(
                          backButtonCallback: () {
                            galleryPageGlobalKey.currentState.updateIndexedStack();
                          },
                          key: UniqueKey(),
                          picture: selectedPicture,
                        );
                        indexedStackIndex = 1;
                      });
                    },
                  ),
                ),
              );
              break;
            default:
              return Container(
                color: Colors.black,
              );
          }
        },
        childCount: list.length - tempStartAt,
        addSemanticIndexes: false,
        addRepaintBoundaries: false,
        addAutomaticKeepAlives: false,
      ),
    );
  }

  changeDisplayingScenario() {
    setState(() {
      isGrid = !isGrid;
    });
  }

  _getPictures() {
    widget.setOffsetMethod(0.0);
    galleryBloc.getNextBatch(title);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  /*Widget buildSimpleUIWithAppBar(
      {@required List<ListItem> list,
      @required ScrollController scrollController,
      @required Function(double) callback}) {
    return NotificationListener(
      onNotification: (scrollNotification) {
        if (scrollController.offset >=
                scrollController.position.maxScrollExtent &&
            !scrollController.position.outOfRange) {
          callback(scrollController.offset);
          print('``Scroll notification');
          return true;
        }
        return false;
      },
      child: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          HeroSliverAppBar(
            title: title,
            tag: tag,
            imagePath: path,
            iconOnTap: () {
              changeDisplayingScenario();
            },
            isGrid: isGrid,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              switch (list[index].listItemType) {
                case ListItemType.YEAR_HEADER:
                  return KeepAlive(
                    keepAlive: true,
                    child: IndexedSemantics(
                      index: index,
                      child: YearHeaderWidget(
                          yearHeaderTitle: list[index].yearHeader.headerTitle),
                    ),
                  );
                  break;
                case ListItemType.PICTURE:
                  return KeepAlive(
                    keepAlive: true,
                    child: IndexedSemantics(
                      index: index,
                      child: GalleryPictureWidget(
                        picture: list[index].picture,
                        horizontalPadding: 0,
                        verticalPadding: 24,
                        onTap: (picture) {
                          setState(() {
                            print(picture.name);
                            selectedPicture = picture;
                            indexedStackIndex = 1;
                          });
                        },
                      ),
                    ),
                  );
                  break;
                default:
                  return Container(
                    color: Colors.black,
                  );
              }
            },
                childCount: list.length,
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: false,
                addSemanticIndexes: false),
          ),
        ],
      ),
    );
  }*/
}
