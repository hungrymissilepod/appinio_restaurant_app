import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:restaurant_booking_app/models/food_item/food_item.dart';

abstract class FoodRepositoryProtocol {
  Future<List<FoodItem>> fetch();
}

class FoodRepository implements FoodRepositoryProtocol {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  final Logger logger = Logger();

  final String _foodCollection = 'food';

  @override
  Future<List<FoodItem>> fetch() async {
    logger.i('FoodRepository - fetch');
    List<FoodItem> items = [];
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await db.collection(_foodCollection).get();

      for (var query in snapshot.docs) {
        FoodItem item = FoodItem.fromJson(query.data());
        items.add(item);
      }
      return items;
    } catch (e) {
      throw Exception('FoodRepository - failed to fetch food: $e');
    }
  }
}
