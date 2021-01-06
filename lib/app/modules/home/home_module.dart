import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';

import 'domain/entities/movie.dart';
import 'domain/usecase/favorites/delete_favorite.dart';
import 'domain/usecase/favorites/get_all_favorites.dart';
import 'domain/usecase/favorites/insert_favorite.dart';
import 'domain/usecase/favorites/search_favorite.dart';
import 'domain/usecase/movies/get_movies.dart';
import 'external/heroku/heroku_api_datasource.dart';
import 'external/hive/hive_db_datasource.dart';
import 'infra/repositories/favorites_db_repository.dart';
import 'infra/repositories/movies_list_repository.dart';
import 'ui/controllers/db_favorites_facade.dart';
import 'ui/controllers/favorites_store.dart';
import 'ui/controllers/home_controller.dart';
import 'ui/controllers/movie_controller.dart';
import 'ui/pages/home/home_page.dart';
import 'ui/pages/movie/movie_page.dart';

const _favoritesDbBox = 'favoritesDB';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind<Box<Movie>>((i) => Hive.box(_favoritesDbBox)),
        $GetMovies,
        $GetAllMovies,
        $DeleteMovie,
        $InsertMovie,
        $HerokuApiDatasource,
        $HomeController,
        $MovieController,
        $MoviesListRepository,
        $DbRepository,
        $DbDatasource,
        $DbMoviesFacade,
        $SearchMovie,
        $FavoritesStore,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
        ModularRouter(
          '/movie',
          child: (_, args) => MoviePage(movie: args.data),
        ),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
