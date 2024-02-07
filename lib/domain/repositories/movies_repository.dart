import 'package:test_app/core/date_state.dart';
import 'package:test_app/domain/entities/detail_movie_entity.dart';
import 'package:test_app/domain/entities/movie_entity.dart';

abstract class IMoviesRepository {
  Future<DataState<List<MovieEntity>>> getMovies(String searchText);

  Future<DataState<DetailMovieEntity>> getMovieById(int id);

  Future<DataState<bool>> cacheMovies(List<MovieEntity> movies);

  Future<DataState<List<MovieEntity>>> getCashedMovies(String searchText);
}
