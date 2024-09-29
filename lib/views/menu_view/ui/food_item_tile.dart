import 'package:flutter/cupertino.dart';
import 'package:restaurant_booking_app/views/menu_view/ui/food_image.dart';
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
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: IntrinsicHeight(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                    width: 96,
                    height: 96,
                    child: FoodImage(imageUrl: item.imageUrl)),
              ),
              const SizedBox(width: 32),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.name}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .textStyle
                          .copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
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
