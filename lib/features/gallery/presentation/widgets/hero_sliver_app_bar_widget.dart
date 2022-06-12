import 'package:flutter/material.dart';

class HeroSliverAppBar extends StatelessWidget {
  final String imagePath;
  final String tag;
  final String title;
  final Function iconOnTap;
  final bool isGrid;

  HeroSliverAppBar({
    @required this.title,
    @required this.imagePath,
    @required this.tag,
    this.iconOnTap,
    @required this.isGrid,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      //stretch: true,
      titleSpacing: 0,
      actions: iconOnTap == null
          ? <Widget>[]
          : <Widget>[
              Padding(
                padding: EdgeInsets.all(6),
                child: InkWell(
                  onTap: () => iconOnTap(),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 1.0,
                        top: 2.0,
                        child: Icon(
                            isGrid ? Icons.view_column : Icons.view_agenda,
                            color: Colors.black54),
                      ),
                      Icon(isGrid ? Icons.view_column : Icons.view_agenda,
                          color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
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
      //TODO figure out how to make it look as a perfect square without space above
      expandedHeight: MediaQuery.of(context).size.width - 50,
      flexibleSpace: FlexibleSpaceBar(
        title: Hero(
          tag: "${tag}_text1",
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
        background: Hero(tag: tag, child: Image.asset(imagePath)),
      ),
    );
  }
}
