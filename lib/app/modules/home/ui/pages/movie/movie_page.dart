import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../domain/entities/movie.dart';
import '../../components/image_builder.dart';

class MoviePage extends StatelessWidget {
  final Movie movie;
  final GlobalKey _shaderKey = GlobalKey();

  MoviePage({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          _poster(movie.poster, _size),
        ],
      ),
    );
  }

  Widget _poster(String source, double size) {
    return ShaderMask(
      key: _shaderKey,
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment(0, 0.3),
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.transparent],
        ).createShader(
          Rect.fromLTRB(0, 0, rect.width, rect.height),
        );
      },
      blendMode: BlendMode.dstIn,
      child: SizedBox(
        width: double.infinity,
        height: size * 0.4,
        child: ImageBuilder(
          source: source,
          fit: BoxFit.cover,
          alignment: Alignment(0, -0.4),
        ),
      ),
    );
  }

  // Widget _title({String title, String poster}) {}
}
