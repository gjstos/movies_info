import 'package:dio/dio.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';

import 'domain/entities/favorite.dart';
import 'domain/usecase/favorites/delete_favorite.dart';
import 'domain/usecase/favorites/get_all_favorites.dart';
import 'domain/usecase/movies/get_movies.dart';
import 'external/heroku/heroku_api_datasource.dart';
import 'infra/repositories/movies_list_repository.dart';
import 'ui/controllers/home_controller.dart';
import 'ui/pages/home/home_page.dart';
import 'ui/pages/movie/movie_page.dart';

const _favoritesDbBox = 'favoritesDB';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => Hive.openBox<Favorite>(_favoritesDbBox)),
        $GetMovies,
        $GetAllFavorites,
        $DeleteFavorite,
        $HerokuApiDatasource,
        $HomeController,
        $MoviesListRepository,
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
