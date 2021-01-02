import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('MoviesInfo'),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(text: 'EM CARTAZ'),
                Tab(text: 'FAVORITOS'),
              ],
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              _buildMoviesTab(),
              Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoviesTab() {
    return RefreshIndicator(
      child: Stack(
        children: [
          ListView(),
          Observer(
            builder: (_) {
              if (controller.state.runtimeType == StartState) {
                return StateWidget(
                  label: 'Nada encontrado!',
                  svgPath: 'assets/not_found.svg',
                );
              } else if (controller.state.runtimeType == LoadingState &&
                  controller.movies.isEmpty) {
                return StateWidget(
                  label: 'Carregando...',
                  svgPath: 'assets/loading.svg',
                );
              } else if (controller.state.runtimeType ==
                      NoInternetConnectionState &&
                  controller.movies.isEmpty) {
                return StateWidget(
                  label: 'Sem conexão à internet...',
                  svgPath: 'assets/not_found.svg',
                );
              } else {
                return FilmListWidget(
                  movies: controller.movies,
                  onFavorite: (index) {
                    var _isFav = controller.movies[index].isFavorite;
                    var _isFavMessage = _isFav ? 'desfavoritado' : 'favoritado';
                    controller.favoriteMovie(index);
                    Fluttertoast.showToast(
                      msg:
                          '${controller.movies[index].titulo} $_isFavMessage com sucesso!',
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
      onRefresh: controller.runGetMovies,
    );
  }
}
