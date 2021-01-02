import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';

import '../../domain/entities/favorite.dart';
import '../../domain/errors/errors.dart';
import '../../infra/datasource/i_db_datasource.dart';
import '../../infra/models/favorite_model.dart';

part 'hive_db_datasource.g.dart';

@Injectable()
class DbDatasource implements IDbDatasource {
  final Box<Favorite> box;

  const DbDatasource(this.box);

  @override
  Future<bool> deleteFavorite(Favorite favorite) async {
    if (favorite == null) {
      return false;
    }

    if (box.isEmpty) {
      throw EmptyListDb();
    }

    if (!box.containsKey(favorite.key)) {
      throw InexistentItemDb();
    }

    box.delete(favorite.key);

    if (box.containsKey(favorite.key)) {
      return false;
    }

    return true;
  }

  @override
  Future<List<FavoriteModel>> findFavorite(String textSearch) {
    // Não irá ser utilizado na aplicação
    throw UnimplementedError();
  }

  @override
  Future<List<FavoriteModel>> getAllFavorites() async {
    if (box.isEmpty) {
      throw EmptyListDb();
    }

    var list = await box.values
        .map((favorite) => FavoriteModel.fromJson(favorite as Map))
        .toList();

    return list;
  }

  @override
  Future<bool> insertFavorite(Favorite favorite) async {
    if (favorite == null) {
      return false;
    }

    box.add(favorite);

    if (await box.containsKey(favorite.key)) {
      return true;
    }

    return false;
  }

  @override
  Future<bool> updateFavorite(Favorite favorite) {
    // Não irá ser utilizado na aplicação
    throw UnimplementedError();
  }
}
