import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_info/app/modules/home/domain/entities/favorite.dart';
import 'package:movies_info/app/modules/home/domain/errors/errors.dart';
import 'package:movies_info/app/modules/home/infra/datasource/i_db_datasource.dart';
import 'package:movies_info/app/modules/home/infra/models/favorite_model.dart';
import 'package:movies_info/app/modules/home/infra/repositories/favorites_db_repository.dart';

class MockDbDatasource extends Mock implements IDbDatasource {}

const hiveBox = 'testBox';

void main() {
  final datasource = MockDbDatasource();
  final repository = DbRepository(datasource);
  final favorite = Favorite(
    data: '02/02/2022',
    genero: ['Ação', 'Comédia'],
    link: 'google.com',
    poster: 'link',
    sinopse: 'era uma vez...',
    sinopseFull: 'era uma vez uma casa...',
    titulo: 'A volta dos que não foram',
    isFavorite: true,
  );

  group('Delete:', () {
    test('Deve disparar EmptyListDb caso a base esteja vazia', () async {
      when(datasource.deleteFavorite(any)).thenThrow(EmptyListDb());

      var result = await repository.delete(favorite);

      expect(result.fold(id, id), isA<EmptyListDb>());
    });

    test(
      'Deve deve retornar false caso o favorito não exista na base',
      () async {
        when(datasource.deleteFavorite(any)).thenAnswer((_) async => false);

        var result = await repository.delete(favorite);

        expect(result.fold(id, id), false);
      },
    );

    test(
      'Deve deve retornar true caso o favorito exista na base e foi removido',
      () async {
        when(datasource.deleteFavorite(any)).thenAnswer((_) async => true);

        var result = await repository.delete(favorite);

        expect(result.fold(id, id), true);
      },
    );
  });

  group('Insert:', () {
    test(
      'Deve disparar FailureDatabase caso aconteça algum erro na base',
      () async {
        when(datasource.insertFavorite(any)).thenThrow(Exception());

        var result = await repository.insert(favorite);

        expect(result.fold(id, id), isA<FailureDatabase>());
      },
    );

    test('Deve retornar false caso a inserção não ocorra', () async {
      when(datasource.insertFavorite(any)).thenAnswer((_) async => false);

      var result = await repository.insert(favorite);

      expect(result.fold(id, id), false);
    });

    test('Deve retornar true caso a inserção ocorra', () async {
      when(datasource.insertFavorite(any)).thenAnswer((_) async => true);

      var result = await repository.insert(favorite);

      expect(result.fold(id, id), true);
    });
  });

  group('Update:', () {
    test(
      'Deve disparar um UnimplementedError, já que não foi implementado',
      () {
        expect(
          () async => await repository.update(favorite),
          throwsA(isA<UnimplementedError>()),
        );
      },
    );
  });

  group('Find:', () {
    test(
      'Deve disparar um UnimplementedError, já que não foi implementado',
      () async {
        expect(
          () async => await repository.find('asdf'),
          throwsA(isA<UnimplementedError>()),
        );
      },
    );
  });

  group('GetAll:', () {
    test('Deve retornar um EmptyListDb caso a base esteja vazia', () async {
      when(datasource.getAllFavorites()).thenThrow(EmptyListDb());

      var result = await repository.getAll();

      expect(result.fold(id, id), isA<EmptyListDb>());
    });

    test(
      'Deve retornar um DatasourceDbResultNull caso a base retorne null',
      () async {
        when(datasource.getAllFavorites()).thenAnswer((_) async => null);

        var result = await repository.getAll();

        expect(result.fold(id, id), isA<DatasourceDbResultNull>());
      },
    );

    test(
      'Deve retornar um List<Favorite> caso a base contenha favoritos',
      () async {
        when(datasource.getAllFavorites()).thenAnswer(
          (_) async => await <FavoriteModel>[
            FavoriteModel(
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
        );

        var result = await repository.getAll();

        expect(result | null, isA<List<FavoriteModel>>());
      },
    );
  });
}
