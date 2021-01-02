import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../infra/datasource/i_movies_list_datasource.dart';
import '../../infra/models/movie_model.dart';

part 'heroku_api_datasource.g.dart';

@Injectable()
class HerokuApiDatasource implements IMoviesListDatasource {
  final Dio dio;

  const HerokuApiDatasource(this.dio);

  @override
  Future<List<MovieModel>> getMovies() async {
    var list = <MovieModel>[];
    var response =
        await dio.get('https://filmespy.herokuapp.com/api/v1/filmes');

    if (response.statusCode == 200) {
      var jList = response.data['filmes'] as List;
      list = jList.map((item) => MovieModel.fromJson(item)).toList();
    }

    return list;
  }
}
