import 'package:flutter/material.dart';
import 'package:test_app/domain/entities/movie_entity.dart';

import 'package:test_app/presentation/view/movies_view/widgets/movies_title_widget.dart';
import 'package:test_app/presentation/view/widgets/cached_network_image_widget.dart';

class MoviesItemWidget extends StatelessWidget {
  static const double imageHeight = 160;
  static const double imageWidth = 100;
  final int index;
  final MovieEntity movieItem;
  final Function(int id) onTap;

  const MoviesItemWidget(
      {Key? key, required this.movieItem, required this.index, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(movieItem.id),
      child: Row(
        children: [
          SizedBox(
              height: imageHeight,
              width: imageWidth,
              child: CachedNetworkImageWidget(url: movieItem.imageUrl)),
          TitleWidget(
            title: movieItem.title,
            description: movieItem.description,
          )
        ],
      ),
    );
  }
}
