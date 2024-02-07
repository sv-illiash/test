import 'package:flutter/material.dart';
import 'package:test_app/domain/entities/detail_movie_entity.dart';
import 'package:test_app/presentation/resources/text_resources.dart';
import 'package:test_app/presentation/view/movies_view/widgets/movies_title_widget.dart';
import 'package:test_app/presentation/view/widgets/cached_network_image_widget.dart';

class MovieDetailBody extends StatelessWidget {
  static const double heightImage = 300;

  final DetailMovieEntity movieDetail;

  const MovieDetailBody({Key? key, required this.movieDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: heightImage, child: CachedNetworkImageWidget(url: movieDetail.imageUrl)),
        TitleWidget(
          title: movieDetail.title,
          description: movieDetail.description,
        ),
        Expanded(child: Text('${AppTextResources.rating} : ${movieDetail.popularity}'))
      ],
    );
  }
}
