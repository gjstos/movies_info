// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_store.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $FavoritesStore = BindInject(
  (i) => FavoritesStore(i<DbMoviesFacade>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FavoritesStore on _FavoritesStoreBase, Store {
  final _$favoritesAtom = Atom(name: '_FavoritesStoreBase.favorites');

  @override
  List<Movie> get favorites {
    _$favoritesAtom.reportRead();
    return super.favorites;
  }

  @override
  set favorites(List<Movie> value) {
    _$favoritesAtom.reportWrite(value, super.favorites, () {
      super.favorites = value;
    });
  }

  final _$sortedAtom = Atom(name: '_FavoritesStoreBase.sorted');

  @override
  Map<String, bool> get sorted {
    _$sortedAtom.reportRead();
    return super.sorted;
  }

  @override
  set sorted(Map<String, bool> value) {
    _$sortedAtom.reportWrite(value, super.sorted, () {
      super.sorted = value;
    });
  }

  final _$deleteMovieAsyncAction =
      AsyncAction('_FavoritesStoreBase.deleteMovie');

  @override
  Future<bool> deleteMovie(Movie movie) {
    return _$deleteMovieAsyncAction.run(() => super.deleteMovie(movie));
  }

  final _$getFavoritesAsyncAction =
      AsyncAction('_FavoritesStoreBase.getFavorites');

  @override
  Future<void> getFavorites() {
    return _$getFavoritesAsyncAction.run(() => super.getFavorites());
  }

  final _$_FavoritesStoreBaseActionController =
      ActionController(name: '_FavoritesStoreBase');

  @override
  void sortByRelease({bool isReverse = false}) {
    final _$actionInfo = _$_FavoritesStoreBaseActionController.startAction(
        name: '_FavoritesStoreBase.sortByRelease');
    try {
      return super.sortByRelease(isReverse: isReverse);
    } finally {
      _$_FavoritesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void sortByTitle({bool isReverse = false}) {
    final _$actionInfo = _$_FavoritesStoreBaseActionController.startAction(
        name: '_FavoritesStoreBase.sortByTitle');
    try {
      return super.sortByTitle(isReverse: isReverse);
    } finally {
      _$_FavoritesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favorites: ${favorites},
sorted: ${sorted}
    ''';
  }
}
