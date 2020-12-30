import 'package:flutter/foundation.dart';

import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    @required String data,
    @required String genero,
    @required String link,
    @required String poster,
    @required String sinopse,
    @required String sinopseFull,
    @required String titulo,
  }) : super(
          data: data,
          genero: genero,
          link: link,
          poster: poster,
          sinopse: sinopse,
          sinopseFull: sinopseFull,
          titulo: titulo,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      data: json['data'],
      genero: json['genero'],
      link: json['link'],
      poster: json['poster'],
      sinopse: json['sinopse'],
      sinopseFull: json['sinopseFull'],
      titulo: json['titulo'],
    );
  }
}