import 'package:flutter/foundation.dart';

class Movie {
  final String data;
  final String genero;
  final String link;
  final String poster;
  final String sinopse;
  final String sinopseFull;
  final String titulo;

  const Movie({
    @required this.data,
    @required this.genero,
    @required this.link,
    @required this.poster,
    @required this.sinopse,
    @required this.sinopseFull,
    @required this.titulo,
  });
}
