import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../entities/favorite.dart';
import '../../errors/errors.dart';
import '../../repositories/i_db_repository.dart';

part 'delete_favorite.g.dart';

@Injectable()
class DeleteFavorite {
  final IDbRepository repository;

  const DeleteFavorite(this.repository);

  Future<Either<FailureDatabase, bool>> call(Favorite favorite) async {
    var result = await repository.delete(favorite);

    return result.fold((l) => left(l), (r) => right(r));
  }
}
