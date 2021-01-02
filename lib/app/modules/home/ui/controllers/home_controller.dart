import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecase/movies/get_movies.dart';
import '../../infra/models/movie_model.dart';
import '../states/movies_get_state.dart';

part 'home_controller.g.dart';

@Injectable(lazy: false)
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final GetMovies getMovies;

  _HomeControllerBase(this.getMovies) {
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
      updateState(LoadingState());
      var result = await getMovies();

      result.map((r) => movies = r.asObservable());

      if (movies.isEmpty) {
        updateState(StartState());
      } else {
        updateState(SuccessState());
      }
    } else {
      updateState(NoInternetConnectionState());
    }
  }

  @action
  void updateState(GetMoviesState value) => state = value;

  @action
  void favoriteMovie(int index) {
    var isFav = !movies[index].isFavorite;
    var movie = <String, dynamic>{
      'data': movies[index].data,
      'genero': movies[index].genero,
      'link': movies[index].link,
      'poster': movies[index].poster,
      'sinopse': movies[index].sinopse,
      'sinopseFull': movies[index].sinopseFull,
      'titulo': movies[index].titulo,
      'isFavorite': isFav ?? false,
    };
    movies[index] = MovieModel.fromJson(movie);
    movies = List<Movie>.from(movies).asObservable();
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
