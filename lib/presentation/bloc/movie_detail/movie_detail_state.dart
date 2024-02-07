part of 'movie_detail_bloc.dart';

abstract class IMovieDetailState extends Equatable {
  const IMovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends IMovieDetailState {}

class LoadMovieDetailState extends IMovieDetailState {
  final DetailMovieEntity item;

  const LoadMovieDetailState({required this.item});

  @override
  List<Object> get props => [item];
}

class LoadingDetailMovieState extends IMovieDetailState {
  const LoadingDetailMovieState();
}

class ErrorDetailMovieState extends IMovieDetailState {}
