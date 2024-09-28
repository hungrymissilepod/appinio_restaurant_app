import 'package:restaurant_booking_app/models/food_item.dart';

abstract class FoodRepositoryProtocol {
  Future<List<FoodItem>> fetch();
}

class FoodRepository implements FoodRepositoryProtocol {
  @override
  Future<List<FoodItem>> fetch() async {
    await Future.delayed(Duration.zero);
    return _testItems;
  }
}

List<FoodItem> _testItems = [
  FoodItem(id: '0', name: 'Coffee', description: 'Nice coffee'),
  FoodItem(id: '1', name: 'Pizza', description: 'Nice pizza'),
  FoodItem(id: '2', name: 'Burger', description: 'Nice burger'),
  FoodItem(id: '2', name: 'Burger', description: 'Nice burger'),
  FoodItem(id: '2', name: 'Burger', description: 'Nice burger'),
  FoodItem(id: '2', name: 'Burger', description: 'Nice burger'),
  FoodItem(id: '2', name: 'Burger', description: 'Nice burger'),
  FoodItem(id: '2', name: 'Burger', description: 'Nice burger'),
  FoodItem(id: '2', name: 'Burger', description: 'Nice burger'),
  FoodItem(id: '2', name: 'Burger', description: 'Nice burger'),
  FoodItem(id: '2', name: 'Burger', description: 'Nice burger'),
  FoodItem(id: '2', name: 'Burger', description: 'Nice burger'),
  FoodItem(id: '2', name: 'Burger', description: 'Nice burger'),
  FoodItem(id: '2', name: 'Burger', description: 'Nice burger'),
  FoodItem(id: '2', name: 'Burger', description: 'Nice burger'),
];
