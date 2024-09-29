import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_booking_app/cubits/booking_cubit/booking_cubit.dart';
import 'package:restaurant_booking_app/cubits/table_cubit/table_cubit.dart';
import 'package:restaurant_booking_app/views/table_view/table_view.dart';

class BookingView extends StatefulWidget {
  const BookingView({
    super.key,
    required this.bookingCubit,
  });

  final BookingCubit bookingCubit;

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  DateTime date = DateTime.now()
      .copyWith(minute: 0, second: 0, microsecond: 0, millisecond: 0);
  DateTime minDate = DateTime.now()
      .copyWith(minute: 0, second: 0, microsecond: 0, millisecond: 0)
      .add(Duration(hours: -1));
  DateTime maxDate = DateTime.now()
      .copyWith(minute: 0, second: 0, microsecond: 0, millisecond: 0)
      .add(Duration(days: 7));

  void _showDialog() {
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
              minimumDate: minDate,
              maximumDate: maxDate,
              initialDateTime: date,
              mode: CupertinoDatePickerMode.dateAndTime,
              use24hFormat: true,
              showDayOfWeek: true,
              onDateTimeChanged: (DateTime value) {
                setState(() {
                  date = value;
                });
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      navigationBar: CupertinoNavigationBar(
        middle: Text('Reservations'),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Select date'),
              CupertinoButton(
                child: Text('Date: ${date.toString()}'),
                onPressed: () {
                  _showDialog();
                },
              ),
              CupertinoButton(
                child: Text('Reserve table'),
                color: CupertinoColors.activeBlue,
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) {
                        return TableView(
                            tableCubit: BlocProvider.of<TableCubit>(context),
                            dateTime: date.toUtc().toIso8601String());
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
