import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_booking_app/models/table/table_model.dart';

abstract class TableRepositoryProtocol {
  Future<List<TableModel>> fetch();
  Future<bool> updateTable(TableModel table);
}

class TableRepository implements TableRepositoryProtocol {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  final String _tableCollection = 'tables';

  @override
  Future<List<TableModel>> fetch() async {
    List<TableModel> tables = [];
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await db.collection(_tableCollection).get();

      for (var query in snapshot.docs) {
        TableModel table = TableModel.fromJson(query.data());
        tables.add(table);
      }
    } catch (e) {
      print('failed to fetch tables: $e');
    }

    return tables;
  }

  @override
  Future<bool> updateTable(TableModel table) async {
    try {
      final String? docId = await _getDocumentIdForTable(table.id);
      await db.collection(_tableCollection).doc(docId).set(table.toJson());
    } catch (e) {
      print('failed to reserve table: $e');
    }
    return false;
  }

  Future<String?> _getDocumentIdForTable(int? id) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection(_tableCollection).where('id', isEqualTo: id).get();

    return snapshot.docs.first.id;
  }
}
