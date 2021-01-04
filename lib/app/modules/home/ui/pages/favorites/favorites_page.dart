import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../shared/components/state_widget.dart';
import '../../components/film_list_widget.dart';
import '../../controllers/favorites_store.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends ModularState<FavoritesPage, FavoritesStore> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.getFavorites,
      child: Stack(
        children: [
          ListView(),
          Observer(
            builder: (context) {
              if (controller.favorites.isEmpty) {
                return StateWidget(
                  label: 'Nenhum favorito encontrado!',
                  svgPath: 'assets/not_found.svg',
                );
              }

              return FilmListWidget(
                movies: controller.favorites,
                onMovie: (index) async {
                  var title = controller.favorites[index].titulo;
                  var result =
                      await controller.deleteMovie(controller.favorites[index]);

                  if (result) {
                    Fluttertoast.showToast(
                      msg: '$title desfavoritado com sucesso!',
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
