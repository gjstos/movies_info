import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';

import '../../domain/entities/movie.dart';
import '../../domain/errors/errors.dart';
import '../../domain/usecase/favorites/delete_favorite.dart';
import '../../domain/usecase/favorites/get_all_favorites.dart';
import '../../domain/usecase/favorites/insert_favorite.dart';
import '../../domain/usecase/favorites/search_favorite.dart';

part 'db_favorites_facade.g.dart';

const _favoritesDbBox = 'favoritesDB';

@Injectable()
class DbMoviesFacade extends ChangeNotifier {
  final GetAllMovies _usecaseGetAllFav = Modular.get<GetAllMovies>();
  final DeleteMovie _usecaseDeleteFav = Modular.get<DeleteMovie>();
  final InsertMovie _usecaseInsertFav = Modular.get<InsertMovie>();
  final SearchMovie _usecaseSearchFav = Modular.get<SearchMovie>();
  Box<Movie> _favoritesBox;

  ValueNotifier<bool> shouldUpdateLists = ValueNotifier(false);

  DbMoviesFacade() {
    _favoritesBox = Hive.box(_favoritesDbBox);

    if (!_favoritesBox.isOpen) {
      Future.value(Hive.openBox<Movie>(_favoritesDbBox))
          .then((box) => _favoritesBox = box);
    }
  }

  Future<List<Movie>> getFavorites() async {
    var result = await _usecaseGetAllFav();

    return result.fold((l) => [], (r) => r);
  }

  Future<bool> deleteFavorite(Movie movie) async {
    var result = await _usecaseDeleteFav(movie);

    movie.isFav = false;

    await notifyListListeners(notify: true);

    return result.fold((l) => false, (r) {
      getFavorites();
      return r;
    });
  }

  Future<Either<FailureDatabase, bool>> insertFavorite(Movie movie) async {
    var result = await _usecaseInsertFav(movie);

    return result.fold((l) => left(l), (r) {
      getFavorites();
      return right(r);
    });
  }

  bool isBaseFull() {
    return _favoritesBox.length == 3;
  }

  Future<bool> alreadyFavorite(String textSearch) async {
    var result = await _usecaseSearchFav(textSearch);

    return result.fold((l) => false, (r) => r.isNotEmpty);
  }

  void notifyListListeners({@required bool notify}) {
    shouldUpdateLists.value = notify;

    if (notify) {
      notifyListeners();
      // shouldUpdateLists = ValueNotifier(!notify);
    }
  }
}
