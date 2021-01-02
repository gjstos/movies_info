import 'package:flutter/foundation.dart';

import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    @required String data,
    @required List<String> genero,
    @required String link,
    @required String poster,
    @required String sinopse,
    @required String sinopseFull,
    @required String titulo,
    bool isFavorite = false,
  }) : super(
          data: data,
          genero: genero,
          link: link,
          poster: poster,
          sinopse: sinopse,
          sinopseFull: sinopseFull,
          titulo: titulo,
          isFavorite: isFavorite,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      data: json['data'],
      genero: _stringToList(json['genero']),
      link: json['link'],
      poster: json['poster'],
      sinopse: json['sinopse'],
      sinopseFull: json['sinopseFull'],
      titulo: json['titulo'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  static List<String> _stringToList(String string) {
    return string.split(', ');
  }
}
