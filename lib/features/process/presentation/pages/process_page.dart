import 'package:alexis_art/features/gallery/presentation/widgets/hero_sliver_app_bar_widget.dart';
import 'package:alexis_art/features/gallery/presentation/widgets/loading_widget.dart';
import 'package:alexis_art/features/process/domain/entities/articles_batch.dart';
import 'package:alexis_art/features/process/domain/usecases/get_articles_batch.dart';
import 'package:alexis_art/features/process/presentation/bloc/bloc.dart';
import 'package:alexis_art/features/process/presentation/widgets/article_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class ProcessPage extends StatefulWidget {
  final String tag;
  final String title;
  final String path;

  const ProcessPage({Key key, this.tag, this.title, this.path})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProcessPageState();
  }
}

class ProcessPageState extends State<ProcessPage> {
  ProcessBloc processBloc;

  @override
  void initState() {
    BlocProvider.of<ProcessBloc>(context).add(GetArticlesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/process_background_img.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          CustomScrollView(
            slivers: <Widget>[
              HeroSliverAppBar(
                title: widget.title,
                imagePath: widget.path,
                isGrid: false,
                tag: widget.tag,
              ),
              SliverToBoxAdapter(
                child: BlocProvider(
                  create: (_) => sl<ProcessBloc>(),
                  child: BlocBuilder<ProcessBloc, ProcessState>(
                    builder: (context, state) {
                      if (state is LoadingArticlesState) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 100.0),
                          child:
                              LoadingWidget(loadingMessage: 'Loading articles'),
                        );
                      }
                      if (state is LoadedArticlesState) {
                        return SliverList(
                          delegate: SliverChildListDelegate([
                            ArticlePreviewWidget(
                              tag: 'uncolonize_imagination',
                              imagePath:
                                  'assets/images/process/uncolonize_your_imagination_arc_img.jpg',
                              articleTitle: 'Uncolonize Your Imagination',
                              date: 'Jul 17',
                            ),
                            ArticlePreviewWidget(
                              tag: 'break_through_to_beginning',
                              imagePath:
                                  'assets/images/process/break_through_to_beginning_arc_img.jpg',
                              articleTitle: 'Break Through to the Beginning',
                              date: 'Apr 28',
                            ),
                            ArticlePreviewWidget(
                              tag: 'passion_as_way_of_being',
                              imagePath:
                                  'assets/images/process/passion_as_a_way_of_being_arc_img.jpg',
                              articleTitle: 'Passion as a Way of Being',
                              date: 'Mar 28',
                            ),
                            ArticlePreviewWidget(
                              tag: 'passion_of_kobe',
                              imagePath:
                                  'assets/images/process/this_man_has_you_arc_img.png',
                              articleTitle: 'The Passion of Kobe',
                              date: 'Mar 1',
                            ),
                            ArticlePreviewWidget(
                              tag: 'what_is_self_love',
                              imagePath:
                                  'assets/images/process/falling_angels_arc_img.jpg',
                              articleTitle: 'What is self love?',
                              date: 'Jan 10, 2019',
                            ),
                          ]),
                        );
                      } else {
                        return Container(height: 0.0);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildListOfArticles(ArticlesBatch articlesBatch) {
  SliverList(
    delegate: SliverChildListDelegate([
      ArticlePreviewWidget(
        tag: 'uncolonize_imagination',
        imagePath:
            'assets/images/process/uncolonize_your_imagination_arc_img.jpg',
        articleTitle: 'Uncolonize Your Imagination',
        date: 'Jul 17',
      ),
      ArticlePreviewWidget(
        tag: 'break_through_to_beginning',
        imagePath:
            'assets/images/process/break_through_to_beginning_arc_img.jpg',
        articleTitle: 'Break Through to the Beginning',
        date: 'Apr 28',
      ),
      ArticlePreviewWidget(
        tag: 'passion_as_way_of_being',
        imagePath:
            'assets/images/process/passion_as_a_way_of_being_arc_img.jpg',
        articleTitle: 'Passion as a Way of Being',
        date: 'Mar 28',
      ),
      ArticlePreviewWidget(
        tag: 'passion_of_kobe',
        imagePath: 'assets/images/process/this_man_has_you_arc_img.png',
        articleTitle: 'The Passion of Kobe',
        date: 'Mar 1',
      ),
      ArticlePreviewWidget(
        tag: 'what_is_self_love',
        imagePath: 'assets/images/process/falling_angels_arc_img.jpg',
        articleTitle: 'What is self love?',
        date: 'Jan 10, 2019',
      ),
    ]),
  );
}
