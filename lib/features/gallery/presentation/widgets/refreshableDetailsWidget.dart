import 'package:alexis_art/features/gallery/domain/entities/picture.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:meta/meta.dart';

class RefreshableDetailsWidget extends StatefulWidget {
  Picture picture;
  Function backButtonCallback;

  RefreshableDetailsWidget({
    @required this.backButtonCallback,
    @required this.picture,
    Key key,
  }) : super(key: key);

  @override
  _RefreshableDetailsWidgetState createState() {
    return _RefreshableDetailsWidgetState(
      picture: picture,
      key: key,
    );
  }
}

class _RefreshableDetailsWidgetState extends State<RefreshableDetailsWidget> {
  Picture picture;

  final ValueNotifier<bool> bottomSheetVisibility = ValueNotifier<bool>(true);
  final ValueNotifier<bool> backButtonVisibility = ValueNotifier<bool>(true);

  final Key key;

  _RefreshableDetailsWidgetState({
    @required this.picture,
    @required this.key,
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (picture != null && picture.url.isNotEmpty) {
      return Scaffold(
        body: Stack(
          children: <Widget>[
            Center(
              child: PhotoView(
                scaleStateChangedCallback: (state) {
                  if (state != PhotoViewScaleState.initial) {
                    bottomSheetVisibility.value = false;
                    backButtonVisibility.value = false;
                  } else {
                    bottomSheetVisibility.value = true;
                    backButtonVisibility.value = true;
                  }
                },
                backgroundDecoration: BoxDecoration(
                  color: Colors.white,
                ),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2.5,
                initialScale: PhotoViewComputedScale.contained,
                enableRotation: false,
                imageProvider: CachedNetworkImageProvider(picture.url),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: bottomSheetVisibility,
              builder: (context, value, child) {
                return value
                    ? SafeArea(
                        child: DraggableListView(
                          picture: picture,
                        ),
                      )
                    : Container(
                        height: 0,
                        width: 0,
                      );
              },
            ),
            ValueListenableBuilder(
              valueListenable: backButtonVisibility,
              builder: (context, value, child) {
                return value
                    ? SafeArea(
                        child: Padding(
                          padding: EdgeInsets.only(top: 6.0),
                          child: RawMaterialButton(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            padding: EdgeInsets.all(0.0),
                            fillColor: Colors.black.withAlpha(0),
                            shape: CircleBorder(),
                            onPressed: () => widget.backButtonCallback(),
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  left: 1.0,
                                  top: 2.0,
                                  child: Icon(Icons.arrow_back_ios,
                                      color: Colors.black54),
                                ),
                                Icon(Icons.arrow_back_ios, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(
                        height: 0,
                        width: 0,
                      );
              },
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Container(
//          color: Colors.purple,
          height: 150,
          width: 150,
        ),
      );
    }
  }
}

class DraggableListView extends StatefulWidget {
  final Picture picture;

  DraggableListView({
    @required this.picture,
    Key key,
  }) : super(key: key);

  @override
  _DraggableListViewState createState() =>
      _DraggableListViewState(picture: picture);
}

class _DraggableListViewState extends State<DraggableListView> {
  final Picture picture;

  bool isBottomSheetVisible = true;

  static double minChildSize = 0.1;
  static double initialChildSize = 0.1;

  BuildContext draggableSheetContext;

  final ValueNotifier<bool> minimizeButtonVisibility =
      ValueNotifier<bool>(false);

  _DraggableListViewState({@required this.picture});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isBottomSheetVisible,
      child: NotificationListener<DraggableScrollableNotification>(
        onNotification: (notification) {
          if (notification.extent >= 0.2) {
            minimizeButtonVisibility.value = true;
          } else {
            minimizeButtonVisibility.value = false;
          }
          return true;
        },
        child: _buildCustomDraggableScrollableSheet(),
      ),
    );
  }

  Widget _buildCustomDraggableScrollableSheet() {
    return DraggableScrollableActuator(
      child: DraggableScrollableSheet(
        initialChildSize: initialChildSize,
        minChildSize: minChildSize,
        maxChildSize: 1,
        builder: _draggableScrollableSheetBuilder,
      ),
    );
  }

  Widget _draggableScrollableSheetBuilder(
    BuildContext context,
    ScrollController scrollController,
  ) {
    draggableSheetContext = context;
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(70),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: ListView(
            padding: EdgeInsets.only(top: 7),
            controller: scrollController,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 5,
                    child: Center(
                      child: Text(
                        picture.name,
                        textAlign: TextAlign.center,
                        style: pacificoTextStyle(fontSize: 35),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                ],
              ),
              Center(
                child: Text(
                  picture.year,
                  style: pacificoTextStyle(fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Text(
                    picture.description,
                    style: regularTextStyle(fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  picture.size != '' ? 'Size: ' + picture.size : '',
                  style: regularTextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
        ValueListenableBuilder(
            valueListenable: minimizeButtonVisibility,
            builder: (context, value, child) {
              return value
                  ? Positioned(
                      top: 15,
                      right: 15,
                      child: InkWell(
                        onTap: () {
                          minimizeButtonVisibility.value = false;
                          DraggableScrollableActuator.reset(context);
                        },
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                          size: 45,
                        ),
                      ),
                    )
                  : Container();
            }),
      ],
    );
  }

  dynamic pacificoTextStyle({@required double fontSize}) {
    return TextStyle(
      fontFamily: 'Pacifico',
      color: Colors.white,
      fontSize: fontSize,
    );
  }

  dynamic regularTextStyle({@required double fontSize}) {
    return TextStyle(
      color: Colors.white,
      fontSize: fontSize,
      shadows: <Shadow>[
        Shadow(
          offset: Offset(0.5, 1.0),
          blurRadius: 1.0,
          color: Colors.white,
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
