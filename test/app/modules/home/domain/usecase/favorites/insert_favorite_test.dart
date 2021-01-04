import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_info/app/modules/home/domain/entities/movie.dart';
import 'package:movies_info/app/modules/home/domain/repositories/i_db_repository.dart';
import 'package:movies_info/app/modules/home/domain/usecase/favorites/insert_favorite.dart';

class MockDbRepository extends Mock implements IDbRepository {}

void main() {
  final repository = MockDbRepository();
  final usecase = InsertMovie(repository);

  test('Deve retornar true quando inserido', () async {
    when(repository.insert(any)).thenAnswer((_) async => right(true));
    var result = await usecase(
      Movie(
        data: '02/02/2022',
        genero: ['Ação', 'Comédia'],
        link: 'google.com',
        poster: 'link',
        sinopse: 'era uma vez...',
        sinopseFull: 'era uma vez uma casa...',
        titulo: 'A volta dos que não foram',
        isFav: true,
      ),
    );

    expect(result | null, true);
  });

  test('Deve retornar false quando não inserido', () async {
    when(repository.insert(any)).thenAnswer((_) async => right(false));
    var result = await usecase(
      Movie(
        data: '02/02/2022',
        genero: ['Ação', 'Comédia'],
        link: 'google.com',
        poster: 'link',
        sinopse: 'era uma vez...',
        sinopseFull: 'era uma vez uma casa...',
        titulo: 'A volta dos que não foram',
        isFav: true,
      ),
    );

    expect(result | null, false);
  });
}
