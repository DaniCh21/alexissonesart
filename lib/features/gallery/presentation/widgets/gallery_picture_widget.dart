import 'package:alexis_art/features/gallery/domain/entities/picture.dart';
import 'package:alexis_art/features/gallery/presentation/pages/picture_draggable_details_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class GalleryPictureWidget extends StatelessWidget {
  final Picture picture;

  final double thumbHeight;
  final double verticalPadding;
  final double horizontalPadding;
  final Function(Picture) onTap;

  GalleryPictureWidget({
    @required this.picture,
    @required this.verticalPadding, //24
    @required this.horizontalPadding, //6 for grid and 0 for one line
    /*@required*/ this.onTap,
    this.thumbHeight = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding == 0 ? 24 : verticalPadding,
            horizontal: horizontalPadding == 0 ? 0 : horizontalPadding),
        child: Container(
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/brown_logo.png",
                  height: thumbHeight,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  splashColor: Colors.amber,
                    onTap: () => onTap(picture),
//                  onTap: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (context) => PictureDraggableDetailsPage(
//                          picture: picture,
//                        ),
//                      ),
//                    );
//                  },
                  child: CachedNetworkImage(
                    imageUrl: picture.url,
                    filterQuality: FilterQuality.low,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
