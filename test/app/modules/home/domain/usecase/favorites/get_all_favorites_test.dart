import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_info/app/modules/home/domain/entities/movie.dart';
import 'package:movies_info/app/modules/home/domain/errors/errors.dart';
import 'package:movies_info/app/modules/home/domain/repositories/i_db_repository.dart';
import 'package:movies_info/app/modules/home/domain/usecase/favorites/get_all_favorites.dart';

class MockDbRepository extends Mock implements IDbRepository {}

void main() {
  final repository = MockDbRepository();
  final usecase = GetAllMovies(repository);

  test('Deve retornar uma lista de Movie', () async {
    when(repository.getAll()).thenAnswer(
      (_) async => await right(
        <Movie>[
          Movie(
            data: '02/02/2022',
            genero: ['Ação', 'Comédia'],
            link: 'google.com',
            poster: 'link',
            sinopse: 'era uma vez...',
            sinopseFull: 'era uma vez uma casa...',
            titulo: 'A volta dos que não foram',
            isFav: true,
          )
        ],
      ),
    );

    var result = await usecase();

    expect(result | null, isA<List<Movie>>());
  });

  test('deve retornar um EmptyListDb caso o retorno seja vazio', () async {
    when(repository.getAll()).thenAnswer((_) async => right(<Movie>[]));

    var result = await usecase();

    expect(result.fold(id, id), isA<EmptyListDb>());
  });
}
