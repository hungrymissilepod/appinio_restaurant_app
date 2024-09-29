part of 'table_cubit.dart';

abstract class TableState extends Equatable {
  const TableState();
}

class TableInitial extends TableState {
  const TableInitial();

  @override
  List<Object?> get props => [];
}

class TableLoading extends TableState {
  const TableLoading();

  @override
  List<Object?> get props => [];
}

class TableLoaded extends TableState {
  const TableLoaded(this.tables);

  final List<TableModel> tables;

  @override
  List<Object?> get props => [tables];
}

class TableError extends TableState {
  const TableError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
