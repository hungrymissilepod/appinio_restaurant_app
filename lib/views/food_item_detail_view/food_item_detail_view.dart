import 'package:flutter/cupertino.dart';
import 'package:restaurant_booking_app/views/common/common_divider.dart';
import 'package:restaurant_booking_app/views/food_item_detail_view/ui/food_info_section.dart';
import 'package:restaurant_booking_app/views/menu_view/ui/food_image.dart';
import 'package:restaurant_booking_app/models/food_item/food_item.dart';

class FoodItemDetailView extends StatelessWidget {
  const FoodItemDetailView({
    super.key,
    required this.item,
  });

  final FoodItem item;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        middle: Text(
          '${item.name}',
          style: const TextStyle(color: CupertinoColors.black),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: FoodImage(imageUrl: item.imageUrl),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            '${item.name}',
                            maxLines: 1,
                            style: CupertinoTheme.of(context)
                                .textTheme
                                .textStyle
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${item.price}',
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .textStyle
                          .copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 32),
                    FoodInfoSection(
                      title: 'Description',
                      body: item.description ?? '',
                    ),
                    const CommonDivider(),
                    FoodInfoSection(
                      title: 'Ingredients',
                      body: item.ingredients ?? '',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
