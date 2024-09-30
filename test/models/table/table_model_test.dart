import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_booking_app/models/reservation/reservation.dart';
import 'package:restaurant_booking_app/models/table/table_model.dart';

void main() {
  group('TableModel -', () {
    test('fromJson deserialises correctly', () {
      Map<String, dynamic> map = <String, dynamic>{
        'id': 1,
        'chairs': 4,
        'reservations': [
          {
            'dataTime': '2024-09-30',
            'name': 'Bob',
          },
        ],
      };

      TableModel table = TableModel.fromJson(map);

      expect(table.id, 1);
      expect(table.chairs, 4);
      expect(table.reservations?.length, 1);

      final Reservation? reservation = table.reservations?.first;
      expect(reservation?.name, 'Bob');
    });

    test('toJson serialises correctly', () {
      TableModel table = TableModel(id: 2, chairs: 6, reservations: const []);

      final Map<String, dynamic> map = table.toJson();
      expect(map['id'], 2);
      expect(map['chairs'], 6);
      expect(map['reservations'], []);
    });
  });
}
