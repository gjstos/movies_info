import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'movie.g.dart';

@HiveType(typeId: 0)
class Movie extends HiveObject {
  @HiveField(0)
  final String data;
  @HiveField(1)
  final List<String> genero;
  @HiveField(2)
  final String link;
  @HiveField(3)
  final String poster;
  @HiveField(4)
  final String sinopse;
  @HiveField(5)
  final String sinopseFull;
  @HiveField(6)
  final String titulo;
  @HiveField(7)
  bool isFav;

  Movie({
    @required this.data,
    @required this.genero,
    @required this.link,
    @required this.poster,
    @required this.sinopse,
    @required this.sinopseFull,
    @required this.titulo,
    this.isFav = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'genero': genero,
      'link': link,
      'poster': poster,
      'sinopse': sinopse,
      'sinopseFull': sinopseFull,
      'titulo': titulo,
      'isMovie': isFav,
    };
  }
}
