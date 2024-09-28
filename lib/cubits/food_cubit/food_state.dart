part of 'food_cubit.dart';

abstract class FoodState extends Equatable {
  const FoodState();
}

class FoodInitial extends FoodState {
  const FoodInitial();

  @override
  List<Object> get props => [];
}

class FoodLoading extends FoodState {
  const FoodLoading();

  @override
  List<Object> get props => [];
}

class FoodLoaded extends FoodState {
  const FoodLoaded(this.items);

  final List<FoodItem> items;

  @override
  List<Object> get props => [items];
}

class FoodError extends FoodState {
  const FoodError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
