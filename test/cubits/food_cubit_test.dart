import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_booking_app/cubits/food_cubit/food_cubit.dart';
import 'package:restaurant_booking_app/models/food_item/food_item.dart';
import 'package:restaurant_booking_app/repositories/food_repository.dart';

class MockFoodRepository extends Mock implements FoodRepository {}

void main() {
  group('FoodCubit -', () {
    final MockFoodRepository mockFoodRepository = MockFoodRepository();

    blocTest<FoodCubit, FoodState>(
      'fetch() a list of FoodItem',
      build: () {
        when(() => mockFoodRepository.fetch())
            .thenAnswer((_) => Future<List<FoodItem>?>.value([]));
        return FoodCubit(mockFoodRepository);
      },
      act: (bloc) => bloc.fetch(),
      expect: () => [
        isA<FoodLoading>(),
        isA<FoodLoaded>(),
      ],
    );

    blocTest<FoodCubit, FoodState>(
      'fetch() emits erorr state when FoodRepository throws an error',
      build: () {
        when(() => mockFoodRepository.fetch())
            .thenAnswer((_) => Future<List<FoodItem>?>.value(null));
        return FoodCubit(mockFoodRepository);
      },
      act: (bloc) => bloc.fetch(),
      expect: () => [
        isA<FoodLoading>(),
        isA<FoodError>(),
      ],
    );

    blocTest<FoodCubit, FoodState>(
      'search() a list of FoodItem',
      build: () {
        when(() => mockFoodRepository.fetch())
            .thenAnswer((_) => Future<List<FoodItem>?>.value([]));
        return FoodCubit(mockFoodRepository);
      },
      act: (bloc) => bloc.search('Pizza'),
      expect: () => [
        isA<FoodLoading>(),
        isA<FoodLoaded>(),
      ],
    );
  });
}
