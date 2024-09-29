import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:restaurant_booking_app/models/table/table_model.dart';

abstract class TableRepositoryProtocol {
  Future<List<TableModel>?> fetch();
  Future<bool> updateTable(TableModel table);
}

class TableRepository implements TableRepositoryProtocol {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  final Logger logger = Logger();

  final String _tableCollection = 'tables';

  @override
  Future<List<TableModel>?> fetch() async {
    logger.i('TableRepository - fetch');
    List<TableModel> tables = [];
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await db.collection(_tableCollection).get();

      for (var query in snapshot.docs) {
        TableModel table = TableModel.fromJson(query.data());
        tables.add(table);
      }

      /// Order tables by [id]
      tables.sort((TableModel a, TableModel b) => a.id.compareTo(b.id));
      return tables;
    } catch (e) {
      logger.e('TableRepository - failed to fetch tables: $e');
    }
    return null;
  }

  @override
  Future<bool> updateTable(TableModel table) async {
    logger.i('TableRepository - updateTable: ${table.props}');
    try {
      final String? docId = await _getDocumentIdForTable(table.id);
      await db.collection(_tableCollection).doc(docId).set(table.toJson());
    } catch (e) {
      logger.e('TableRepository - failed to update table: $e');
    }
    return false;
  }

  Future<String?> _getDocumentIdForTable(int? id) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection(_tableCollection).where('id', isEqualTo: id).get();

    return snapshot.docs.first.id;
  }
}
