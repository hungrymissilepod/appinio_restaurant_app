part of 'booking_cubit.dart';

abstract class BookingState extends Equatable {
  const BookingState(this.dateTime, this.minDate, this.maxDate);
  final DateTime dateTime;
  final DateTime minDate;
  final DateTime maxDate;
}

class BookingInitial extends BookingState {
  const BookingInitial({
    required DateTime dateTime,
    required DateTime minDate,
    required DateTime maxDate,
  }) : super(dateTime, minDate, maxDate);

  @override
  List<Object> get props => [dateTime, minDate, maxDate];
}
