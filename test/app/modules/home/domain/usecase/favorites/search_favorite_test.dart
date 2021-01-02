import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_info/app/modules/home/domain/entities/favorite.dart';
import 'package:movies_info/app/modules/home/domain/errors/errors.dart';
import 'package:movies_info/app/modules/home/domain/repositories/i_db_repository.dart';
import 'package:movies_info/app/modules/home/domain/usecase/favorites/search_favorite.dart';

class MockDbRepository extends Mock implements IDbRepository {}

void main() {
  final repository = MockDbRepository();
  final usecase = SearchFavorite(repository);

  test('Deve retornar InvalidSearchTextDb caso o text seja inválido', () async {
    var result = await usecase(null);

    expect(result.fold(id, id), isA<InvalidSearchTextDb>());
  });

  test('Deve retornar EmptyListDb caso a base esteja vazia', () async {
    when(repository.find(any)).thenAnswer((_) async => right(<Favorite>[]));

    var result = await usecase("asdf");
    expect(result.fold(id, id), isA<EmptyListDb>());
  });

  test('Deve retornar um List<Favorite> caso encontre ocorrências', () async {
    when(repository.find(any)).thenAnswer(
      (_) async => right(<Favorite>[
        Favorite(
          data: '02/02/2022',
          genero: ['Ação', 'Comédia'],
          link: 'google.com',
          poster: 'link',
          sinopse: 'era uma vez...',
          sinopseFull: 'era uma vez uma casa...',
          titulo: 'A volta dos que não foram',
          isFavorite: true,
        ),
      ]),
    );

    var result = await usecase("asdf");
    expect(result.fold(id, id), isA<List<Favorite>>());
  });
}
