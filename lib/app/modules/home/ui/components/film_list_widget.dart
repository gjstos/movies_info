import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../domain/entities/movie.dart';
import '../pages/movie/movie_page.dart';
import 'film_card.dart';
import 'open_movie.dart';

class FilmListWidget extends StatelessWidget {
  final List<Movie> movies;
  final void Function(int index) onMovie;

  const FilmListWidget({Key key, this.movies, this.onMovie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size.height;

    return Center(
      child: SizedBox(
        height: _size * 0.7,
        child: _buildList(movies.length, _size * 0.648),
      ),
    );
  }

  Widget _buildList(int length, double size) {
    if (length == 1) {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: OpenMovie(
          closedMovie: FilmCard(
            movie: movies[0],
            onMovie: () {
              onMovie(0);
            },
          ),
          openMovie: MoviePage(movie: movies[0]),
        ),
      );
    }

    return Swiper(
      itemBuilder: (context, index) {
        return OpenMovie(
          closedMovie: FilmCard(
            movie: movies[index],
            onMovie: () {
              onMovie(index);
            },
          ),
          openMovie: MoviePage(movie: movies[index]),
        );
      },
      itemCount: movies.length,
      viewportFraction: 0.8,
      scale: 0.9,
      layout: SwiperLayout.CUSTOM,
      itemWidth: 300.0,
      itemHeight: size,
      customLayoutOption: CustomLayoutOption(
        startIndex: -1,
        stateCount: 3,
      ).addRotate([-45.0 / 180, 0.0, 45.0 / 180]).addTranslate(
        [
          const Offset(-370.0, -40.0),
          const Offset(0.0, 0.0),
          const Offset(370.0, -40.0)
        ],
      ),
    );
  }
}
