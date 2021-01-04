import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:movies_info/app/modules/home/domain/entities/movie.dart';
import 'package:movies_info/app/modules/home/domain/errors/errors.dart';
import 'package:movies_info/app/modules/home/external/hive/hive_db_datasource.dart';

void main() async {
  await initHive();

  final box = await Hive.openBox<Movie>('testBox');
  final datasource = DbDatasource(box);
  final movie = Movie(
    data: '02/02/2022',
    genero: ['Ação', 'Comédia'],
    link: 'google.com',
    poster: 'link',
    sinopse: 'era uma vez...',
    sinopseFull: 'era uma vez uma casa...',
    titulo: 'A volta dos que não foram',
    isFav: true,
  );

  group('Insert:', () {
    test('Deve retornar true ao salvar na base de dados', () async {
      datasource.box.clear();

      var result = await datasource.insertMovie(movie);

      expect(result, true);
    });

    test(
      'Deve disparar FullDatabase quando o limite de favoritos for atingido',
      () async {
        box.clear();

        box.add(Movie(
          data: 'asd',
          genero: ['qwe'],
          link: 'zxc',
          poster: 'lk',
          sinopse: 'null',
          sinopseFull: 'null',
          titulo: 'null',
        ));

        box.add(Movie(
          data: 'wwe',
          genero: ['qwe'],
          link: 'zxc',
          poster: 'lk',
          sinopse: 'null',
          sinopseFull: 'null',
          titulo: 'null',
        ));

        box.add(Movie(
          data: 'zxc',
          genero: ['qwe'],
          link: 'zxc',
          poster: 'lk',
          sinopse: 'null',
          sinopseFull: 'null',
          titulo: 'null',
        ));

        var exception;
        try {
          await datasource.insertMovie(movie);
        } on Exception catch (e) {
          exception = e.runtimeType;
        }

        expect(exception, FullDatabase);
      },
    );
  });

  group('Update:', () {
    test(
      'Deve disparar um UnimplementedError, já que não foi implementado',
      () async {
        expect(
          () async => datasource.updateMovie(movie),
          throwsA(isA<UnimplementedError>()),
        );
      },
    );
  });

  group('Delete:', () {
    test('Deve retornar true ao remover da base de dados', () async {
      box.clear();

      box.add(movie);

      var result = await datasource.deleteMovie(movie);

      expect(result, true);
    });

    test('Deve disparar EmptyListDb quando a base está vazia', () async {
      box.clear();

      expect(
        () async => datasource.deleteMovie(movie),
        throwsA(isA<EmptyListDb>()),
      );
    });

    test(
      'Deve retornar false ao tentar remover um favorito inválido',
      () async {
        var result = await datasource.deleteMovie(null);

        expect(result, false);
      },
    );
  });
  group('Find:', () {
    test(
      'Deve disparar um InvalidSearchTextDb quando o texto for inválido',
      () async {
        var exception;

        try {
          await datasource.findMovie(null);
        } on Exception catch (e) {
          exception = e.runtimeType;
        }

        expect(exception, InvalidSearchTextDb);
      },
    );

    test(
      'Deve retornar uma lista vazia quando nada for encontrado',
      () async {
        var result = await datasource.findMovie('qwerty');

        expect(result, <Movie>[]);
      },
    );

    test(
      'Deve retornar uma lista com movies quando algo for encontrado',
      () async {
        datasource.box.clear();

        box.add(Movie(
          data: 'zxc',
          genero: ['qwe'],
          link: 'zxc',
          poster: 'lk',
          sinopse: 'qwe',
          sinopseFull: 'qwerty',
          titulo: 'qwerty',
        ));

        var result = await datasource.findMovie('qw');

        expect(result.isNotEmpty, true);
      },
    );
  });
}

void initHive() async {
  var path = Directory.current.path;
  await Hive.init('$path/test/app/modules/home/external/hive');
  Hive.registerAdapter<Movie>(MovieAdapter());
}
