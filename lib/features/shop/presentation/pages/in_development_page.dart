import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:meta/meta.dart';

//TODO placeholder page. In development

class InDevelopmentPage extends StatelessWidget {
//  static const routeName = '/shop';

  final String path;
  final String tag;
  final String title;

  InDevelopmentPage(
      {@required this.title, @required this.path, @required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Transform.rotate(
              angle: -math.pi / 4,
              child: Text(
                'Currently in development',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      leading: Padding(
        padding: EdgeInsets.all(6),
        child: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 1.0,
                top: 2.0,
                child: Icon(Icons.arrow_back_ios, color: Colors.black54),
              ),
              Icon(Icons.arrow_back_ios, color: Colors.white),
            ],
          ),
        ),
      ),
      pinned: false,
      floating: false,
      expandedHeight: MediaQuery.of(context).size.width - 27,
      flexibleSpace: FlexibleSpaceBar(
        title: Hero(
          tag: "${tag}_text",
          child: Material(
            type: MaterialType.transparency,
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Pacifico',
                color: Colors.white,
                fontSize: 20,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 5.0,
                    color: Colors.black26,
                  ),
                ],
              ),
            ),
          ),
        ),
        background: Hero(tag: tag, child: Image.asset(path)),
      ),
    );
  }
}
