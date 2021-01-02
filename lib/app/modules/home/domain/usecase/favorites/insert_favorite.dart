import 'package:dartz/dartz.dart';

import '../../entities/favorite.dart';
import '../../errors/errors.dart';
import '../../repositories/i_db_repository.dart';

class InsertFavorite {
  final IDbRepository repository;

  const InsertFavorite(this.repository);

  Future<Either<FailureDatabase, bool>> call(Favorite favorite) async {
    var result = await repository.insert(favorite);

    return result.fold((l) => left(l), (r) => right(r));
  }
}
