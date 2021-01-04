import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';

import '../../domain/entities/movie.dart';
import '../../domain/errors/errors.dart';
import '../../infra/datasource/i_db_datasource.dart';
import '../../infra/models/movie_model.dart';

part 'hive_db_datasource.g.dart';

@Injectable()
class DbDatasource implements IDbDatasource {
  final Box<Movie> box;

  const DbDatasource(this.box);

  @override
  Future<bool> deleteMovie(Movie movie) async {
    if (movie == null) {
      return false;
    }

    if (box.isEmpty) {
      throw EmptyListDb();
    }

    var keyMovie = box.values
        .firstWhere((element) => element.titulo.contains(movie.titulo))
        .key;

    if (!box.containsKey(keyMovie)) {
      throw InexistentItemDb();
    }

    box.delete(keyMovie);

    return true;
  }

  @override
  Future<List<MovieModel>> findMovie(String textSearch) async {
    var list = <MovieModel>[];

    if (textSearch == null) {
      throw InvalidSearchTextDb();
    }

    if (box.isNotEmpty) {
      box.values.forEach((e) {
        if (e.titulo.contains(textSearch) ||
            e.sinopseFull.contains(textSearch)) {
          list.add(MovieModel.fromJson(e.toMap()));
        }
      });
    }

    return list;
  }

  @override
  Future<List<MovieModel>> getAllMovies() async {
    if (box.isEmpty) {
      throw EmptyListDb();
    }

    var list = await box.values
        .map((movie) => MovieModel.fromJson(movie.toMap()))
        .toList();

    return list;
  }

  @override
  Future<bool> insertMovie(Movie movie) async {
    if (movie == null) {
      return false;
    }

    if (box.length < 3) {
      box.add(movie);

      if (await box.containsKey(movie.key)) {
        return true;
      }
    } else {
      throw FullDatabase();
    }

    return false;
  }

  @override
  Future<bool> updateMovie(Movie movie) {
    // Não irá ser utilizado na aplicação
    throw UnimplementedError();
  }
}
