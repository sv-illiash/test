import 'package:test_app/data/models/local/movie_model_local.dart';
import 'package:test_app/data/models/remout/response/movie_response.dart';
import 'package:test_app/domain/entities/movie_entity.dart';

class MoviesMapper {
  static List<MovieEntity> listFromApi(MoviesResponse list) {
    final List<MovieEntity> items = [];
    for (var element in list.results) {
      items.add(MovieEntity(
          id: element.id,
          title: element.title,
          imageUrl: element.posterPath,
          description: element.overview));
    }
    return items;
  }

  static List<MovieEntity> listFromCache(List<CashedModel> list) {
    final List<MovieEntity> items = [];
    for (var element in list) {
      items.add(MovieEntity(
          id: element.id,
          title: element.title,
          imageUrl: element.imageUrl,
          description: element.description));
    }
    return items;
  }

  static List<CashedModel> listToCache(List<MovieEntity> list) {
    return list
        .map((movie) => CashedModel(
              id: movie.id,
              title: movie.title,
              imageUrl: movie.imageUrl,
              description: movie.description,
            ))
        .toList();
  }
}
