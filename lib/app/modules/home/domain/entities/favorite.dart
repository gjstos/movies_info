import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'favorite.g.dart';

@HiveType(typeId: 0)
class Favorite extends HiveObject {
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
  bool isFavorite;

  Favorite({
    @required this.data,
    @required this.genero,
    @required this.link,
    @required this.poster,
    @required this.sinopse,
    @required this.sinopseFull,
    @required this.titulo,
    this.isFavorite = true,
  })  : assert(data != null),
        assert(genero != null),
        assert(link != null),
        assert(poster != null),
        assert(sinopse != null),
        assert(sinopseFull != null),
        assert(titulo != null);
}
