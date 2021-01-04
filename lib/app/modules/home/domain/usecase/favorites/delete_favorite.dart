import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../entities/movie.dart';
import '../../errors/errors.dart';
import '../../repositories/i_db_repository.dart';

part 'delete_favorite.g.dart';

@Injectable()
class DeleteMovie {
  final IDbRepository repository;

  const DeleteMovie(this.repository);

  Future<Either<FailureDatabase, bool>> call(Movie movie) async {
    var result = await repository.delete(movie);

    return result.fold((l) => left(l), (r) => right(r));
  }
}
