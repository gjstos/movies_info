import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app_module.dart';
import 'app/modules/home/domain/entities/favorite.dart';

const _favoritesDbBox = 'favoritesDB';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Favorite>(FavoriteAdapter());
  await Hive.openBox<Favorite>(_favoritesDbBox);
  runApp(ModularApp(module: AppModule()));
}
