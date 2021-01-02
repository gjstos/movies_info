import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_info/app/modules/home/domain/entities/favorite.dart';
import 'package:movies_info/app/modules/home/domain/errors/errors.dart';
import 'package:movies_info/app/modules/home/domain/repositories/i_db_repository.dart';
import 'package:movies_info/app/modules/home/domain/usecase/favorites/get_all_favorites.dart';

class MockDbRepository extends Mock implements IDbRepository {}

void main() {
  final repository = MockDbRepository();
  final usecase = GetAllFavorites(repository);

  test('Deve retornar uma lista de Favorite', () async {
    when(repository.getAll()).thenAnswer(
      (_) async => await right(
        <Favorite>[
          Favorite(
            data: '02/02/2022',
            genero: ['Ação', 'Comédia'],
            link: 'google.com',
            poster: 'link',
            sinopse: 'era uma vez...',
            sinopseFull: 'era uma vez uma casa...',
            titulo: 'A volta dos que não foram',
            isFavorite: true,
          )
        ],
      ),
    );

    var result = await usecase();

    expect(result | null, isA<List<Favorite>>());
  });

  test('deve retornar um EmptyListDb caso o retorno seja vazio', () async {
    when(repository.getAll()).thenAnswer((_) async => right(<Favorite>[]));

    var result = await usecase();

    expect(result.fold(id, id), isA<EmptyListDb>());
  });
}
