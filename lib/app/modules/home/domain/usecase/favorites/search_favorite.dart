import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../entities/movie.dart';
import '../../errors/errors.dart';
import '../../repositories/i_db_repository.dart';

part 'search_favorite.g.dart';

@Injectable(singleton: false)
class SearchMovie {
  final IDbRepository repository;

  const SearchMovie(this.repository);

  Future<Either<FailureDatabase, List<Movie>>> call(String textSearch) async {
    var option = optionOf(textSearch);

    return option.fold(() => Left(InvalidSearchTextDb()), (text) async {
      var result = await repository.find(text);

      return result.fold(
        (l) => left(l),
        (r) => r.isEmpty ? left(EmptyListDb()) : right(r),
      );
    });
  }
}
