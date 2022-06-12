import 'package:alexis_art/features/gallery/presentation/widgets/fetched_data_widget.dart';
import 'package:flutter/material.dart';

class TestingGalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FetchedData(
//          path: '/categories/1/Pictures',
//          path: '/categories/One Category/Pictures',
//          path: '/categories/Wordless Dimension Category/WD Pictures',
          path: '/categories/Kittens Category/Pictures',
          year: 2020,
//          year: 2019,
        ),
      ),
    );
  }
}
