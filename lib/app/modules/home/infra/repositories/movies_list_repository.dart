import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/entities/movie.dart';
import '../../domain/errors/errors.dart';
import '../../domain/repositories/i_movies_list_repository.dart';
import '../datasource/i_movies_list_datasource.dart';
import '../models/movie_model.dart';

part 'movies_list_repository.g.dart';

@Injectable()
class MoviesListRepository implements IMoviesListRepository {
  final IMoviesListDatasource datasource;

  const MoviesListRepository(this.datasource);

  @override
  Future<Either<Failure, List<Movie>>> getMovies() async {
    List<MovieModel> result;

    try {
      result = await datasource.getMovies();
    } on Exception {
      return left(GetFail());
    }

    return result == null ? left(DatasourceResultNull()) : right(result);
  }
}
