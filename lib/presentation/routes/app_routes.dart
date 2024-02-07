import 'package:flutter/material.dart';
import 'package:test_app/presentation/view/movie_detail_view/movie_detail_view.dart';

import 'package:test_app/presentation/view/movies_view/movies_view.dart';

class AppRoutes {
  static const movies = 'movies';
  static const movieDetail = 'movieDetail';

  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case movies:
        return _materialRoute(const MoviesView(), routeSettings: routeSettings);
      case movieDetail:
        return _materialRoute(const MovieDetailView(), routeSettings: routeSettings);
      default:
        return null;
    }
  }

  static Route<dynamic> _materialRoute(Widget view, {RouteSettings? routeSettings}) {
    return MaterialPageRoute(
        builder: (_) => Builder(builder: (BuildContext context) => view), settings: routeSettings);
  }
}
