import 'dart:io';

import 'package:dartz/dartz.dart' hide Bind;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:movies_info/app/modules/home/domain/entities/movie.dart';
import 'package:movies_info/app/modules/home/domain/errors/errors.dart';
import 'package:movies_info/app/modules/home/home_module.dart';
import 'package:movies_info/app/modules/home/ui/controllers/db_favorites_facade.dart';

void main() async {
  await initHive();
  final box = await Hive.openBox<Movie>('testBox');

  initModule(HomeModule(), changeBinds: [
    Bind<Box<Movie>>((i) => box),
  ]);

  final facade = Modular.get<DbMoviesFacade>();

  group('insertFavorite:', () {
    test('Inserção válida', () async {
      facade.favoritesBox.deleteAll(facade.favoritesBox.keys);

      var movieTest = Movie(
        data: '11/11/11',
        genero: ['null'],
        link: 'google.com',
        poster: 'google.com/image.png',
        sinopse: 'era uma vez',
        sinopseFull: 'era uma vez uma história',
        titulo: 'a volta dos que não foram',
      );

      facade.insertFavorite(movieTest);

      var length = facade.favoritesBox.length == 1;
      var contains = facade.favoritesBox.containsKey(movieTest.key);

      expect(length && contains, true);
    });

    test('Inserção inválida', () async {
      var result = await facade.insertFavorite(null);

      expect(result | null, false);
    });

    test('Inserção em base cheia', () async {
      facade.favoritesBox.deleteAll(facade.favoritesBox.keys);

      var movie1 = Movie(
        data: '12/13/14',
        genero: ['ação'],
        link: 'qwerty.co',
        poster: 'null.png',
        sinopse: 'null movie',
        sinopseFull: 'null movie at theater',
        titulo: 'batman begins',
      );
      var movie2 = Movie(
        data: '14/13/14',
        genero: ['comédia'],
        link: 'null.ink',
        poster: 'null.jpg',
        sinopse: 'null null null',
        sinopseFull: 'null null null and more...',
        titulo: 'null movie',
      );
      var movie3 = Movie(
        data: '20/20/20',
        genero: ['adult'],
        link: 'null.uk',
        poster: 'null-uk.gif',
        sinopse: 'null-uk',
        sinopseFull: 'null-uk full',
        titulo: 'null-uk',
      );

      await facade.insertFavorite(movie1);
      await facade.insertFavorite(movie2);
      await facade.insertFavorite(movie3);

      var result = await facade.insertFavorite(Movie(
        data: '12345',
        genero: ['null'],
        link: 'null.com.uk',
        poster: 'null.ink',
        sinopse: 'null ink at ink',
        sinopseFull: 'null null ink at ink',
        titulo: 'ink null',
      ));

      expect(result.fold(id, id), isA<FailureDatabase>());
    });
  });

  group('isBaseFull:', () {
    test('Base cheia', () async {
      facade.favoritesBox.deleteAll(facade.favoritesBox.keys);

      var movie1 = Movie(
        data: '12/13/14',
        genero: ['ação'],
        link: 'qwerty.co',
        poster: 'null.png',
        sinopse: 'null movie',
        sinopseFull: 'null movie at theater',
        titulo: 'batman begins',
      );
      var movie2 = Movie(
        data: '14/13/14',
        genero: ['comédia'],
        link: 'null.ink',
        poster: 'null.jpg',
        sinopse: 'null null null',
        sinopseFull: 'null null null and more...',
        titulo: 'null movie',
      );
      var movie3 = Movie(
        data: '20/20/20',
        genero: ['adult'],
        link: 'null.uk',
        poster: 'null-uk.gif',
        sinopse: 'null-uk',
        sinopseFull: 'null-uk full',
        titulo: 'null-uk',
      );

      await facade.insertFavorite(movie1);
      await facade.insertFavorite(movie2);
      await facade.insertFavorite(movie3);

      var result = facade.isBaseFull();

      expect(result, true);
    });

    test('Base contém espaço para inserção', () {
      facade.favoritesBox.deleteAll(facade.favoritesBox.keys);

      var result = facade.isBaseFull();

      expect(result, false);
    });
  });

  group('deleteFavorite:', () {
    test('Deve retornar true caso haja a remoção', () async {
      facade.favoritesBox.deleteAll(facade.favoritesBox.keys);

      var movie = Movie(
        data: '20/20/20',
        genero: ['adult'],
        link: 'null.uk',
        poster: 'null-uk.gif',
        sinopse: 'null-uk',
        sinopseFull: 'null-uk full',
        titulo: 'null-uk',
      );

      await facade.insertFavorite(movie);

      var result = await facade.deleteFavorite(movie);

      expect(result, true);
    });

    test('Deve retornar false caso não haja a remoção', () async {
      facade.favoritesBox.deleteAll(facade.favoritesBox.keys);

      var movie = Movie(
        data: '20/20/20',
        genero: ['adult'],
        link: 'null.uk',
        poster: 'null-uk.gif',
        sinopse: 'null-uk',
        sinopseFull: 'null-uk full',
        titulo: 'null-uk',
      );

      var result = await facade.deleteFavorite(movie);

      expect(result, false);
    });
  });

  group('getFavorites:', () {
    test(
      'Deve retornar um List<Movie> vazio caso não haja favoritos',
      () async {
        facade.favoritesBox.deleteAll(facade.favoritesBox.keys);

        var result = await facade.getFavorites();

        expect(result, isA<List<Movie>>());
        expect(result.isEmpty, true);
      },
    );

    test('Deve retornar um List<Movie> com os filmes favoritos', () async {
      facade.favoritesBox.deleteAll(facade.favoritesBox.keys);

      var movies = [
        Movie(
          data: '12/13/14',
          genero: ['ação'],
          link: 'qwerty.co',
          poster: 'null.png',
          sinopse: 'null movie',
          sinopseFull: 'null movie at theater',
          titulo: 'batman begins',
        ),
        Movie(
          data: '14/13/14',
          genero: ['comédia'],
          link: 'null.ink',
          poster: 'null.jpg',
          sinopse: 'null null null',
          sinopseFull: 'null null null and more...',
          titulo: 'null movie',
        ),
      ];

      await facade.insertFavorite(movies[0]);
      await facade.insertFavorite(movies[1]);

      var result = await facade.getFavorites();

      expect(result.length == 2, true);
    });
  });

  group('alreadyFavorite:', () {
    test('Já favorito', () async {
      var movie1 = Movie(
        data: '12/13/14',
        genero: ['ação'],
        link: 'qwerty.co',
        poster: 'null.png',
        sinopse: 'null movie',
        sinopseFull: 'null movie at theater',
        titulo: 'batman begins',
      );

      await facade.insertFavorite(movie1);

      var result = await facade.alreadyFavorite('batman');

      expect(result, true);
    });

    test('Ainda não é favorito', () async {
      var result = await facade.alreadyFavorite('joker');

      expect(result, false);
    });
  });
}

void initHive() async {
  var path = Directory.current.path;
  Hive.registerAdapter<Movie>(MovieAdapter());
  await Hive.init('$path/test/app');
}
