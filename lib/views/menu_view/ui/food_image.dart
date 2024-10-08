import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class FoodImage extends StatelessWidget {
  const FoodImage({
    super.key,
    required this.imageUrl,
  });

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? '',
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          color: CupertinoColors.systemGrey2,
          child: const Center(
              child: Text(
            'Failed to load image',
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          )),
        );
      },
      placeholder: (context, url) {
        return Container(
          color: CupertinoColors.systemGrey2,
          child: const CupertinoActivityIndicator(),
        );
      },
    );
  }
}
