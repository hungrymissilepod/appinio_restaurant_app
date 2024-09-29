import 'package:flutter/cupertino.dart';
import 'package:restaurant_booking_app/models/food_item/food_item.dart';
import 'package:restaurant_booking_app/views/food_item_detail_view/food_item_detail_view.dart';
import 'package:restaurant_booking_app/views/menu_view/ui/food_item_tile.dart';

class MenuViewLoadedState extends StatelessWidget {
  const MenuViewLoadedState({
    super.key,
    required this.items,
  });

  final List<FoodItem> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return FoodItemTile(
          item: items[index],
          onTap: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) {
                  return FoodItemDetailView(
                    item: items[index],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
