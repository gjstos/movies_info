import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/usecase/get_movies.dart';
import 'external/heroku/heroku_api_datasource.dart';
import 'infra/repositories/movies_list_repository.dart';
import 'ui/controllers/home_controller.dart';
import 'ui/pages/home/home_page.dart';
import 'ui/pages/movie/movie_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        $GetMovies,
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
