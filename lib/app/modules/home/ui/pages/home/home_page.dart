import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../shared/components/state_widget.dart';
import '../../components/film_list_widget.dart';
import '../../controllers/home_controller.dart';
import '../../states/movies_get_state.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            title: Text('MoviesInfo'),
            centerTitle: true,
            backgroundColor: Colors.black,
            bottom: TabBar(
              tabs: [
                Tab(text: 'Em Cartaz'),
                Tab(text: 'Favoritos'),
              ],
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Observer(
                builder: (_) {
                  if (controller.state.runtimeType == StartState) {
                    return StateWidget(
                      label: 'Nada encontrado!',
                      svgPath: 'assets/nothing_found.svg',
                    );
                  } else if (controller.state.runtimeType == LoadingState) {
                    return StateWidget(
                      label: 'Carregando...',
                      svgPath: 'assets/loading.svg',
                    );
                  } else {
                    return FilmListWidget(
                      movies: controller.movies,
                      onFavorite: (index) {
                        controller.favoriteMovie(index);
                      },
                    );
                  }
                },
              ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
