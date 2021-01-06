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

  @observable
  Map<String, bool> sorted = {
    'sortByRelease': false,
    'sortByTitle': false,
    'reverseSortByRelease': false,
    'reverseSortByTitle': false,
  };

  @action
  Future<bool> deleteMovie(Movie movie) async {
    var result = await facade.deleteFavorite(movie);

    movie.isFav = false;

    facade.shouldUpdateLists.value = true;

    await getFavorites();

    return result;
  }

  @action
  Future<void> getFavorites() async {
    List<Movie> result;

    try {
      result = await facade.getFavorites();
    } on Exception {
      result = <Movie>[];
    }

    favorites = List<Movie>.from(result).asObservable();
  }

  @action
  void sortByRelease({bool isReverse = false}) {
    sorted['sortByRelease'] = isReverse;
    sorted['reverseSortByRelease'] = !isReverse;
  }

  @action
  void sortByTitle({bool isReverse = false}) {
    sorted['sortByTitle'] = isReverse;
    sorted['reverseSortByTitle'] = !isReverse;
  }

  List<Movie> favoritesSortByTitle({bool isReverse = false}) {
    if (isReverse) {
      favorites.sort(
        (second, first) => first.titulo.compareTo(second.titulo),
      );
    } else {
      favorites.sort(
        (first, second) => first.titulo.compareTo(second.titulo),
      );
    }

    return favorites;
  }

  List<Movie> favoritesSortByRelease({bool isReverse = false}) {
    if (isReverse) {
      favorites.sort(
        (second, first) => _toDate(first.data).compareTo(_toDate(second.data)),
      );
    } else {
      favorites.sort(
        (first, second) => _toDate(first.data).compareTo(_toDate(second.data)),
      );
    }

    return favorites;
  }

  String _toDate(String date) => date.split('/').reversed.join('-');
}
