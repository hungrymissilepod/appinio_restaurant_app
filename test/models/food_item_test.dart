import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_booking_app/models/food_item/food_item.dart';

void main() {
  group('FoodItem -', () {
    test('fromJson deserialises correctly', () {
      Map<String, dynamic> map = <String, dynamic>{
        'id': '1',
        'name': 'Pizza',
        'ingredients': 'cheese',
        'price': '£10.99',
        'imageUrl': ''
      };

      FoodItem item = FoodItem.fromJson(map);

      expect(item.id, '1');
      expect(item.name, 'Pizza');
      expect(item.description, null);
      expect(item.imageUrl, '');
    });

    test('toJson serialises correctly', () {
      FoodItem item = const FoodItem(
          id: '1', name: 'Burger', imageUrl: null, description: '');

      Map<String, dynamic> map = item.toJson();

      expect(map['id'], '1');
      expect(map['name'], 'Burger');
      expect(map['imageUrl'], null);
      expect(map['description'], '');
    });
  });
}
