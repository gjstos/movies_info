import '../models/movie_model.dart';

abstract class IMoviesListDatasource {
  Future<List<MovieModel>> getMovies();
}
