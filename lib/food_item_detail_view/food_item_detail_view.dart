import 'package:flutter/cupertino.dart';
import 'package:restaurant_booking_app/models/food_item.dart';

class FoodItemDetailView extends StatefulWidget {
  const FoodItemDetailView({
    super.key,
    required this.item,
  });

  final FoodItem item;

  @override
  State<FoodItemDetailView> createState() => _FoodItemDetailViewState();
}

class _FoodItemDetailViewState extends State<FoodItemDetailView> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      navigationBar: CupertinoNavigationBar(
        middle: Text('${widget.item.name}'),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/pizza.png'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    '${widget.item.name}s kdlskdk sldkskdlskdsldkldk lsdk lsdl skd kld ksldksldk',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('£2.99'),
                ),
              ],
            ),
            Text('${widget.item.description}'),

            // TODO: display more info here and fake variations and modiifers and buttons
          ],
        ),
      ),
    );
  }
}
