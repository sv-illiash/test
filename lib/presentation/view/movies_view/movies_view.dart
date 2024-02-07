import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/navigation_service/navigation_service.dart';
import 'package:test_app/injector.dart';
import 'package:test_app/presentation/bloc/movies/movies_bloc.dart';
import 'package:test_app/presentation/resources/text_resources.dart';
import 'package:test_app/presentation/routes/app_routes.dart';
import 'package:test_app/presentation/routes/screen_arguments/movie_detail_screen_args.dart';
import 'package:test_app/presentation/theme/colors.dart';
import 'package:test_app/presentation/ui_constants/ui_constants.dart';
import 'package:test_app/presentation/view/movies_view/widgets/movies_item_widget.dart';
import 'package:test_app/presentation/view/widgets/default_view_widgwt.dart';
import 'package:test_app/presentation/view/widgets/empty_state_widget.dart';
import 'package:test_app/presentation/view/widgets/loading_error_widget.dart';
import 'package:test_app/presentation/view/widgets/loading_widget.dart';
import 'package:test_app/presentation/view/widgets/text_field_widget.dart';

class MoviesView extends StatefulWidget {
  const MoviesView({Key? key}) : super(key: key);

  @override
  State<MoviesView> createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTextResources.moviesTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(space16),
        child: Column(
          children: [
            TextFiledWidget(onSearch: (search) => _loadMovies(search: search)),
            const SizedBox(height: space10),
            BlocBuilder<MoviesBloc, IMoviesState>(builder: (context, state) {
              if (state is ErrorMoviesState) {
                return const LoadingErrorWidget();
              }
              if (state is MoviesEmptyLoadedState) {
                return const EmptyStateWidget();
              }
              if (state is MoviesLoading) {
                return const Expanded(child: LoadingWidget());
              }
              if (state is MoviesLoadedState) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: space8),
                      child: Container(
                        decoration: BoxDecoration(
                            color: grey,
                            borderRadius: BorderRadius.circular(radius10)),
                        child: MoviesItemWidget(
                            index: index,
                            movieItem: state.items[index],
                            onTap: (id) => injector<NavigationService>().pushNamed(
                                AppRoutes.movieDetail,
                                arguments: MovieDetailScreenArgs(id: id))),
                      ),
                    ),
                  ),
                );
              }
              return const DefaultViewWidget();
            })
          ],
        ),
      ),
    );
  }

  void _loadMovies({required String search}) =>
      context.read<MoviesBloc>().add(LoadMoviesEvent(search: search));
}
