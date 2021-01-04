import '../../domain/entities/movie.dart';
import '../models/movie_model.dart';

abstract class IDbDatasource {
  Future<List<MovieModel>> getAllMovies();
  Future<List<MovieModel>> findMovie(String textSearch);
  Future<bool> deleteMovie(Movie movie);
  Future<bool> insertMovie(Movie movie);
  Future<bool> updateMovie(Movie movie);
}
