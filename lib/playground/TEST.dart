import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Draggable sheet demo',
      home: Scaffold(

        ///just for status bar color.
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: AppBar(
                primary: true,
                elevation: 0,
              )),
          body: Stack(
            children: <Widget>[
              Positioned(
                left: 0.0,
                top: 0.0,
                right: 0.0,
                child: PreferredSize(
                    preferredSize: Size.fromHeight(56.0),
                    child: AppBar(
                      title: Text("Standard bottom sheet demo"),
                      elevation: 2.0,
                    )),
              ),
              DraggableSearchableListView(),
            ],
          )),
    );
  }
}

class DraggableSearchableListView extends StatefulWidget {
  const DraggableSearchableListView({
    Key key,
  }) : super(key: key);

  @override
  _DraggableSearchableListViewState createState() =>
      _DraggableSearchableListViewState();
}

class _DraggableSearchableListViewState
    extends State<DraggableSearchableListView> {
  final TextEditingController searchTextController = TextEditingController();
  final ValueNotifier<bool> searchTextCloseButtonVisibility =
  ValueNotifier<bool>(false);
  final ValueNotifier<bool> searchFieldVisibility = ValueNotifier<bool>(false);
  @override
  void dispose() {
    searchTextController.dispose();
    searchTextCloseButtonVisibility.dispose();
    searchFieldVisibility.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        if (notification.extent == 1.0) {
          searchFieldVisibility.value = true;
        } else {
          searchFieldVisibility.value = false;
        }
        return true;
      },
      child: DraggableScrollableActuator(
        child: Stack(
          children: <Widget>[
            DraggableScrollableSheet(
              initialChildSize: 0.30,
              minChildSize: 0.15,
              maxChildSize: 1.0,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1.0, -2.0),
                          blurRadius: 4.0,
                          spreadRadius: 2.0)
                    ],
                  ),
                  child: ListView.builder(
                    controller: scrollController,

                    ///we have 25 rows plus one header row.                               itemCount: 25 + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return Container(
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 16.0,
                                    left: 24.0,
                                    right: 24.0,
                                  ),
                                  child: Text(
                                    "Favorites",
//                                    style:
//                                    Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Divider(color: Colors.grey),
                            ],
                          ),
                        );
                      }
                      return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: ListTile(title: Text('Item $index')));
                    },
                  ),
                );
              },
            ),
            Positioned(
              left: 0.0,
              top: 0.0,
              right: 0.0,
              child: ValueListenableBuilder<bool>(
                  valueListenable: searchFieldVisibility,
                  builder: (context, value, child) {
                    return value
                        ? PreferredSize(
                      preferredSize: Size.fromHeight(56.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1.0,
                                color: Theme.of(context).dividerColor),
                          ),
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        child: SearchBar(
                          closeButtonVisibility:
                          searchTextCloseButtonVisibility,
                          textEditingController: searchTextController,
                          onClose: () {
                            searchFieldVisibility.value = false;
                            DraggableScrollableActuator.reset(context);
                          },
                          onSearchSubmit: (String value) {
                            ///submit search query to your business logic component
                          },
                        ),
                      ),
                    )
                        : Container();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final TextEditingController textEditingController;
  final ValueNotifier<bool> closeButtonVisibility;
  final ValueChanged<String> onSearchSubmit;
  final VoidCallback onClose;

  const SearchBar({
    Key key,
    @required this.textEditingController,
    @required this.closeButtonVisibility,
    @required this.onSearchSubmit,
    @required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 56.0,
              width: 56.0,
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  child: Icon(
                    Icons.arrow_back,
                    color: theme.textTheme.caption.color,
                  ),
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    textEditingController.clear();
                    closeButtonVisibility.value = false;
                    onClose();
                  },
                ),
              ),
            ),
            SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: TextFormField(
                onChanged: (value) {
                  if (value != null && value.length > 0) {
                    closeButtonVisibility.value = true;
                  } else {
                    closeButtonVisibility.value = false;
                  }
                },
                onFieldSubmitted: (value) {
                  FocusScope.of(context).unfocus();
                  onSearchSubmit(value);
                },
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                textCapitalization: TextCapitalization.none,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.left,
                maxLines: 1,
                controller: textEditingController,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: "Search here",
                ),
              ),
            ),
            ValueListenableBuilder<bool>(
                valueListenable: closeButtonVisibility,
                builder: (context, value, child) {
                  return value
                      ? SizedBox(
                    width: 56.0,
                    height: 56.0,
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        child: Icon(
                          Icons.close,
                          color: theme.textTheme.caption.color,
                        ),
                        onTap: () {
                          closeButtonVisibility.value = false;
                          textEditingController.clear();
                        },
                      ),
                    ),
                  )
                      : Container();
                })
          ],
        ),
      ),
    );
  }
}


