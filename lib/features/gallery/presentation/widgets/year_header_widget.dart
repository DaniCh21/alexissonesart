import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class YearHeaderWidget extends StatelessWidget {
  final String yearHeaderTitle;

  final TextStyle _style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontFamily: 'Pacifico',
      fontSize: 35);

  YearHeaderWidget({@required this.yearHeaderTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 0),
      child: Center(
        child: Text(
          yearHeaderTitle,
          style: _style,
        ),
      ),
    );
  }
}
