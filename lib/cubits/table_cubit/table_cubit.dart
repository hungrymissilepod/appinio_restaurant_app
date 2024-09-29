import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:restaurant_booking_app/models/reservation/reservation.dart';
import 'package:restaurant_booking_app/models/table/table_model.dart';
import 'package:restaurant_booking_app/repositories/table_repository.dart';

part 'table_state.dart';

/// This is the username that we are comparing against when checking if the
/// current user has reserved a table.
/// In a real application we would instead check against the logged in user's uid
const kCurrentUsername = 'Jake';

enum TableStatus { available, reservedByMe, reservedByOther }

class TableCubit extends Cubit<TableState> {
  TableCubit(this._repo) : super(TableInitial());

  final TableRepository _repo;

  final Logger logger = Logger();

  List<TableModel> _tables = [];

  Future<void> fetch() async {
    logger.i('TableCubit - fetch');
    emit(TableLoading());

    List<TableModel>? tables = await _repo.fetch();
    if (tables == null) {
      emit(TableError('Failed to fetch tables'));
      return;
    }

    _tables = tables;
    emit(TableLoaded(tables: _tables));
  }

  Future<void> updateTable(int? id) async {
    logger.i('TableCubit - updateTable: $id');
    emit(TableUpdating(id, tables: _tables));

    List<TableModel>? tables = await _repo.fetch();
    if (tables == null) {
      emit(TableError('Failed to update table: $id'));
      return;
    }

    _tables = tables;
    emit(TableLoaded(tables: _tables));
  }

  Future<void> bookTable(int? id, String dt, String name) async {
    logger.i('TableCubit - bookTable: $id - $dt - $name');
    int index = _tables.indexWhere((TableModel table) => table.id == id);
    if (index != -1) {
      if (_tables[index]
              .reservations
              ?.any((Reservation r) => r.dateTime == dt) ==
          false) {
        _tables[index].reservations?.add(Reservation(dateTime: dt, name: name));
      }
    }

    await _repo.updateTable(_tables[index]);
    await updateTable(_tables[index].id);
  }

  Future<void> cancelTable(int? id, String dt) async {
    logger.i('TableCubit - cancelTable: $id - $dt');
    int index = _tables.indexWhere((TableModel table) => table.id == id);
    if (index != -1) {
      _tables[index]
          .reservations
          ?.removeWhere((Reservation r) => r.dateTime == dt);
    }

    await _repo.updateTable(_tables[index]);
    await updateTable(_tables[index].id);
  }

  TableStatus tableStatus(TableModel table, String dt) {
    if (table.reservations?.any((Reservation r) =>
            r.dateTime == dt && r.name == kCurrentUsername) ==
        true) {
      return TableStatus.reservedByMe;
    }

    if (table.reservations?.any((Reservation r) =>
            r.dateTime == dt && r.name != kCurrentUsername) ==
        true) {
      return TableStatus.reservedByOther;
    }

    return TableStatus.available;
  }
}
