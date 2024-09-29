import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_booking_app/cubits/table_cubit/table_cubit.dart';
import 'package:restaurant_booking_app/models/table/table_model.dart';

class TableView extends StatefulWidget {
  const TableView({
    super.key,
    required this.tableCubit,
    required this.dateTime,
  });

  final TableCubit tableCubit;
  final String dateTime;

  @override
  State<TableView> createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    widget.tableCubit.fetch();
  }

  String availablility(TableStatus status) {
    switch (status) {
      case TableStatus.available:
        return 'Available';
      case TableStatus.reservedByMe:
        return 'Reserved by me';
      case TableStatus.reservedByOther:
        return 'Reserved';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      navigationBar: CupertinoNavigationBar(
        middle: Text('Pick Table'),
      ),
      child: SafeArea(
        child: BlocBuilder<TableCubit, TableState>(builder: (context, state) {
          print(state.toString());
          if (state is TableLoading) {
            // TODO: create common loading state
            return Center(child: CupertinoActivityIndicator());
          }
          // TODO: create common error state
          if (state is TableError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Failed to load tables'),
                  CupertinoButton(
                    color: CupertinoColors.activeBlue,
                    child: Text('Retry'),
                    onPressed: () {
                      widget.tableCubit.fetch();
                    },
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: state.tables.length,
              itemBuilder: (context, index) {
                final TableModel table = state.tables[index];
                TableStatus status =
                    widget.tableCubit.tableStatus(table, widget.dateTime);
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    color: CupertinoColors.white,
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Table: ${table.id}'),
                              Text('Chairs: ${table.chairs}'),
                              Text(availablility(status)),
                            ],
                          ),
                        ),
                        BlocBuilder<TableCubit, TableState>(
                          builder: (context, state) {
                            if (state is TableUpdating) {
                              if (state.id == table.id) {
                                return CupertinoActivityIndicator();
                              }
                            }
                            return CupertinoButton(
                              onPressed: status == TableStatus.reservedByOther
                                  ? null
                                  : () {
                                      if (status == TableStatus.reservedByMe) {
                                        widget.tableCubit.cancelTable(
                                            table.id ?? '', widget.dateTime);
                                      } else if (status ==
                                          TableStatus.available) {
                                        showCupertinoDialog(
                                          context: context,
                                          builder: (context) {
                                            return CupertinoAlertDialog(
                                              title: Text(
                                                  'Enter name for booking'),
                                              content: CupertinoTextField(
                                                  controller: controller),
                                              actions: [
                                                CupertinoDialogAction(
                                                  child: Text('Cancel'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                CupertinoDialogAction(
                                                  child: Text('Book'),
                                                  onPressed: () async {
                                                    if (controller
                                                        .text.isEmpty) {
                                                      return;
                                                    }
                                                    await widget.tableCubit
                                                        .bookTable(
                                                            state.tables[index]
                                                                    .id ??
                                                                '',
                                                            widget.dateTime,
                                                            controller.text);
                                                    controller.clear();
                                                    if (mounted) {
                                                      Navigator.of(context)
                                                          .pop();
                                                    }
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                        return;
                                      }
                                    },
                              child: Text(status == TableStatus.reservedByMe
                                  ? 'Cancel'
                                  : 'Reserve'),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
