import 'package:test_app/core/date_state.dart';
import 'package:test_app/core/params/search_movies_params.dart';
import 'package:test_app/domain/entities/movie_entity.dart';

import 'package:test_app/domain/repositories/movies_repository.dart';
import 'package:test_app/core/usecase.dart';

class GetMoviesUseCase implements UseCase<DataState<List<MovieEntity>>, SearchMoviesParams> {
  final IMoviesRepository _repository;

  GetMoviesUseCase(this._repository);

  @override
  Future<DataState<List<MovieEntity>>> call({required SearchMoviesParams params}) async {
    return await _repository.getMovies(params.search);
  }
}
