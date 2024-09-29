import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:restaurant_booking_app/menu_view/ui/food_image.dart';
import 'package:restaurant_booking_app/models/food_item/food_item.dart';

class FoodItemTile extends StatelessWidget {
  const FoodItemTile({
    super.key,
    required this.item,
    this.onTap,
  });
  final FoodItem item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Container(
        color: CupertinoColors.white,
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: IntrinsicHeight(
          child: Row(
            children: [
              FoodImage(imageUrl: item.imageUrl),
              SizedBox(width: 32),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.name}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${item.description}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${item.price}',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
