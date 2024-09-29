import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_booking_app/cubits/table_cubit/table_cubit.dart';
import 'package:restaurant_booking_app/models/table/table_model.dart';
import 'package:restaurant_booking_app/views/common/common_loading_state.dart';

class TableTileCta extends StatelessWidget {
  const TableTileCta({
    super.key,
    required this.table,
    required this.status,
    required this.reserveTable,
    required this.cancelTable,
  });

  final TableModel table;
  final TableStatus status;
  final VoidCallback reserveTable;
  final VoidCallback cancelTable;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: BlocBuilder<TableCubit, TableState>(
        builder: (context, state) {
          if (state is TableUpdating) {
            if (state.id == table.id) {
              return const CommonLoadingState();
            }
          }

          /// If table has been reserved by another user, disable CTA
          return CupertinoButton(
            onPressed: status == TableStatus.reservedByOther
                ? null
                : () {
                    if (status == TableStatus.reservedByMe) {
                      cancelTable();
                    } else if (status == TableStatus.available) {
                      reserveTable();
                      return;
                    }
                  },
            child:
                Text(status == TableStatus.reservedByMe ? 'Cancel' : 'Reserve'),
          );
        },
      ),
    );
  }
}
