import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../entities/favorite.dart';
import '../../errors/errors.dart';
import '../../repositories/i_db_repository.dart';

part 'update_favorite.g.dart';

@Injectable()
class UpdateFavorite {
  final IDbRepository repository;

  const UpdateFavorite(this.repository);

  Future<Either<FailureDatabase, bool>> call(Favorite favorite) async {
    var result = await repository.update(favorite);

    return result.fold((l) => left(l), (r) => right(r));
  }
}
