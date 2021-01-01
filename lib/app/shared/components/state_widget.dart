import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StateWidget extends StatelessWidget {
  final String svgPath;
  final String label;

  const StateWidget({
    Key key,
    @required this.svgPath,
    @required this.label,
  })  : assert(svgPath != null),
        assert(label != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        heightFactor: 0.45,
        widthFactor: 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 5,
              child: SvgPicture.asset(svgPath, fit: BoxFit.fitWidth),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
