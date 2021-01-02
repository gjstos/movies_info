import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class OpenMovie extends StatelessWidget {
  final Widget closedMovie;
  final Widget openMovie;

  const OpenMovie({
    Key key,
    @required this.closedMovie,
    @required this.openMovie,
  })  : assert(closedMovie != null),
        assert(openMovie != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedColor: Colors.black,
      closedBuilder: (_, openContainer) {
        return GestureDetector(
          child: closedMovie,
          onTap: openContainer,
        );
      },
      openBuilder: (_, closedContainer) {
        return openMovie;
      },
      useRootNavigator: true,
    );
  }
}
