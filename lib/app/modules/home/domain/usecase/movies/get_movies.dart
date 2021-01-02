import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../entities/movie.dart';
import '../../errors/errors.dart';
import '../../repositories/i_movies_list_repository.dart';

part 'get_movies.g.dart';

@Injectable()
class GetMovies {
  final IMoviesListRepository repository;

  const GetMovies(this.repository);

  Future<Either<Failure, List<Movie>>> call() async {
    var result = await repository.getMovies();

    return result.fold(
      (l) => left(l),
      (r) => r.isEmpty ? left(EmptyList()) : right(r),
    );
  }
}
