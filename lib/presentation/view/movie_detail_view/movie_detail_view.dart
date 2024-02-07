import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/params/get_movie_detail_params.dart';
import 'package:test_app/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:test_app/presentation/extensions/extensions.dart';
import 'package:test_app/presentation/resources/text_resources.dart';
import 'package:test_app/presentation/routes/screen_arguments/movie_detail_screen_args.dart';
import 'package:test_app/presentation/view/movie_detail_view/widgets/movie_detail_body.dart';
import 'package:test_app/presentation/view/widgets/default_view_widgwt.dart';
import 'package:test_app/presentation/view/widgets/loading_error_widget.dart';
import 'package:test_app/presentation/view/widgets/loading_widget.dart';

class MovieDetailView extends StatelessWidget {
  const MovieDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int id = context.getArguments<MovieDetailScreenArgs>().id;
    context.read<MovieDetailBloc>().add(LoadDetailMovie(params: GetMovieDetailParams(id: id)));
    return Scaffold(
        appBar: AppBar(title: const Text(AppTextResources.moviesTitle)),
        body: BlocBuilder<MovieDetailBloc, IMovieDetailState>(builder: (context, state) {
          if (state is LoadingDetailMovieState) {
            return const LoadingWidget();
          }
          if (state is ErrorDetailMovieState) {
            return const LoadingErrorWidget();
          }
          if (state is LoadMovieDetailState) {
            return MovieDetailBody(movieDetail: state.item);
          }
          return const DefaultViewWidget();
        }));
  }
}
