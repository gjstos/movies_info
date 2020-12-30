import 'package:dartz/dartz.dart';

import '../entities/movie.dart';
import '../errors/errors.dart';

abstract class IMoviesListRepository {
  Future<Either<Failure, List<Movie>>> getMovies();
}
