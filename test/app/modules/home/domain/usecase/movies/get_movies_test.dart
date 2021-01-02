import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_info/app/modules/home/domain/entities/movie.dart';
import 'package:movies_info/app/modules/home/domain/errors/errors.dart';
import 'package:movies_info/app/modules/home/domain/repositories/i_movies_list_repository.dart';
import 'package:movies_info/app/modules/home/domain/usecase/movies/get_movies.dart';

class MockMoviesListRepository extends Mock implements IMoviesListRepository {}

void main() {
  final repository = MockMoviesListRepository();
  final usecase = GetMovies(repository);

  test('Deve retornar uma lista de Movie', () async {
    when(repository.getMovies()).thenAnswer(
      (_) async => await right(
        <Movie>[
          Movie(
              data: null,
              genero: null,
              link: null,
              poster: null,
              sinopse: null,
              sinopseFull: null,
              titulo: null)
        ],
      ),
    );

    var result = await usecase();
    expect(result | null, isA<List<Movie>>());
  });

  test('deve retornar um EmptyList caso o retorno seja vazio', () async {
    when(repository.getMovies()).thenAnswer((_) async => right(<Movie>[]));

    var result = await usecase();
    expect(result.fold(id, id), isA<EmptyList>());
  });
}
