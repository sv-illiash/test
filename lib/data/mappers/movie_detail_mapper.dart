
import 'package:test_app/data/models/remout/response/detail_movie_response.dart';
import 'package:test_app/domain/entities/detail_movie_entity.dart';

class MovieDetailMapper {
  static DetailMovieEntity fromApi(DetailMovieResponse item) => DetailMovieEntity(
      id: item.id,
      imageUrl: item.posterPath,
      title: item.title,
      description: item.overview,
      popularity: item.popularity);
}
