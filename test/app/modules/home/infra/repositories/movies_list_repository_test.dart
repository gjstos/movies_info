import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_info/app/modules/home/infra/datasource/i_movies_list_datasource.dart';
import 'package:movies_info/app/modules/home/infra/models/movie_model.dart';
import 'package:movies_info/app/modules/home/infra/repositories/movies_list_repository.dart';

class MockMoviesListDatasource extends Mock implements IMoviesListDatasource {}

void main() {
  final datasource = MockMoviesListDatasource();
  final repository = MoviesListRepository(datasource);

  test('deve retornar uma lista de MovieModel', () async {
    when(datasource.getMovies()).thenAnswer(
      (_) async => <MovieModel>[
        MovieModel(
          data: null,
          genero: null,
          link: null,
          poster: null,
          sinopse: null,
          sinopseFull: null,
          titulo: null,
        )
      ],
    );

    var result = await repository.getMovies();
    expect(result | null, isA<List<MovieModel>>());
  });
}
