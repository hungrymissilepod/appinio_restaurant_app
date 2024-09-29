import 'package:restaurant_booking_app/models/table/table_model.dart';

abstract class TableRepositoryProtocol {
  Future<List<TableModel>> fetch();
}

class TableRepository implements TableRepositoryProtocol {
  @override
  Future<List<TableModel>> fetch() async {
    return _testTables;
  }
}

List<TableModel> _testTables = [
  TableModel(id: '0', chairs: 4),
  TableModel(id: '1', chairs: 4),
  TableModel(id: '2', chairs: 2),
  TableModel(id: '3', chairs: 2),
  TableModel(id: '4', chairs: 8),
  TableModel(id: '5', chairs: 10),
  TableModel(id: '6', chairs: 4),
];
