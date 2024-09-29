import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  List<TableModel> _tables = [];

  Future<void> fetch() async {
    print('TableCubit - fetch');
    emit(TableLoading());
    try {
      _tables = await _repo.fetch();
      emit(TableLoaded(tables: _tables));
    } catch (e) {
      emit(TableError('Failed to fetch tables'));
    }
  }

  Future<void> updateTable(String id) async {
    emit(TableUpdating(id, tables: _tables));
    try {
      _tables = await _repo.fetch();
      emit(TableLoaded(tables: _tables));
    } catch (e) {
      emit(TableError('Failed to update table: ${id}'));
    }
  }

  Future<void> bookTable(String id, String dt, String user) async {
    int index = _tables.indexWhere((TableModel table) => table.id == id);
    if (index != -1) {
      if (_tables[index]
              .reservations
              ?.any((Reservation r) => r.dateTime == dt) ==
          false) {
        _tables[index].reservations?.add(Reservation(dateTime: dt, name: user));
      }
    }

    await _repo.updateTable(_tables[index]);
    await updateTable(_tables[index].id ?? '');
  }

  Future<void> cancelTable(String id, String dt) async {
    int index = _tables.indexWhere((TableModel table) => table.id == id);
    if (index != -1) {
      _tables[index]
          .reservations
          ?.removeWhere((Reservation r) => r.dateTime == dt);
    }

    await _repo.updateTable(_tables[index]);
    await updateTable(_tables[index].id ?? '');
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
