import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:restaurant_booking_app/models/food_item/food_item.dart';
import 'package:restaurant_booking_app/repositories/food_repository.dart';

part 'food_state.dart';

class FoodCubit extends Cubit<FoodState> {
  FoodCubit(this._repo) : super(const FoodInitial());

  final Logger logger = Logger();

  final FoodRepository _repo;

  List<FoodItem> _items = [];

  Future<void> fetch() async {
    logger.i('FoodCubit - fetch');
    emit(const FoodLoading());
    List<FoodItem>? items = await _repo.fetch();
    if (items == null) {
      emit(const FoodError('Failed to load items'));
      return;
    }

    _items = items;
    emit(FoodLoaded(_items));
  }

  void search(String value) {
    logger.i('FoodCubit - search: $value');
    emit(const FoodLoading());
    List<FoodItem> searchResults = [];
    searchResults = _items
        .where((FoodItem item) =>
            item.name?.toUpperCase().contains(value.toUpperCase()) == true)
        .toList();

    emit(FoodLoaded(searchResults));
  }
}
