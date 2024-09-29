part of 'table_cubit.dart';

abstract class TableState extends Equatable {
  const TableState(this.tables);

  final List<TableModel> tables;
}

class TableInitial extends TableState {
  TableInitial() : super([]);

  @override
  List<Object?> get props => [];
}

class TableLoading extends TableState {
  TableLoading() : super([]);

  @override
  List<Object?> get props => [];
}

class TableUpdating extends TableState {
  const TableUpdating(this.id, {required List<TableModel> tables})
      : super(tables);

  final int? id;

  @override
  List<Object?> get props => [id, tables];
}

class TableLoaded extends TableState {
  const TableLoaded({required List<TableModel> tables}) : super(tables);

  @override
  List<Object?> get props => [tables];
}

class TableError extends TableState {
  TableError(this.message) : super([]);

  final String message;

  @override
  List<Object?> get props => [message];
}
