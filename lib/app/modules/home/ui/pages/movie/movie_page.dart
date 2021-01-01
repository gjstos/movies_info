import 'package:flutter/material.dart';

import '../../../domain/entities/movie.dart';

class MoviePage extends StatelessWidget {
  final Movie movie;

  const MoviePage({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(
        '${movie.data}, ${movie.genero}, ${movie.isFavorite}, ${movie.link}, ${movie.poster}, ${movie.sinopse}, ${movie.sinopseFull}, ${movie.titulo}');
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
