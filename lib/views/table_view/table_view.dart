import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_booking_app/cubits/table_cubit/table_cubit.dart';
import 'package:restaurant_booking_app/models/table/table_model.dart';
import 'package:restaurant_booking_app/repositories/table_repository.dart';
import 'package:restaurant_booking_app/views/common/common_error_state.dart';
import 'package:restaurant_booking_app/views/common/common_loading_state.dart';
import 'package:restaurant_booking_app/views/table_view/ui/table_tile.dart';

class TableView extends StatelessWidget {
  TableView({
    super.key,
    required this.dateTime,
  });

  final String dateTime;

  final TextEditingController controller = TextEditingController();

  void _showBookingDialog({
    required BuildContext context,
    required TableModel table,
  }) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) {
        return CupertinoAlertDialog(
          title: const Text('Enter name for booking'),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: CupertinoTextField(controller: controller),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text('Book'),
              onPressed: () async {
                if (controller.text.isEmpty) {
                  return;
                }
                await context
                    .read<TableCubit>()
                    .bookTable(table.id, dateTime, controller.text);
                controller.clear();
                if (ctx.mounted) {
                  Navigator.of(ctx).pop();
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
    return BlocProvider(
      create: (context) => TableCubit(TableRepository())..fetch(),
      child: BlocBuilder<TableCubit, TableState>(builder: (context, state) {
        return CupertinoPageScaffold(
          backgroundColor: CupertinoColors.white,
          navigationBar: const CupertinoNavigationBar(
            middle: Text('Pick Table'),
          ),
          child: SafeArea(
            child:
                BlocBuilder<TableCubit, TableState>(builder: (context, state) {
              if (state is TableLoading) {
                return const CommonLoadingState(
                  label: 'Loading tables...',
                );
              }
              if (state is TableError) {
                return CommonErrorState(
                  label: 'Failed to load tables',
                  onTap: () {
                    context.read<TableCubit>().fetch();
                  },
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
                      context.read<TableCubit>().tableStatus(table, dateTime);
                  return TableTile(
                    table: table,
                    status: status,
                    cancelTable: () {
                      context
                          .read<TableCubit>()
                          .cancelTable(table.id, dateTime);
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
      }),
    );
  }
}
