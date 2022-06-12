// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:toptop_app/common/colors.dart';
//
// class SearchWidget extends StatefulWidget {
//   final String searchHint;
//   final TextEditingController _searchTextController;
//   bool _isSearchActive;
//   final bool _isSearchError;
//
//   SearchWidget(
//       [this.searchHint,
//       this._searchTextController,
//       this._isSearchActive = false,
//       this._isSearchError = false]);
//
//   @override
//   State<StatefulWidget> createState() {
//     return _SearchWidgetState();
//   }
// }
//
// class _SearchWidgetState extends State<SearchWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       shape: widget._isSearchActive
//           ? RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16.0),
//               side: BorderSide(
//                 color: Color(widget._isSearchError ? redColor : darkGreen),
//                 width: 1,
//               ),
//             )
//           : RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16.0),
//             ),
//       child: Padding(
//         padding: const EdgeInsets.only(left: 10),
//         child: TextField(
//           textCapitalization: TextCapitalization.words,
//           cursorColor: Color(darkGreen),
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.only(top: 13.0),
//             hintText: widget.searchHint,
//             hintStyle: TextStyle(
//               color: Color(lightGreen),
//               fontSize: 14,
//             ),
//             border: InputBorder.none,
//             suffixIcon: widget._isSearchActive
//                 ? InkWell(
//                     child: Icon(
//                       Icons.close,
//                       color: Color(darkGreen),
//                     ),
//                     onTap: () {
//                       if (widget._isSearchActive)
//                         widget._searchTextController.text = "";
//                       if (widget._searchTextController.text == "") {
//                         FocusScope.of(context).unfocus();
//                         setState(() {
//                           widget._isSearchActive = false;
//
//                           print('^^' + widget._isSearchActive.toString());
//                         });
//                       }
//                     },
//                   )
//                 : InkWell(
//                     child: Icon(
//                       Icons.search,
//                       color: Color(lightGreen),
//                     ),
//                     onTap: () {
//                       setState(() {
//                         widget._isSearchActive = true;
//                       });
//                     }
//
//                     // child: Icon(
//                     //   widget._isSearchActive ? Icons.close : Icons.search,
//                     //   color: Color(widget._isSearchActive ? darkGreen : lightGreen),
//                     // ),
//                     // onTap: () {
//                     //   if (widget._isSearchActive) widget._searchTextController.text = "";
//                     //   if (widget._searchTextController.text == "") {
//                     //     FocusScope.of(context).unfocus();
//                     //     setState(() {
//                     //       widget._isSearchActive = false;
//                     //
//                     //       print('^^' + widget._isSearchActive.toString());
//                     //     });
//                     //   }
//                     // },
//
//                     ),
//           ),
//           controller: widget._searchTextController,
//         ),
//       ),
//     );
//   }
// }
