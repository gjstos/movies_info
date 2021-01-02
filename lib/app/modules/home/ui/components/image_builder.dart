import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageBuilder extends StatelessWidget {
  final String source;
  final BoxFit fit;
  final Alignment alignment;

  const ImageBuilder({
    Key key,
    @required this.source,
    this.fit = BoxFit.fill,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: source,
      imageBuilder: (_, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
              alignment: alignment,
            ),
          ),
        );
      },
      placeholder: (context, url) {
        return Shimmer.fromColors(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xff272727),
            ),
          ),
          enabled: true,
          baseColor: Colors.grey[800],
          highlightColor: Colors.grey[900],
        );
      },
      errorWidget: (context, url, error) => Icon(Icons.broken_image),
    );
  }
}
