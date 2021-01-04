import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/movie.dart';
import '../controllers/db_favorites_facade.dart';

part 'favorites_store.g.dart';

@Injectable()
class FavoritesStore = _FavoritesStoreBase with _$FavoritesStore;

abstract class _FavoritesStoreBase with Store {
  final DbMoviesFacade facade;

  _FavoritesStoreBase(this.facade) {
    Future.value(facade.getFavorites())
        .then((list) => favorites = list.asObservable());
  }

  @observable
  List<Movie> favorites = <Movie>[].asObservable();

  @action
  Future<bool> deleteMovie(Movie movie) async {
    var result = await facade.deleteFavorite(movie);

    movie.isFav = false;

    await getFavorites();

    return result;
  }

  @observable
  Future<void> getFavorites() async {
    List<Movie> result;

    try {
      result = await facade.getFavorites();
    } on Exception {
      result = <Movie>[];
    }

    favorites = List<Movie>.from(result).asObservable();
  }
}
