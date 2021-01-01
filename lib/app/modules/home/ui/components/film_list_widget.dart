import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../domain/entities/movie.dart';
import '../pages/movie/movie_page.dart';
import 'film_card.dart';
import 'open_movie.dart';

class FilmListWidget extends StatelessWidget {
  final List<Movie> movies;
  final void Function(int index) onFavorite;

  const FilmListWidget({Key key, this.movies, this.onFavorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size.height;

    return Center(
      child: SizedBox(
        height: _size * 0.67,
        child: Swiper(
          itemBuilder: (context, index) {
            return OpenMovie(
              closedMovie: FilmCard(
                movie: movies[index],
                onFavorite: () {
                  onFavorite(index);
                },
              ),
              openMovie: MoviePage(movie: movies[index]),
            );
          },
          itemCount: movies.length,
          viewportFraction: 0.8,
          scale: 0.9,
        ),
      ),
    );
  }
}
