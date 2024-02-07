part of 'movies_bloc.dart';

abstract class IMoviesEvent extends Equatable {
  const IMoviesEvent();

  @override
  List<Object> get props => [];
}

class LoadMoviesEvent extends IMoviesEvent {
  final String search;

  const LoadMoviesEvent({required this.search});
  @override
  List<Object> get props => [search];
}
