// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $HomeController = BindInject(
  (i) => HomeController(i<GetMovies>()),
  singleton: true,
  lazy: false,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$moviesAtom = Atom(name: '_HomeControllerBase.movies');

  @override
  ObservableList<Movie> get movies {
    _$moviesAtom.reportRead();
    return super.movies;
  }

  @override
  set movies(ObservableList<Movie> value) {
    _$moviesAtom.reportWrite(value, super.movies, () {
      super.movies = value;
    });
  }

  final _$imagesWasDownloadedAtom =
      Atom(name: '_HomeControllerBase.imagesWasDownloaded');

  @override
  List<bool> get imagesWasDownloaded {
    _$imagesWasDownloadedAtom.reportRead();
    return super.imagesWasDownloaded;
  }

  @override
  set imagesWasDownloaded(List<bool> value) {
    _$imagesWasDownloadedAtom.reportWrite(value, super.imagesWasDownloaded, () {
      super.imagesWasDownloaded = value;
    });
  }

  final _$stateAtom = Atom(name: '_HomeControllerBase.state');

  @override
  GetMoviesState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(GetMoviesState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$runGetMoviesAsyncAction =
      AsyncAction('_HomeControllerBase.runGetMovies');

  @override
  Future<void> runGetMovies() {
    return _$runGetMoviesAsyncAction.run(() => super.runGetMovies());
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  void updateState(GetMoviesState value) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.updateState');
    try {
      return super.updateState(value);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeImageDownloadedStatus(int index) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.changeImageDownloadedStatus');
    try {
      return super.changeImageDownloadedStatus(index);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void favoriteMovie(int index) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.favoriteMovie');
    try {
      return super.favoriteMovie(index);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
movies: ${movies},
imagesWasDownloaded: ${imagesWasDownloaded},
state: ${state}
    ''';
  }
}
