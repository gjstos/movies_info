import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/entities/movie.dart';
import '../../domain/errors/errors.dart';
import '../../domain/repositories/i_db_repository.dart';
import '../datasource/i_db_datasource.dart';
import '../models/movie_model.dart';

part 'favorites_db_repository.g.dart';

@Injectable()
class DbRepository implements IDbRepository {
  final IDbDatasource datasource;

  const DbRepository(this.datasource);

  @override
  Future<Either<FailureDatabase, bool>> delete(Movie movie) async {
    bool result;

    try {
      result = await datasource.deleteMovie(movie);
    } on EmptyListDb {
      return left(EmptyListDb());
    } on InexistentItemDb {
      return left(InexistentItemDb());
    }

    return right(result);
  }

  @override
  Future<Either<FailureDatabase, bool>> insert(Movie movie) async {
    var result = false;

    try {
      result = await datasource.insertMovie(movie);
    } on Exception {
      return left(FailureDatabase());
    }

    return right(result);
  }

  @override
  Future<Either<FailureDatabase, bool>> update(Movie movie) {
    // Não será utilizado no app
    throw UnimplementedError();
  }

  @override
  Future<Either<FailureDatabase, List<Movie>>> find(String info) async {
    List<MovieModel> result;

    try {
      result = await datasource.findMovie(info);
    } on InvalidSearchTextDb {
      return left(InvalidSearchTextDb());
    }

    return result == null ? left(DatasourceDbResultNull()) : right(result);
  }

  @override
  Future<Either<FailureDatabase, List<Movie>>> getAll() async {
    List<MovieModel> result;

    try {
      result = await datasource.getAllMovies();
    } on EmptyListDb {
      return left(EmptyListDb());
    }

    return result == null ? left(DatasourceDbResultNull()) : right(result);
  }
}
