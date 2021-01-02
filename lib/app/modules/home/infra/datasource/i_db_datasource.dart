import '../../domain/entities/favorite.dart';
import '../models/favorite_model.dart';

abstract class IDbDatasource {
  Future<List<FavoriteModel>> getAllFavorites();
  Future<List<FavoriteModel>> findFavorite(String textSearch);
  Future<bool> deleteFavorite(Favorite favorite);
  Future<bool> insertFavorite(Favorite favorite);
  Future<bool> updateFavorite(Favorite favorite);
}
