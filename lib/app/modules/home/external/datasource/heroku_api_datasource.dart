import 'package:dio/dio.dart';

import '../../domain/errors/errors.dart';
import '../../infra/datasource/i_movies_list_datasource.dart';
import '../../infra/models/movie_model.dart';

class HerokuApiDatasource implements IMoviesListDatasource {
  final Dio dio;

  const HerokuApiDatasource(this.dio);

  @override
  Future<List<MovieModel>> getMovies() async {
    var response =
        await dio.get('https://filmespy.herokuapp.com/api/v1/filmes');

    if (response.statusCode == 200) {
      var jList = response.data['filmes'] as List;
      var list = jList.map((item) => MovieModel.fromJson(item)).toList();

      return list;
    } else {
      throw GetFail();
    }
  }
}
