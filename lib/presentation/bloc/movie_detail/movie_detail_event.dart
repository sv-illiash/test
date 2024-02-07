part of 'movie_detail_bloc.dart';

abstract class IMovieDetailEvent extends Equatable {
  const IMovieDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadDetailMovie extends IMovieDetailEvent {
  final GetMovieDetailParams params;

  const LoadDetailMovie({required this.params});

  @override
  List<Object?> get props => [params];
}

