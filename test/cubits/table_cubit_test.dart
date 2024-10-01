import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_booking_app/cubits/table_cubit/table_cubit.dart';
import 'package:restaurant_booking_app/models/reservation/reservation.dart';
import 'package:restaurant_booking_app/models/table/table_model.dart';
import 'package:restaurant_booking_app/repositories/table_repository.dart';

class MockTableRepository extends Mock implements TableRepository {}

void main() {
  group('TableCubit -', () {
    final MockTableRepository mockTableRepository = MockTableRepository();

    setUpAll(() {
      registerFallbackValue(TableModel(id: 0));
    });

    blocTest<TableCubit, TableState>(
      'fetch() a list of TableModel',
      build: () {
        when(() => mockTableRepository.fetch())
            .thenAnswer((_) => Future<List<TableModel>?>.value([]));
        return TableCubit(mockTableRepository);
      },
      act: (bloc) => bloc.fetch(),
      expect: () => [
        isA<TableLoading>(),
        isA<TableLoaded>(),
      ],
    );

    blocTest<TableCubit, TableState>(
      'fetch() emits error state when TableRepository throws an error',
      build: () {
        when(() => mockTableRepository.fetch())
            .thenAnswer((_) => Future<List<TableModel>?>.value(null));
        return TableCubit(mockTableRepository);
      },
      act: (bloc) => bloc.fetch(),
      expect: () => [
        isA<TableLoading>(),
        isA<TableError>(),
      ],
    );

    blocTest<TableCubit, TableState>(
      'bookTable() states',
      build: () {
        when(() => mockTableRepository.fetch())
            .thenAnswer((_) => Future<List<TableModel>?>.value([]));
        when(() => mockTableRepository.updateTable(any()))
            .thenAnswer((_) => Future<bool>.value(true));
        return TableCubit(mockTableRepository);
      },
      act: (bloc) => bloc.updateTable(0),
      expect: () => [
        isA<TableUpdating>(),
        isA<TableLoaded>(),
      ],
    );

    blocTest<TableCubit, TableState>(
      'bookTable() states when TableRepository fetch() returns null',
      build: () {
        when(() => mockTableRepository.fetch())
            .thenAnswer((_) => Future<List<TableModel>?>.value(null));
        when(() => mockTableRepository.updateTable(any()))
            .thenAnswer((_) => Future<bool>.value(true));
        return TableCubit(mockTableRepository);
      },
      act: (bloc) => bloc.updateTable(0),
      expect: () => [
        isA<TableUpdating>(),
        isA<TableError>(),
      ],
    );

    test('tableStatus()', () {
      TableCubit cubit = TableCubit(mockTableRepository);

      TableStatus tableStatus = cubit.tableStatus(
        TableModel(
          id: 0,
          chairs: 4,
          reservations: const [
            Reservation(dateTime: '2024-10-01', name: 'Jake')
          ],
        ),
        '2024-10-01',
      );
      expect(tableStatus, TableStatus.reservedByMe);

      TableStatus tableStatus2 = cubit.tableStatus(
        TableModel(
          id: 0,
          chairs: 4,
          reservations: const [
            Reservation(dateTime: '2024-10-01', name: 'John')
          ],
        ),
        '2024-10-01',
      );
      expect(tableStatus2, TableStatus.reservedByOther);

      TableStatus tableStatus3 = cubit.tableStatus(
        TableModel(
          id: 0,
          chairs: 4,
          reservations: const [],
        ),
        '2024-10-01',
      );
      expect(tableStatus3, TableStatus.available);
    });
  });
}
