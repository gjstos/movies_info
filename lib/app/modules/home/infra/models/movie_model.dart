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
    bool isMovie = false,
  }) : super(
          data: data,
          genero: genero,
          link: link,
          poster: poster,
          sinopse: sinopse,
          sinopseFull: sinopseFull,
          titulo: titulo,
          isFav: isMovie,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    var genders;

    if (json['genero'].runtimeType == String) {
      genders = _stringToList(json['genero']);
    } else {
      genders = json['genero'];
    }

    return MovieModel(
      data: json['data'],
      genero: genders,
      link: json['link'],
      poster: json['poster'],
      sinopse: json['sinopse'],
      sinopseFull: json['sinopseFull'],
      titulo: json['titulo'],
      isMovie: json['isMovie'] ?? false,
    );
  }

  static List<String> _stringToList(String string) {
    return string.split(', ');
  }
}
