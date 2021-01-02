import 'package:dartz/dartz.dart';

import '../../domain/errors/errors.dart';
import '../entities/favorite.dart';

/// Perform interactions with the database.
abstract class IDbRepository {
  /// Insert something into the database.
  Future<Either<FailureDatabase, bool>> insert(Favorite favorite);

  /// Changes something of a database data.
  Future<Either<FailureDatabase, bool>> update(Favorite favorite);

  /// Removes something from the database.
  Future<Either<FailureDatabase, bool>> delete(Favorite favorite);

  /// Search the database for something.
  Future<Either<FailureDatabase, List<Favorite>>> find(String info);

  /// Get all itens from database
  Future<Either<FailureDatabase, List<Favorite>>> getAll();
}
