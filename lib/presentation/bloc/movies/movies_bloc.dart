import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app/core/date_state.dart';
import 'package:test_app/core/params/save_movies_params.dart';
import 'package:test_app/core/params/search_movies_params.dart';
import 'package:test_app/domain/entities/movie_entity.dart';
import 'package:test_app/domain/usecases/cache_movies_usecase.dart';
import 'package:test_app/domain/usecases/get_cashed_movies_usecse.dart';
import 'package:test_app/domain/usecases/get_movies_usecase.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<IMoviesEvent, IMoviesState> {
  final GetMoviesUseCase _getMoviesUseCase;
  final CacheMoviesUseCase _saveMoviesUseCase;
  final GetCashedMoviesUseCase _getCashedMoviesUseCase;

  MoviesBloc(this._getMoviesUseCase, this._saveMoviesUseCase, this._getCashedMoviesUseCase)
      : super(MoviesInitial()) {
    on<LoadMoviesEvent>((event, emit) async {
      emit(MoviesLoading());

      final cashedData =
          await _getCashedMoviesUseCase(params: SearchMoviesParams(search: event.search));

      if (cashedData is DataSuccess<List<MovieEntity>> && cashedData.data.isNotEmpty) {
        emit(MoviesLoadedState(cashedData.data));
      } else {
        _getFromApi(event.search);
      }
    });
  }

  void _getFromApi(String search) async {
    final data = await _getMoviesUseCase(params: SearchMoviesParams(search: search));

    if (data is DataSuccess<List<MovieEntity>>) {
      if (data.data.isNotEmpty) {
        emit(MoviesLoadedState(data.data));
        _cacheMovies(data.data);
      } else {
        emit(MoviesEmptyLoadedState());
      }
      if (data is DataFailed<String>) {
        emit(ErrorMoviesState());
      }
    }
  }

  void _cacheMovies(List<MovieEntity> movies) async =>
      await _saveMoviesUseCase(params: SaveMoviesParams(movies: movies));
}
