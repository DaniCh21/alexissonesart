import 'package:alexis_art/features/gallery/presentation/pages/categories_holder_page.dart';
import 'package:alexis_art/features/gallery/presentation/pages/gallery_page.dart';
import 'package:alexis_art/features/gallery/presentation/widgets/hero_sliver_app_bar_widget.dart';
import 'package:alexis_art/features/process/presentation/pages/process_page.dart';
import 'package:alexis_art/features/shop/presentation/pages/in_development_page.dart';
import 'package:alexis_art/playground/current_drawer_tablet.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CategoryWidget extends StatelessWidget {
  final String imagePath;
  final String tag;
  final String title;

  const CategoryWidget({
    Key key,
    @required this.imagePath,
    @required this.tag,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Container(
        height: MediaQuery.of(context).size.width - 30.0,
        //width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Hero(
                transitionOnUserGestures: true,
                child: Image.asset(imagePath),
                tag: tag,
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Hero(
                  transitionOnUserGestures: true,
                  tag: '${tag}_text',
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Pacifico',
                        color: Colors.white,
                        fontSize: 38,
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
            Positioned.fill(
              child: new Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.amber,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => determineNextPage()),
//                      MaterialPageRoute(builder: (context) => page),
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

  dynamic determineNextPage() {
    switch (title) {
      case 'Gallery':
        return CategoriesHolderPage(
          slivers: <Widget>[
            HeroSliverAppBar(
              isGrid: false,
              title: 'Gallery',
              imagePath: 'assets/images/gallery_placeholder_img.jpg',
              tag: 'gallery_tag',
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                CategoryWidget(
                  title: 'Painting World',
                  imagePath: 'assets/images/pw_category_img.jpg',
                  tag: "painting_world_tag",
                ),
                CategoryWidget(
                  title: 'Digital Universe',
                  imagePath: 'assets/images/du_category_img.jpg',
                  tag: "digital_universe_tag",
                ),
                SizedBox(
                  height: 24,
                ),
              ]),
            ),
          ],
        );
        break;

      case 'Painting World':
        return CategoriesHolderPage(
          slivers: <Widget>[
            HeroSliverAppBar(
              isGrid: false,
              title: 'Painting World',
              imagePath: 'assets/images/pw_category_img.jpg',
              tag: 'painting_world_tag',
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                CategoryWidget(
                  title: 'Figure Realm',
                  imagePath: 'assets/images/fr_category_img.jpg',
                  tag: "figure_realm_tag",
                ),
                CategoryWidget(
                  title: 'Wordless Dimension',
                  imagePath: 'assets/images/wd_category_img.png',
                  tag: "wordless_dimension_tag",
                ),
                SizedBox(
                  height: 24,
                ),
              ]),
            ),
          ],
        );
        break;

      case 'Digital Universe':
        return CategoriesHolderPage(
          slivers: <Widget>[
            HeroSliverAppBar(
              isGrid: false,
              title: 'Digital Universe',
              imagePath: 'assets/images/du_category_img.jpg',
              tag: 'digital_universe_tag',
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                CategoryWidget(
                  title: 'IPad Paintings',
                  imagePath: 'assets/images/ipad_paintings_category_img.jpg',
                  tag: "ipad_paintings_tag",
                ),
                CategoryWidget(
                  title: 'Collages',
                  imagePath: 'assets/images/collages_category_img.jpg',
                  tag: "collages_tag",
                ),
                SizedBox(
                  height: 24,
                ),
              ]),
            ),
          ],
        );
        break;

      case 'Figure Realm':
        return CategoriesHolderPage(
          slivers: <Widget>[
            HeroSliverAppBar(
              isGrid: false,
              title: 'Figure Realm',
              imagePath: 'assets/images/fr_category_img.jpg',
              tag: 'figure_realm_tag',
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                CategoryWidget(
                  title: 'People',
                  imagePath: 'assets/images/fr_category_img.jpg',
                  tag: "people_tag",
                ),
                CategoryWidget(
                  title: 'Pets',
                  imagePath: 'assets/images/pets_category_img.jpg',
                  tag: "pets_tag",
                ),
                CategoryWidget(
                  title: 'Places',
                  imagePath: 'assets/images/places_category_img.jpg',
                  tag: "places_tag",
                ),
                CategoryWidget(
                  title: 'Things',
                  imagePath: 'assets/images/things_categories_img.jpg',
                  tag: "things_tag",
                ),
                SizedBox(
                  height: 24,
                ),
              ]),
            ),
          ],
        );
        break;

      case 'Wordless Dimension':
        return GalleryPage(
          path: 'assets/images/wd_category_img.png',
          tag: 'wordless_dimension_tag',
          title: 'Wordless Dimension',
          key: galleryPageGlobalKey,
        );
        break;

      case 'IPad Paintings':
        return GalleryPage(
          path: 'assets/images/ipad_paintings_category_img.jpg',
          tag: 'ipad_paintings_tag',
          title: 'IPad Paintings',
          key: galleryPageGlobalKey,
        );
        break;

      case 'Collages':
        return GalleryPage(
          path: 'assets/images/collages_category_img.jpg',
          tag: 'collages_tag',
          title: 'Collages',
          key: galleryPageGlobalKey,
        );
        break;

      case 'People':
        return GalleryPage(
          path: 'assets/images/fr_category_img.jpg',
          tag: 'people_tag',
          title: 'People',
          key: galleryPageGlobalKey,
        );
        break;

      case 'Pets':
        return GalleryPage(
          path: 'assets/images/pets_category_img.jpg',
          tag: 'pets_tag',
          title: 'Pets',
          key: galleryPageGlobalKey,
        );
        break;

      case 'Places':
        return GalleryPage(
          path: 'assets/images/places_category_img.jpg',
          tag: 'places_tag',
          title: 'Places',
          key: galleryPageGlobalKey,
        );
        break;

      case 'Things':
        return GalleryPage(
          path: 'assets/images/things_categories_img.jpg',
          tag: 'things_tag',
          title: 'Things',
          key: galleryPageGlobalKey,
        );
        break;

      case 'Shop':
        return InDevelopmentPage(
          title: 'Shop',
          path: 'assets/images/shop_placeholder_img.jpg',
          tag: 'shop_tag',
        );
        break;

      case 'The Process':
        // return InDevelopmentPage(
        //   title: 'Commissions',
        //   path: 'assets/images/commissions_placeholder_img.jpg',
        //   tag: 'commissions_tag',
        // );

        return ProcessPage(
          title: 'The Process',
          path: 'assets/images/process_placeholder_img.jpg',
          tag: 'the_process_tag',
        );
        break;

      case 'Commissions':
        //return CurrentDrawerTabletPage();
        return InDevelopmentPage(
          title: 'Commissions',
          path: 'assets/images/commissions_placeholder_img.jpg',
          tag: 'commissions_tag',
        );
        break;

      case 'About':
        return InDevelopmentPage(
          title: 'About',
          path: 'assets/images/about_category_img.jpg',
          tag: 'about_tag',
        );
        break;
    }
  }
}
