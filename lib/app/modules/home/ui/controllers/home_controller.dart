import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecase/get_movies.dart';
import '../../infra/models/movie_model.dart';
import '../states/movies_get_state.dart';

part 'home_controller.g.dart';

@Injectable(lazy: false)
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final GetMovies getMovies;

  _HomeControllerBase(this.getMovies) {
    updateState(LoadingState());
    Future.delayed(Duration(milliseconds: 1)).then((_) async {
      await runGetMovies();
    });
  }

  @observable
  ObservableList<Movie> movies = <Movie>[].asObservable();

  @observable
  List<bool> imagesWasDownloaded = <bool>[];

  @observable
  GetMoviesState state = StartState();

  @action
  Future<void> runGetMovies() async {
    var result = await getMovies();

    if (result.isRight()) {
      result.map((r) {
        imagesWasDownloaded = List.generate(r.length, (index) => false);
        movies = r.asObservable();
      });
    }
    updateState(SuccessState());
  }

  @action
  void updateState(GetMoviesState value) => state = value;

  @action
  void changeImageDownloadedStatus(int index) =>
      imagesWasDownloaded[index] = !imagesWasDownloaded[index];

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
}