// Row(
// children: <Widget>[
// if (widget.isOwnProfile && !isSearchMode)
// Expanded(
// flex: 1,
// child: Align(
// alignment: Alignment.topLeft,
// child: InkWell(
// child: Row(
// children: <Widget>[
// SvgPicture.asset(
// 'assets/images/ic_crown.svg',
// color: Color(darkGreen),
// ),
// SizedBox(
// width: 2,
// ),
// Text(user?.prestige?.parseToNumWithLetter()),
// ],
// ),
// onTap: () {
// showModalBottomSheet(
// context: context,
// builder: (context) {
// return MyPaymentWidget(user?.prestige);
// });
// },
// ),
// ),
// ),
// if (!widget.isOwnProfile || isSearchMode)
// Expanded(
// flex: 1,
// child: Align(
// alignment: Alignment.topLeft,
// child: InkWell(
// onTap: () {
// if (isSearchMode) {
// setState(() {
// isSearchMode = false;
// });
// } else {
// navBloc.add(NavPop());
// }
// },
// child: SvgPicture.asset(
// 'assets/images/ic_back_arrow.svg',
// color: Color(darkGreen),
// ),
// ),
// ),
// ),
// Expanded(
// flex: 5,
// child: SvgPicture.asset('assets/images/logo_toptop_small.svg'),
// ),
// Expanded(
// flex: 1,
// child: Align(
// alignment: Alignment.topRight,
// child: Opacity(
// opacity: widget.isOwnProfile ? 1 : 0.0,
// child: InkWell(
// child: Icon(
// Icons.settings,
// color: Color(darkGreen),
// ),
// onTap: () {
// setState(() {
// if (isSearchMode) isSearchMode = false;
// isConfigsMode = !isConfigsMode;
// });
// },
// ),
// ),
// ),
// ),
// ],
// ),

// child: widget.isOwnProfile
// ? !isSearchMode
// ? buildWhiteButtonWithText('Sign out', () {
// authBloc.add(SignOutEvent());
// userBloc.add(LogoutUserEvent());
// })
// : SizedBox.shrink()
// : isInFollow
// ? buildWhiteButtonWithText('Remove friend',
// () => _onClickFollowOrNoOther(user, isInFollow))
// : buildWhiteButtonWithText('Add friend',
// () => _onClickFollowOrNoOther(user, isInFollow))),
// ),
// !isSearchMode
// ? SizedBox(
// height: 18,
// )
// : SizedBox.shrink(),


/// Animated Bottom Alert Dialog
// showGeneralDialog(
// barrierLabel: "Label",
// barrierDismissible: true,
// barrierColor: Colors.black.withOpacity(0.5),
// transitionDuration: Duration(milliseconds: 500),
// context: context,
// pageBuilder: (context, anim1, anim2) {
// return Align(
// alignment: Alignment.bottomCenter,
// child: Container(
// height: 300,
// child: SizedBox.expand(child: FlutterLogo()),
// margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(40),
// ),
// ),
// );
// },
// transitionBuilder: (context, anim1, anim2, child) {
// return SlideTransition(
// position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
// child: child,
// );
// },
// );