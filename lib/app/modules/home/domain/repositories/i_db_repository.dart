import 'package:dartz/dartz.dart';

import '../../domain/errors/errors.dart';
import '../entities/movie.dart';

/// Perform interactions with the database.
abstract class IDbRepository {
  /// Insert something into the database.
  Future<Either<FailureDatabase, bool>> insert(Movie movie);

  /// Changes something of a database data.
  Future<Either<FailureDatabase, bool>> update(Movie movie);

  /// Removes something from the database.
  Future<Either<FailureDatabase, bool>> delete(Movie movie);

  /// Search the database for something.
  Future<Either<FailureDatabase, List<Movie>>> find(String info);

  /// Get all itens from database
  Future<Either<FailureDatabase, List<Movie>>> getAll();
}
