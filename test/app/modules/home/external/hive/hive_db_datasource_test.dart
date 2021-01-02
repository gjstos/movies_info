import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:movies_info/app/modules/home/domain/entities/favorite.dart';
import 'package:movies_info/app/modules/home/domain/errors/errors.dart';
import 'package:movies_info/app/modules/home/external/hive/hive_db_datasource.dart';

void main() async {
  await initHive();

  final box = await Hive.openBox<Favorite>('testBox');
  final datasource = DbDatasource(box);
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

  group('Insert:', () {
    test('Deve retornar true ao salvar na base de dados', () async {
      var result = await datasource.insertFavorite(favorite);

      expect(result, true);
    });

    test('Deve retornar false ao não existe na base de dados', () async {
      var fav = Favorite(
        data: '02/02/2022',
        genero: ['Ação', 'Comédia'],
        link: 'qwerty.com',
        poster: 'link',
        sinopse: 'era uma vez...',
        sinopseFull: 'era uma vez uma casa...',
        titulo: 'A volta dos que não foram 2',
        isFavorite: false,
      );

      expect(
        () async => datasource.deleteFavorite(fav),
        throwsA(isA<InexistentItemDb>()),
      );
    });
  });

  group('Update:', () {
    test(
      'Deve disparar um UnimplementedError, já que não foi implementado',
      () async {
        expect(
          () async => datasource.updateFavorite(favorite),
          throwsA(isA<UnimplementedError>()),
        );
      },
    );
  });

  group('Delete:', () {
    test('Deve retornar true ao remover da base de dados', () async {
      box.clear();

      var result = await datasource.deleteFavorite(favorite);

      expect(result, true);
    });

    test('Deve disparar EmptyListDb quando a base está vazia', () async {
      box.clear();

      expect(
        () async => datasource.deleteFavorite(favorite),
        throwsA(isA<EmptyListDb>()),
      );
    });

    test(
      'Deve retornar false ao tentar remover um favorito inválido',
      () async {
        var result = await datasource.deleteFavorite(null);

        expect(result, false);
      },
    );

    test(
      'Deve retornar false ao tentar remover um favorito inexistente',
      () async {
        box.add(favorite);

        expect(
          () async => datasource.deleteFavorite(
            Favorite(
              data: '02/02/2022',
              genero: ['Ação', 'Comédia'],
              link: 'qwerty.com',
              poster: 'link',
              sinopse: 'era uma vez...',
              sinopseFull: 'era uma vez uma casa...',
              titulo: 'A volta dos que não foram 2',
              isFavorite: true,
            ),
          ),
          throwsA(isA<InexistentItemDb>()),
        );
      },
    );
  });
  group('Find:', () {
    test(
      'Deve disparar um UnimplementedError, já que não foi implementado',
      () async {
        expect(
          () async => datasource.findFavorite(favorite.titulo),
          throwsA(isA<UnimplementedError>()),
        );
      },
    );
  });
}

void initHive() async {
  var path = Directory.current.path;
  await Hive.init('$path/test/app/modules/home/external/hive');
  Hive.registerAdapter<Favorite>(FavoriteAdapter());
}
