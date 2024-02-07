import 'package:test_app/core/date_state.dart';
import 'package:test_app/data/datasources/local/database/database_operations.dart';
import 'package:test_app/data/datasources/remote/app_api_service.dart';
import 'package:test_app/data/extensions/api_extensions.dart';
import 'package:test_app/data/mappers/movie_detail_mapper.dart';
import 'package:test_app/data/mappers/movies_mapper.dart';
import 'package:test_app/domain/entities/detail_movie_entity.dart';
import 'package:test_app/domain/entities/movie_entity.dart';
import 'package:test_app/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl extends IMoviesRepository {
  final AppApiService _appApiService;
  final DBOperation _dbOperation;

  MoviesRepositoryImpl(this._appApiService, this._dbOperation);

  @override
  Future<DataState<List<MovieEntity>>> getMovies(String searchText) async => await doSafeApiCall(
      () async => await _appApiService.searchMovies(searchText),
      (response) => MoviesMapper.listFromApi(response));

  @override
  Future<DataState<DetailMovieEntity>> getMovieById(int id) async => await doSafeApiCall(
      () async => await _appApiService.getMovieById(id),
      (response) => MovieDetailMapper.fromApi(response));

  @override
  Future<DataState<bool>> cacheMovies(List<MovieEntity> movies) async => await doSafeDbCall(
      () async => _dbOperation.insertMovies(MoviesMapper.listToCache(movies)), (response) => true);

  @override
  Future<DataState<List<MovieEntity>>> getCashedMovies(String searchText) async =>
      await doSafeDbCall(() async => _dbOperation.selectMoviesByTitle(searchText),
          (response) => MoviesMapper.listFromCache(response));
}
