import 'package:test_app/core/date_state.dart';
import 'package:test_app/core/params/get_movie_detail_params.dart';
import 'package:test_app/domain/entities/detail_movie_entity.dart';
import 'package:test_app/domain/repositories/movies_repository.dart';
import 'package:test_app/core/usecase.dart';

class GetMovieByIdUseCase implements UseCase<DataState<DetailMovieEntity>, GetMovieDetailParams> {
  final IMoviesRepository _repository;

  GetMovieByIdUseCase(this._repository);

  @override
  Future<DataState<DetailMovieEntity>> call({required GetMovieDetailParams params}) async {
    return await _repository.getMovieById(params.id);
  }
}
