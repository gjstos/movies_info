import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_info/app/modules/home/domain/entities/movie.dart';
import 'package:movies_info/app/modules/home/domain/errors/errors.dart';
import 'package:movies_info/app/modules/home/infra/datasource/i_db_datasource.dart';
import 'package:movies_info/app/modules/home/infra/models/movie_model.dart';
import 'package:movies_info/app/modules/home/infra/repositories/favorites_db_repository.dart';

class MockDbDatasource extends Mock implements IDbDatasource {}

const hiveBox = 'testBox';

void main() {
  final datasource = MockDbDatasource();
  final repository = DbRepository(datasource);
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

  group('Delete:', () {
    test('Deve disparar EmptyListDb caso a base esteja vazia', () async {
      when(datasource.deleteMovie(any)).thenThrow(EmptyListDb());

      var result = await repository.delete(movie);

      expect(result.fold(id, id), isA<EmptyListDb>());
    });

    test(
      'Deve deve retornar false caso o favorito não exista na base',
      () async {
        when(datasource.deleteMovie(any)).thenAnswer((_) async => false);

        var result = await repository.delete(movie);

        expect(result.fold(id, id), false);
      },
    );

    test(
      'Deve deve retornar true caso o favorito exista na base e foi removido',
      () async {
        when(datasource.deleteMovie(any)).thenAnswer((_) async => true);

        var result = await repository.delete(movie);

        expect(result.fold(id, id), true);
      },
    );
  });

  group('Insert:', () {
    test(
      'Deve disparar FailureDatabase caso aconteça algum erro na base',
      () async {
        when(datasource.insertMovie(any)).thenThrow(Exception());

        var result = await repository.insert(movie);

        expect(result.fold(id, id), isA<FailureDatabase>());
      },
    );

    test('Deve retornar false caso a inserção não ocorra', () async {
      when(datasource.insertMovie(any)).thenAnswer((_) async => false);

      var result = await repository.insert(movie);

      expect(result.fold(id, id), false);
    });

    test('Deve retornar true caso a inserção ocorra', () async {
      when(datasource.insertMovie(any)).thenAnswer((_) async => true);

      var result = await repository.insert(movie);

      expect(result.fold(id, id), true);
    });
  });

  group('Update:', () {
    test(
      'Deve disparar um UnimplementedError, já que não foi implementado',
      () {
        expect(
          () async => await repository.update(movie),
          throwsA(isA<UnimplementedError>()),
        );
      },
    );
  });

  group('Find:', () {
    test(
      'Deve disparar um InvalidSearchTextDb quando o texto for inválido',
      () async {
        when(datasource.findMovie(any)).thenThrow(InvalidSearchTextDb());

        var result = await repository.find(null);

        expect(result.fold(id, id), isA<InvalidSearchTextDb>());
      },
    );

    test(
      'Deve disparar um DatasourceDbResultNull quando não completar a busca',
      () async {
        when(datasource.findMovie(any)).thenReturn(null);

        var result = await repository.find('info');

        expect(result.fold(id, id), isA<DatasourceDbResultNull>());
      },
    );

    test('Deve retornar um List<Movie> quando a busca ocorrer', () async {
      when(datasource.findMovie(any)).thenAnswer((_) async => <MovieModel>[]);

      var result = await repository.find('qwerty');

      expect(result.fold(id, id), isA<List<Movie>>());
    });
  });

  group('GetAll:', () {
    test('Deve retornar um EmptyListDb caso a base esteja vazia', () async {
      when(datasource.getAllMovies()).thenThrow(EmptyListDb());

      var result = await repository.getAll();

      expect(result.fold(id, id), isA<EmptyListDb>());
    });

    test(
      'Deve retornar um DatasourceDbResultNull caso a base retorne null',
      () async {
        when(datasource.getAllMovies()).thenAnswer((_) async => null);

        var result = await repository.getAll();

        expect(result.fold(id, id), isA<DatasourceDbResultNull>());
      },
    );

    test(
      'Deve retornar um List<Movie> caso a base contenha favoritos',
      () async {
        when(datasource.getAllMovies()).thenAnswer(
          (_) async => await <MovieModel>[
            MovieModel(
              data: '02/02/2022',
              genero: ['Ação', 'Comédia'],
              link: 'google.com',
              poster: 'link',
              sinopse: 'era uma vez...',
              sinopseFull: 'era uma vez uma casa...',
              titulo: 'A volta dos que não foram',
              isMovie: true,
            )
          ],
        );

        var result = await repository.getAll();

        expect(result | null, isA<List<MovieModel>>());
      },
    );
  });
}
