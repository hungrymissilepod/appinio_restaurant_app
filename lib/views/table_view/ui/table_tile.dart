import 'package:flutter/cupertino.dart';
import 'package:restaurant_booking_app/cubits/table_cubit/table_cubit.dart';
import 'package:restaurant_booking_app/models/table/table_model.dart';
import 'package:restaurant_booking_app/views/table_view/ui/table_availability_chip.dart';
import 'package:restaurant_booking_app/views/table_view/ui/table_tile_cta.dart';
import 'package:restaurant_booking_app/views/table_view/ui/table_tile_row.dart';

class TableTile extends StatelessWidget {
  const TableTile({
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
    return Container(
      color: CupertinoColors.white,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TableTileRow(
                  label: 'Table:',
                  data: table.id,
                ),
                const SizedBox(height: 4),
                TableTileRow(
                  label: 'Chairs',
                  data: table.chairs,
                ),
                const SizedBox(height: 4),
                TableAvailabilityChip(status: status),
              ],
            ),
          ),
          TableTileCta(
            table: table,
            status: status,
            reserveTable: reserveTable,
            cancelTable: cancelTable,
          ),
        ],
      ),
    );
  }
}
