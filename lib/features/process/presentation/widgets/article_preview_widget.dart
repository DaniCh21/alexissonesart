import 'package:alexis_art/features/process/presentation/pages/article_page.dart';
import 'package:flutter/material.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

class ArticlePreviewWidget extends StatelessWidget {
  final String articleTitle;
  final String date;
  final String imagePath;
  final String tag;

  const ArticlePreviewWidget(
      {Key key,
      @required this.articleTitle,
      @required this.date,
      @required this.tag,
      @required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Container(
        height: MediaQuery.of(context).size.width - 30.0,
        //width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            // Hero image
            Positioned.fill(
              child: Hero(
                transitionOnUserGestures: true,
                child: Image.asset(imagePath),
                tag: tag,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                child: Material(
                  color: Colors.white,
                  shape: SuperellipseShape(
                    borderRadius: BorderRadius.circular(55),
                  ),
                  child: Container(
                    width: (date.length <= 6) ? 60 : 100,
                    height: 25,
                    child: Center(
                      child: Text(
                        date,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pacifico',
                          color: Colors.black,
                          fontSize: 14,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 2.0,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                        child: Hero(
                          transitionOnUserGestures: true,
                          tag: '${tag}_text',
                          child: Material(
                            type: MaterialType.transparency,
                            child: Text(
                              articleTitle,
                              style: TextStyle(
                                fontFamily: 'Pacifico',
                                color: Colors.white,
                                fontSize: 30,
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
                      ),
                    ),
                    Expanded(flex: 1, child: SizedBox()),
                  ]),
            ),
            //InkWell page route
            Positioned.fill(
              child: new Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.amber,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticlePage(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
