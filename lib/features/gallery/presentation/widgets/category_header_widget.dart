import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CategoryHeaderWidget extends StatelessWidget {
  final String categoryHeaderTitle;

  final TextStyle _style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontFamily: 'Pacifico',
      fontSize: 22);

  CategoryHeaderWidget({@required this.categoryHeaderTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Center(
        child: Text(categoryHeaderTitle, style: _style,),
      ),
    );
  }
}
