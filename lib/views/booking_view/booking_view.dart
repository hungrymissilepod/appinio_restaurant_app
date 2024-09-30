import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_booking_app/cubits/booking_cubit/booking_cubit.dart';
import 'package:restaurant_booking_app/cubits/table_cubit/table_cubit.dart';
import 'package:restaurant_booking_app/views/booking_view/ui/booking_date_time_row.dart';
import 'package:restaurant_booking_app/views/table_view/table_view.dart';

class BookingView extends StatefulWidget {
  const BookingView({super.key});

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  /// Current time
  final DateTime date = DateTime.now()
      .copyWith(minute: 0, second: 0, microsecond: 0, millisecond: 0);

  /// Minimum booking time (cannot book in the past)
  final DateTime minDate = DateTime.now()
      .copyWith(minute: 0, second: 0, microsecond: 0, millisecond: 0)
      .add(const Duration(hours: -1));

  /// Maximum booking time (one week in future)
  final DateTime maxDate = DateTime.now()
      .copyWith(minute: 0, second: 0, microsecond: 0, millisecond: 0)
      .add(const Duration(days: 7));

  String _formatDate(DateTime dt) {
    return DateFormat('E dd MMMM yyyy').format(dt);
  }

  String _formatTime(DateTime dt) {
    return DateFormat('HH:mm').format(dt);
  }

  void _navigateToTableView(BuildContext context, BookingState state) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) {
          return TableView(
            dateTime: state.dateTime.toIso8601String(),
          );
        },
      ),
    );
  }

  void _showDialog(
      {required BuildContext context,
      required BookingState state,
      required CupertinoDatePickerMode mode}) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) {
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
              minimumDate: state.minDate,
              maximumDate: state.maxDate,
              initialDateTime: state.dateTime,
              mode: mode,
              use24hFormat: true,
              showDayOfWeek: true,
              onDateTimeChanged: (DateTime value) {
                if (value.isAfter(state.minDate) &&
                    value.isBefore(state.maxDate)) {
                  context.read<BookingCubit>().setDateTime(value);
                }
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookingCubit>(
      create: (context) => BookingCubit(
        datetime: date,
        minDate: minDate,
        maxDate: maxDate,
      ),
      child: BlocBuilder<BookingCubit, BookingState>(
        builder: (context, state) {
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
                        style: CupertinoTheme.of(context)
                            .textTheme
                            .textStyle
                            .copyWith(
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
                            state: state,
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
                            state: state,
                            mode: CupertinoDatePickerMode.time,
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: CupertinoButton(
                          color: CupertinoColors.activeBlue,
                          onPressed: () {
                            _navigateToTableView(context, state);
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
        },
      ),
    );
  }
}
