part of 'movies_bloc.dart';

abstract class IMoviesState extends Equatable {
  const IMoviesState();

  @override
  List<Object> get props => [];
}

class MoviesInitial extends IMoviesState {}

class MoviesLoading extends IMoviesState {}

class MoviesLoadedState extends IMoviesState {
  final List<MovieEntity> items;

  const MoviesLoadedState(this.items);

  @override
  List<Object> get props => [items];
}

class MoviesEmptyLoadedState extends IMoviesState {}

class ErrorMoviesState extends IMoviesState {}
