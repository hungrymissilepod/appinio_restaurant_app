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
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 96,
        height: 96,
        child: CachedNetworkImage(
          imageUrl:
              'https://firebasestorage.googleapis.com/v0/b/appinio-restaurant-booking-app.appspot.com/o/cookies.png?alt=media&token=cadd2eba-69d9-4abc-af47-be7ebce5fe09',
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
              child: Center(
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
              child: CupertinoActivityIndicator(),
            );
          },
        ),
      ),
    );
  }
}
