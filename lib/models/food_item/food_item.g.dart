// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodItem _$FoodItemFromJson(Map<String, dynamic> json) => FoodItem(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      ingredients: json['ingredients'] as String?,
      price: json['price'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$FoodItemToJson(FoodItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'ingredients': instance.ingredients,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
    };
