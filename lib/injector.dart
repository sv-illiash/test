import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:test_app/core/navigation_service/navigation_service.dart';
import 'package:test_app/data/datasources/local/database/database.dart';
import 'package:test_app/data/datasources/local/database/database_operations.dart';
import 'package:test_app/data/datasources/remote/app_api_service.dart';
import 'package:test_app/data/datasources/remote/http_client.dart';
import 'package:test_app/data/repositories/movies_repository_impl.dart';
import 'package:test_app/domain/repositories/movies_repository.dart';
import 'package:test_app/domain/usecases/cache_movies_usecase.dart';
import 'package:test_app/domain/usecases/get_cashed_movies_usecse.dart';
import 'package:test_app/domain/usecases/get_movie_by_id_usecase.dart';
import 'package:test_app/domain/usecases/get_movies_usecase.dart';
import 'package:test_app/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:test_app/presentation/bloc/movies/movies_bloc.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  /// Navigator
  injector.registerLazySingleton(() => NavigationService());

  /// Dio client
  injector.registerLazySingleton<Dio>(() => BaseHttpClient.createDioHttpClient());

  /// Sqflite
  injector.registerLazySingleton(() => DatabaseHelper());
  injector.registerLazySingleton(() => DBOperation(injector()));

  /// Dependencies
  injector.registerSingleton(AppApiService(injector()));

  /// Repositories
  injector.registerSingleton<IMoviesRepository>(MoviesRepositoryImpl(injector(), injector()));

  /// UseCases
  injector.registerSingleton(GetMoviesUseCase(injector()));
  injector.registerSingleton(GetMovieByIdUseCase(injector()));
  injector.registerSingleton(CacheMoviesUseCase(injector()));
  injector.registerSingleton(GetCashedMoviesUseCase(injector()));

  /// Blocs
  injector.registerLazySingleton(() => MoviesBloc(injector(), injector(), injector()));
  injector.registerLazySingleton(() => MovieDetailBloc(injector()));
}
