import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:test_app/data/models/remout/response/detail_movie_response.dart';
import 'package:test_app/data/models/remout/response/movie_response.dart';


part 'app_api_service.g.dart';

@RestApi()
abstract class AppApiService {
  factory AppApiService(Dio dio) = _AppApiService;

  @GET('/search/movie')
  Future<HttpResponse<MoviesResponse>> searchMovies(@Query("query") String searchText,);

  @GET('/movie/{id}')
  Future<HttpResponse<DetailMovieResponse>> getMovieById(
      @Path("id") int id);

}
