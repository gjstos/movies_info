import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecase/movies/get_movies.dart';
import '../states/movies_get_state.dart';
import 'db_favorites_facade.dart';

part 'home_controller.g.dart';

@Injectable(lazy: false)
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final GetMovies getMovies;
  final DbMoviesFacade facade;

  _HomeControllerBase(this.getMovies, this.facade) {
    updateState(LoadingState());
    Future.delayed(const Duration(milliseconds: 0)).then((_) async {
      await runGetMovies();
    });
  }

  @observable
  ObservableList<Movie> movies = <Movie>[].asObservable();

  @observable
  GetMoviesState state = StartState();

  @action
  Future<void> runGetMovies() async {
    var hasNet = await _checkInternetConnection();
    if (hasNet) {
      var result = await getMovies();

      result.map((r) => movies = r.asObservable());

      if (movies.isEmpty) {
        updateState(StartState());
      } else {
        for (var movie in movies) {
          var result = await facade.alreadyFavorite(movie.titulo);

          if (result) {
            movie.isFav = true;
          }
        }

        movies = List<Movie>.from(movies).asObservable();
        updateState(SuccessState());
      }
    } else {
      updateState(NoInternetConnectionState());
    }
  }

  @action
  void updateState(GetMoviesState value) => state = value;

  @action
  Future<void> updateMovies() async {
    for (var movie in movies) {
      var isFav = await facade.alreadyFavorite(movie.titulo);

      movie.isFav = isFav;
    }

    movies = List<Movie>.from(movies).asObservable();
  }

  @action
  Future<bool> favoriteMovie(int index) async {
    var result;
    var willFav = !movies[index].isFav;
    movies[index].isFav = willFav;

    if (willFav) {
      if (!facade.isBaseFull()) {
        var isDone = await facade.insertFavorite(movies[index]);

        isDone.fold((l) => null, (r) => result = r);
      } else {
        willFav = !movies[index].isFav;
        movies[index].isFav = willFav;
        return null;
      }
    } else {
      result = await facade.deleteFavorite(movies[index]);
    }

    if (!result) {
      willFav = !movies[index].isFav;
      movies[index].isFav = willFav;
    }

    movies = List<Movie>.from(movies).asObservable();
    return result;
  }

  Future<bool> _checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }

    return false;
  }
}
