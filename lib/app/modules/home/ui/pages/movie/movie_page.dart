import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../domain/entities/movie.dart';
import '../../components/image_builder.dart';
import '../../controllers/movie_controller.dart';
import '../shared/constants.dart';

class MoviePage extends StatefulWidget {
  final Movie movie;

  MoviePage({Key key, @required this.movie}) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends ModularState<MoviePage, MovieController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Tooltip(
            message: 'Abrir no navegador',
            textStyle: defaultTooltipTextStyle,
            decoration: defaultTooltipDecoration,
            child: IconButton(
              icon: Icon(Icons.open_in_browser),
              onPressed: () async {
                await controller.launchUrl(widget.movie.link);
              },
            ),
          ),
          Tooltip(
            message: 'Compartilhar',
            textStyle: defaultTooltipTextStyle,
            decoration: defaultTooltipDecoration,
            child: IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                controller.shareMovie(widget.movie.link);
              },
            ),
          )
        ],
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _top(),
                const SizedBox(height: 30),
                Text(
                  'Sinopse:',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                ValueListenableBuilder(
                  valueListenable: controller.isFullSinopse,
                  builder: (context, isFullSinopse, child) {
                    return InkWell(
                      onTap: controller.changeSinopseState,
                      onLongPress: () {
                        Clipboard.setData(
                            ClipboardData(text: widget.movie.sinopseFull));
                        Fluttertoast.showToast(
                            msg: 'Sinopse copiada com sucesso!');
                      },
                      child: RichText(
                        text: TextSpan(
                          text: isFullSinopse
                              ? widget.movie.sinopseFull.trim()
                              : widget.movie.sinopse,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _top() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Card(
          shape: defaultShape,
          color: cardColor,
          child: SizedBox(
            height: 160,
            width: 110,
            child: ImageBuilder(source: widget.movie.poster),
          ),
          elevation: 15,
          shadowColor: Colors.grey[700],
        ),
        const SizedBox(width: 15),
        _title(genders: widget.movie.genero, title: widget.movie.titulo),
      ],
    );
  }

  Widget _title({List<String> genders, String title}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          onLongPress: () {
            Clipboard.setData(ClipboardData(text: title));
            Fluttertoast.showToast(msg: 'Título copiado com sucesso!');
          },
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            text: 'Lançamento: ',
            children: [
              TextSpan(
                text: widget.movie.data,
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
            ],
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          children: List.generate(
            genders.length,
            (index) => Chip(
              backgroundColor: cardColor,
              labelPadding: const EdgeInsets.symmetric(horizontal: 3),
              label: Text(
                genders[index],
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
          spacing: 6,
        ),
      ],
    );
  }
}
