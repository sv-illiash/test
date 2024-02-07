import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app/core/date_state.dart';
import 'package:test_app/core/params/get_movie_detail_params.dart';
import 'package:test_app/domain/entities/detail_movie_entity.dart';
import 'package:test_app/domain/usecases/get_movie_by_id_usecase.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<IMovieDetailEvent, IMovieDetailState> {
  final GetMovieByIdUseCase _getMovieByIdUseCase;

  MovieDetailBloc(this._getMovieByIdUseCase) : super(MovieDetailInitial()) {
    on<LoadDetailMovie>((event, emit) async {
      emit(const LoadingDetailMovieState());

      final dataState = await _getMovieByIdUseCase(params: event.params);

      if (dataState is DataSuccess<DetailMovieEntity>) {
        emit(LoadMovieDetailState(item: dataState.data));
      }
      if (dataState is DataFailed<DetailMovieEntity>) {
        emit(ErrorDetailMovieState());
      }
    });
  }
}
