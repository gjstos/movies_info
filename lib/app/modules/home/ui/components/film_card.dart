import 'package:flutter/material.dart';

import '../../domain/entities/movie.dart';
import 'image_builder.dart';

class FilmCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onFavorite;

  const FilmCard({Key key, @required this.movie, this.onFavorite})
      : assert(movie != null),
        assert(onFavorite != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size.height;

    return Card(
      color: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: _tooltip(
        message: movie.titulo,
        verticalOffset: _size * 0.3,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ImageBuilder(source: movie.poster),
            Positioned(
              top: 15,
              right: 15,
              child: _tooltip(
                message: movie.isFavorite ? 'Desfavoritar' : 'Favoritar',
                child: IconButton(
                  icon: Icon(
                    movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: movie.isFavorite ? Colors.red : Color(0xffdcdcdc),
                    size: 35,
                  ),
                  onPressed: onFavorite,
                ),
              ),
            ),
            Positioned(
              bottom: 2,
              left: 8,
              child: Wrap(
                children: _genders(),
                spacing: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _genders() {
    return List.generate(
      movie.genero.length,
      (index) => Chip(label: Text(movie.genero[index])),
    );
  }

  Widget _tooltip({Widget child, String message, double verticalOffset = 10}) {
    return Tooltip(
      message: message,
      textStyle: TextStyle(color: Colors.black),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
      verticalOffset: verticalOffset,
    );
  }
}
