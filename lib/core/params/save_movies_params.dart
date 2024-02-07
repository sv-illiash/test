import 'package:test_app/domain/entities/movie_entity.dart';

class SaveMoviesParams {
  final List<MovieEntity> movies;

  SaveMoviesParams({required this.movies});
}
