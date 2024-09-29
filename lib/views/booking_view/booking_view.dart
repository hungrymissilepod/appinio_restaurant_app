import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_booking_app/cubits/booking_cubit/booking_cubit.dart';
import 'package:restaurant_booking_app/cubits/table_cubit/table_cubit.dart';
import 'package:restaurant_booking_app/views/booking_view/ui/booking_date_time_row.dart';
import 'package:restaurant_booking_app/views/table_view/table_view.dart';

class BookingView extends StatelessWidget {
  const BookingView({
    super.key,
    required this.cubit,
  });

  final BookingCubit cubit;

  void _showDialog(
      {required BuildContext context, required CupertinoDatePickerMode mode}) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: CupertinoDatePicker(
              minuteInterval: 60,
              minimumDate: cubit.state.minDate,
              maximumDate: cubit.state.maxDate,
              initialDateTime: cubit.state.dateTime,
              mode: mode,
              use24hFormat: true,
              showDayOfWeek: true,
              onDateTimeChanged: (DateTime value) {
                cubit.setDateTime(value);
              },
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime dt) {
    return DateFormat('E dd MMMM yyyy').format(dt);
  }

  String _formatTime(DateTime dt) {
    return DateFormat('HH:mm').format(dt);
  }

  void _navigateToTableView(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) {
          return TableView(
            cubit: BlocProvider.of<TableCubit>(context),
            dateTime: cubit.state.dateTime.toUtc().toIso8601String(),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(builder: (context, state) {
      return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.white,
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Reservations'),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select date and time',
                    style:
                        CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                  ),
                  const SizedBox(height: 12),
                  BookingDateTimeRow(
                    title: 'Date',
                    body: _formatDate(state.dateTime),
                    icon: FontAwesomeIcons.calendarDays,
                    onTap: () {
                      _showDialog(
                        context: context,
                        mode: CupertinoDatePickerMode.date,
                      );
                    },
                  ),
                  BookingDateTimeRow(
                    title: 'Time:',
                    body: _formatTime(state.dateTime),
                    icon: FontAwesomeIcons.solidClock,
                    onTap: () {
                      _showDialog(
                        context: context,
                        mode: CupertinoDatePickerMode.time,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: CupertinoButton(
                      color: CupertinoColors.activeBlue,
                      onPressed: () {
                        _navigateToTableView(context);
                      },
                      child: Text(
                        'Reserve table',
                        style: CupertinoTheme.of(context)
                            .textTheme
                            .textStyle
                            .copyWith(
                              fontSize: 18,
                              color: CupertinoColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
