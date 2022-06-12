import 'package:alexis_art/features/home/presentation/widgets/category_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: false,
              floating: false,
              expandedHeight: 120.0,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsetsDirectional.only(start: 16, bottom: 16),
                background: Image.asset(
                    'assets/images/alexis_sones_home_title_upscaled_img.png'),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                CategoryWidget(
                  title: 'Gallery',
                  imagePath: 'assets/images/gallery_placeholder_img.jpg',
                  tag: "gallery_tag",
                ),
                CategoryWidget(
                  title: 'Shop',
                  imagePath: 'assets/images/shop_placeholder_img.jpg',
                  tag: "shop_tag",
                ),
                CategoryWidget(
                    title: 'The Process',
                    imagePath: 'assets/images/process_placeholder_img.jpg',
                    tag: "the_process_tag"),
                CategoryWidget(
                    title: 'Commissions',
                    imagePath: 'assets/images/commissions_placeholder_img.jpg',
                    tag: "commissions_tag"),
                CategoryWidget(
                    title: 'About',
                    imagePath: 'assets/images/about_category_img.jpg',
                    tag: "about_tag"),
                SizedBox(
                  height: 24,
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
