import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../domain/entities/movie.dart';

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
            _buildImage(movie.poster),
            Positioned(
              top: 15,
              right: 15,
              child: _tooltip(
                message: movie.isFavorite ? 'Desfavoritar' : 'Favoritar',
                child: IconButton(
                  icon: Icon(
                    movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: movie.isFavorite ? Colors.red : Colors.grey,
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

  Widget _buildImage(String source) {
    return CachedNetworkImage(
      imageUrl: source,
      alignment: Alignment.center,
      fit: BoxFit.fill,
      imageBuilder: (_, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
          ),
        );
      },
      placeholder: (context, url) {
        return Shimmer.fromColors(
          child: Container(
            color: Colors.white,
          ),
          enabled: true,
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
        );
      },
      errorWidget: (context, url, error) => Icon(Icons.broken_image),
    );
  }

  List<Widget> _genders() {
    var list = movie.genero.split(', ');

    return List.generate(
      list.length,
      (index) => Chip(label: Text(list[index])),
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