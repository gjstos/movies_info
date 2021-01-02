import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/entities/favorite.dart';
import '../../domain/errors/errors.dart';
import '../../domain/repositories/i_db_repository.dart';
import '../datasource/i_db_datasource.dart';
import '../models/favorite_model.dart';

part 'favorites_db_repository.g.dart';

@Injectable()
class DbRepository implements IDbRepository {
  final IDbDatasource datasource;

  const DbRepository(this.datasource);

  @override
  Future<Either<FailureDatabase, bool>> delete(Favorite favorite) async {
    bool result;

    try {
      result = await datasource.deleteFavorite(favorite);
    } on EmptyListDb {
      return left(EmptyListDb());
    }

    return right(result);
  }

  @override
  Future<Either<FailureDatabase, bool>> insert(Favorite favorite) async {
    var result = false;

    try {
      result = await datasource.insertFavorite(favorite);
    } on Exception {
      return left(FailureDatabase());
    }

    return right(result);
  }

  @override
  Future<Either<FailureDatabase, bool>> update(Favorite favorite) {
    // Não será utilizado no app
    throw UnimplementedError();
  }

  @override
  Future<Either<FailureDatabase, List<Favorite>>> find(String info) {
    // Não será utilizado no app
    throw UnimplementedError();
  }

  @override
  Future<Either<FailureDatabase, List<Favorite>>> getAll() async {
    List<FavoriteModel> result;

    try {
      result = await datasource.getAllFavorites();
    } on EmptyListDb {
      return left(EmptyListDb());
    }

    return result == null ? left(DatasourceDbResultNull()) : right(result);
  }
}
