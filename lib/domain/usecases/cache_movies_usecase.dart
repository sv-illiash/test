import 'package:test_app/core/date_state.dart';
import 'package:test_app/core/params/save_movies_params.dart';
import 'package:test_app/core/usecase.dart';
import 'package:test_app/domain/repositories/movies_repository.dart';

class CacheMoviesUseCase implements UseCase<DataState<bool>, SaveMoviesParams> {
  final IMoviesRepository _repository;

  CacheMoviesUseCase(this._repository);

  @override
  Future<DataState<bool>> call({required SaveMoviesParams params}) async {
    return await _repository.cacheMovies(params.movies);
  }
}
