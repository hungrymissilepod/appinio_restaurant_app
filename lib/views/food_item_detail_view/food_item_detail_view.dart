import 'package:flutter/cupertino.dart';
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
        middle: Text(
          '${item.name}',
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: FoodImage(imageUrl: item.imageUrl),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                    SizedBox(height: 4),
                    Text(
                      '£2.99',
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .textStyle
                          .copyWith(fontSize: 18),
                    ),
                    SizedBox(height: 16),
                    FoodInfoSection(
                      title: 'Description',
                      body: item.description ?? '',
                    ),
                    CupertinoDivider(),
                    FoodInfoSection(
                      title: 'Ingredients',
                      body: item.ingredients ?? '',
                    ),
                  ],
                ),
              ),

              // TODO: display more info here and fake variations and modiifers and buttons
            ],
          ),
        ),
      ),
    );
  }
}

class FoodInfoSection extends StatelessWidget {
  const FoodInfoSection({
    super.key,
    required this.title,
    required this.body,
  });

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: CupertinoTheme.of(context)
              .textTheme
              .textStyle
              .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(body),
      ],
    );
  }
}

class CupertinoDivider extends StatelessWidget {
  const CupertinoDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      height: 1,
      color: CupertinoColors.separator,
    );
  }
}
