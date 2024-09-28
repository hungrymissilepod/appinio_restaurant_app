import 'package:flutter/cupertino.dart';
import 'package:restaurant_booking_app/models/food_item.dart';

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
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: IntrinsicHeight(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/pizza.png',
                  width: 96,
                  height: 96,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 32),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.name} slkdl skdlskld ksldksldkkdlskl dks slkd lskdlsk dl',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${item.description} sdkls kdlskd lksl dksdkls kldk sldsld sdksl dksdl sdlk sld',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '£price',
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
