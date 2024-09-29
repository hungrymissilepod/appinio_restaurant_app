import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit({
    required DateTime datetime,
    required DateTime minDate,
    required DateTime maxDate,
  }) : super(BookingInitial(
          dateTime: datetime,
          minDate: minDate,
          maxDate: maxDate,
        ));

  void setDateTime(DateTime dt) {
    emit(BookingInitial(
      dateTime: dt,
      minDate: state.minDate,
      maxDate: state.maxDate,
    ));
  }
}
