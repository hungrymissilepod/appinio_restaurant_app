import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reservation.g.dart';

@JsonSerializable()
class Reservation extends Equatable {
  const Reservation({this.dateTime, this.name});

  final String? dateTime;
  final String? name;

  factory Reservation.fromJson(Map<String, dynamic> json) =>
      _$ReservationFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationToJson(this);

  @override
  List<Object?> get props => [dateTime, name];
}
