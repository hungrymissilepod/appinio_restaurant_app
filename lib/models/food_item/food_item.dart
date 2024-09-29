import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'food_item.g.dart';

@JsonSerializable()
class FoodItem extends Equatable {
  const FoodItem({
    this.id,
    this.name,
    this.description,
  });

  final String? id;
  final String? name;
  final String? description;

  factory FoodItem.fromJson(Map<String, dynamic> json) =>
      _$FoodItemFromJson(json);

  Map<String, dynamic> toJson() => _$FoodItemToJson(this);

  @override
  List<Object?> get props => [id, name, description];
}
