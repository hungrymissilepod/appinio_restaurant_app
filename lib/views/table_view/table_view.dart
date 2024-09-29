import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_booking_app/cubits/table_cubit/table_cubit.dart';
import 'package:restaurant_booking_app/models/table/table_model.dart';
import 'package:restaurant_booking_app/views/common/common_error_state.dart';
import 'package:restaurant_booking_app/views/common/common_loading_state.dart';
import 'package:restaurant_booking_app/views/table_view/ui/table_tile.dart';

class TableView extends StatefulWidget {
  const TableView({
    super.key,
    required this.cubit,
    required this.dateTime,
  });

  final TableCubit cubit;
  final String dateTime;

  @override
  State<TableView> createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    widget.cubit.fetch();
  }

  void _showBookingDialog(
      {required BuildContext context, required TableModel table}) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Enter name for booking'),
          content: CupertinoTextField(controller: controller),
          actions: [
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text('Book'),
              onPressed: () async {
                if (controller.text.isEmpty) {
                  return;
                }
                await widget.cubit
                    .bookTable(table.id, widget.dateTime, controller.text);
                controller.clear();
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Pick Table'),
      ),
      child: SafeArea(
        child: BlocBuilder<TableCubit, TableState>(builder: (context, state) {
          if (state is TableLoading) {
            return const CommonLoadingState(
              label: 'Loading tables...',
            );
          }
          if (state is TableError) {
            return CommonErrorState(
              label: 'Failed to load tables',
              onTap: widget.cubit.fetch,
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            itemCount: state.tables.length,
            itemBuilder: (context, index) {
              final TableModel table = state.tables[index];
              TableStatus status =
                  widget.cubit.tableStatus(table, widget.dateTime);
              return TableTile(
                table: table,
                status: status,
                cancelTable: () {
                  widget.cubit.cancelTable(table.id, widget.dateTime);
                },
                reserveTable: () {
                  _showBookingDialog(
                    context: context,
                    table: state.tables[index],
                  );
                },
              );
            },
          );
        }),
      ),
    );
  }
}
