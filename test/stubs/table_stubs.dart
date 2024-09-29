import 'package:restaurant_booking_app/models/reservation/reservation.dart';
import 'package:restaurant_booking_app/models/table/table_model.dart';

List<TableModel> _testTables = [
  TableModel(id: 0, chairs: 4, reservations: []),
  TableModel(id: 1, chairs: 4, reservations: [
    Reservation(dateTime: '2024-09-29T13:00:00.000Z', name: 'Jake'),
    Reservation(dateTime: '2024-09-29T15:00:00.000Z', name: 'James'),
  ]),
  TableModel(id: 2, chairs: 2, reservations: [
    Reservation(dateTime: '2024-09-30T10:00:00.000Z', name: 'Amy'),
    Reservation(dateTime: '2024-09-31T12:00:00.000Z', name: 'Robert'),
  ]),
];
