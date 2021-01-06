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

  @override
  String toString() {
    return '''
favorites: ${favorites}
    ''';
  }
}
