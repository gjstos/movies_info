import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

part 'movie_controller.g.dart';

@Injectable()
class MovieController {
  ValueNotifier<bool> isFullSinopse = ValueNotifier(false);

  void changeSinopseState() => isFullSinopse.value = !isFullSinopse.value;

  void launchUrl(String urlString) async {
    if (await canLaunch(urlString)) {
      await launch(urlString);
    } else {
      Fluttertoast.showToast(msg: 'Ops! Parece que há algo errado com o site.');
    }
  }

  void shareMovie(String link) {
    Share.share(
        'Você precisa dar uma olhada neste filme! Aqui está o link: $link');
  }
}
