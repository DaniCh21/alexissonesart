import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CategoriesHolderPage extends StatelessWidget {
  final List<Widget> slivers;

  CategoriesHolderPage({@required this.slivers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: slivers,
      ),
    );
  }
}
