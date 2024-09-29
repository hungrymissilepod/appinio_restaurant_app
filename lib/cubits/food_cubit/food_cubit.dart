import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_booking_app/models/food_item/food_item.dart';
import 'package:restaurant_booking_app/repositories/food_repository.dart';

part 'food_state.dart';

class FoodCubit extends Cubit<FoodState> {
  FoodCubit(this._repo) : super(FoodInitial());

  final FoodRepository _repo;

  List<FoodItem> _items = [];

  Future<void> fetch() async {
    print('FoodCubit - fetch');
    emit(FoodLoading());
    try {
      _items = await _repo.fetch();
      emit(FoodLoaded(_items));
    } catch (e) {
      emit(FoodError('Failed to load items'));
    }
  }

  void search(String value) {
    print('search: $value');
    emit(FoodLoading());
    List<FoodItem> searchResults = [];
    searchResults = _items
        .where((FoodItem item) =>
            item.name?.toUpperCase().contains(value.toUpperCase()) == true)
        .toList();

    emit(FoodLoaded(searchResults));
  }
}
