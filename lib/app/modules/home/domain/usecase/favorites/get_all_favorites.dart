import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../entities/favorite.dart';
import '../../errors/errors.dart';
import '../../repositories/i_db_repository.dart';

part 'get_all_favorites.g.dart';

@Injectable()
class GetAllFavorites {
  final IDbRepository repository;

  const GetAllFavorites(this.repository);

  Future<Either<FailureDatabase, List<Favorite>>> call() async {
    var result = await repository.getAll();

    return result.fold(
      (l) => left(l),
      (r) => r.isEmpty ? left(EmptyListDb()) : right(r),
    );
  }
}
