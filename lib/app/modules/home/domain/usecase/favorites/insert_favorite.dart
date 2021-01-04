import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../entities/movie.dart';
import '../../errors/errors.dart';
import '../../repositories/i_db_repository.dart';

part 'insert_favorite.g.dart';

@Injectable()
class InsertMovie {
  final IDbRepository repository;

  const InsertMovie(this.repository);

  Future<Either<FailureDatabase, bool>> call(Movie movie) async {
    var result = await repository.insert(movie);

    return result.fold((l) => left(l), (r) => right(r));
  }
}
