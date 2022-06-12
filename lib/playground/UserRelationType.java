//import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:toptop_app/common/utils/debouncer.dart';
//import 'package:toptop_app/domain/entities/contact.dart';
//import 'package:toptop_app/injection_container.dart';
//import 'package:toptop_app/presentation/bloc/bloc.dart';
//import 'package:toptop_app/presentation/widgets/list_item_user.dart';
//import 'package:toptop_app/presentation/widgets/search_widget.dart';
//
//enum UserRelationType { FRIENDS, FOLLOWERS, FOLLOWING, OTHERS }
//
//class SearchUsersPage extends StatefulWidget {
//  static const routeName = '/search-users';
//
//  final List<Contact> followingList;
//  final List<Contact> followersList;
//  final List<Contact> friendsList;
//  final UserRelationType userRelationType;
//  final Function(Contact contact, bool isAdd) _clickAddContact;
//
//  SearchUsersPage(this.followingList, this.followersList, this.friendsList,
//      this.userRelationType, this._clickAddContact);
//
//  @override
//  _SearchUsersPageState createState() => _SearchUsersPageState();
//}
//
//class _SearchUsersPageState extends State<SearchUsersPage> {
//  TextEditingController _searchTextController;
//  SearchUsersBloc searchUsersBloc;
//  String searchWord = "";
//  NavBloc navBloc;
//  UserBloc userBloc;
//  bool isSearchActive = false;
//  String _userRelationTypeTitle = "";
//
//  final _debouncer = Debouncer(milliseconds: 500);
//
//  _SearchUsersPageState() {
//    searchUsersBloc = getIt<SearchUsersBloc>();
//    navBloc = getIt<NavBloc>();
//    userBloc = getIt<UserBloc>();
//    _searchTextController = TextEditingController();
//  }
//
//  @override
//  void initState() {
//    if (widget.userRelationType == UserRelationType.FOLLOWERS)
//      _userRelationTypeTitle = "Followers";
//    else if (widget.userRelationType == UserRelationType.FOLLOWING)
//      _userRelationTypeTitle = "Followings";
//    else if (widget.userRelationType == UserRelationType.FRIENDS)
//      _userRelationTypeTitle = "Friends";
//    else
//      _userRelationTypeTitle = "Others";
//    _searchTextController.addListener(_onSearchChanged);
//
//    super.initState();
//  }
//
//  _onSearchChanged() {
//    setState(() {
//      if (!isSearchActive) {
//        isSearchActive = true;
//      }
//      searchWord = _searchTextController.text;
//    });
//
//    if (widget.userRelationType == UserRelationType.FRIENDS ||
//        widget.userRelationType == UserRelationType.OTHERS) {
//      _debouncer.run(() => {
//            if (_searchTextController.text.isNotEmpty)
//              {_searchUsers(_searchTextController.text)}
//          });
//    }
//  }
//
//  _searchUsers(String searchkey) {
//    searchUsersBloc.add(DoSearchUsersEvent(searchkey));
//  }
//
//  _clickOnUser(Contact user) {
//    var isInFollow = (widget.followingList.contains(user) ||
//        widget.friendsList.contains(user));
//    navBloc.add(NavProfileEvent([false, user.id, isInFollow]));
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return GestureDetector(
//      onTap: () {
//        FocusScope.of(context).unfocus();
//      },
//      child: Container(
//        color: Colors.white,
//        child: Padding(
//          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Text(
//                _userRelationTypeTitle,
//                style: TextStyle(fontWeight: FontWeight.bold),
//              ),
//              SizedBox(
//                height: 20,
//              ),
//              SearchWidget("Search", _searchTextController, isSearchActive),
//              SizedBox(
//                height: 10,
//              ),
//              if (widget.userRelationType == UserRelationType.FOLLOWERS)
//                buildList(widget.followersList),
//              if (widget.userRelationType == UserRelationType.FOLLOWING)
//                buildList(widget.followingList),
//              if (widget.userRelationType == UserRelationType.FRIENDS)
//                if (widget.friendsList.length > 0)
//                  buildList(widget.friendsList)
//                else
//                  buildEmptyList('You have no friends yet :('),
//              if (widget.userRelationType == UserRelationType.OTHERS ||
//                  widget.userRelationType == UserRelationType.FRIENDS)
//                Expanded(
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      if (widget.userRelationType == UserRelationType.FRIENDS)
//                        Text(
//                          "Others",
//                          style: TextStyle(fontWeight: FontWeight.bold),
//                        ),
//                      if (widget.userRelationType == UserRelationType.FRIENDS)
//                        SizedBox(
//                          height: 20,
//                        ),
////                Expanded(
//                      BlocBuilder(
//                        bloc: searchUsersBloc,
//                        builder: (context, state) {
//                          if (state is LoadSearchUsersState) {
//                            return buildLoading();
//                          } else if (state is ResultSearchUsersState) {
//                            if (state.usersList.length > 0) {
//                              return buildList(state.usersList);
//                            } else {
//                              return buildEmptyList('No results');
//                            }
//                          } else {
//                            return SizedBox.shrink();
//                          }
//                        },
//                      ),
////                ),
//                    ],
//                  ),
//                ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//
//  Widget buildList(List<Contact> usersList) {
//    return usersList.length > 0
//        ? Flexible(
//            flex: 1,
//            fit: FlexFit.tight,
//            child: ListView.builder(
//              itemBuilder: (context, index) {
//                var user = usersList[index];
//                bool isInFollow = (widget.followingList.contains(user) ||
//                    widget.friendsList.contains(user));
//                return user.name
//                        .toLowerCase()
//                        .contains(searchWord.toLowerCase())
//                    ? ListItemUser(user, widget.userRelationType, isInFollow,
//                        (Contact user, bool isAdd) {
//                        widget._clickAddContact(user, isAdd);
//                        _clickAddContact(user, isAdd);
//                      })
//                    : SizedBox.shrink();
//              },
//              itemCount: usersList.length,
//            ),
//          )
//        : buildEmptyList('No results');
//  }
//
//  _clickAddContact(Contact contact, bool isAdd) {
//    if (isAdd) {
//      contact.relation = 1;
//      setState(() {
//        widget.followingList.add(contact);
//      });
//    } else {
//      setState(() {
//        if (widget.followingList.contains(contact)) {
//          widget.followingList.remove(contact);
//        } else if (widget.friendsList.contains(contact)) {
//          widget.friendsList.remove(contact);
//        }
//      });
//    }
//  }
//
//  Widget buildLoading() {
//    return Center(
////      child: Text('Loading...'),
//        );
//  }
//
//  Widget buildEmptyList(String placeholder) {
//    return Padding(
//      padding: const EdgeInsets.only(top: 10.0),
//      child: Center(
//        child: Text(
//          placeholder,
//          style: TextStyle(fontWeight: FontWeight.bold),
//        ),
//      ),
//    );
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//  }
//}