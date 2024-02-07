import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/navigation_service/navigation_service.dart';
import 'package:test_app/enviroment.dart';
import 'package:test_app/injector.dart';
import 'package:test_app/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:test_app/presentation/bloc/movies/movies_bloc.dart';
import 'package:test_app/presentation/routes/app_routes.dart';
import 'package:test_app/presentation/routes/simple_deep_link_handler.dart';

void main() async {
  const String environment = String.fromEnvironment('ENVIRONMENT', defaultValue: Environment.DEV);
  Environment().initConfig(environment);

  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  SimpleDeepLinkHandler().initUniLinks();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => injector<MoviesBloc>()),
        BlocProvider(create: (context) => injector<MovieDetailBloc>()),
      ],
      child: MaterialApp(
        navigatorKey: injector<NavigationService>().navigatorKey,
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: AppRoutes.movies,
      ),
    );
  }
}
