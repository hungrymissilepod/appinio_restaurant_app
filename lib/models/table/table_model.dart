import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_booking_app/models/reservation/reservation.dart';

part 'table_model.g.dart';

/// Had to name this [TableModel] because of a conflict with [Table] class in Flutter SDK

@JsonSerializable(explicitToJson: true)
class TableModel extends Equatable {
  TableModel({
    required this.id,
    this.chairs,
    List<Reservation>? reservations,
  }) : reservations = reservations ?? <Reservation>[];

  final int id;
  final int? chairs;
  final List<Reservation>? reservations;

  factory TableModel.fromJson(Map<String, dynamic> json) =>
      _$TableModelFromJson(json);

  Map<String, dynamic> toJson() => _$TableModelToJson(this);

  @override
  List<Object?> get props => [id, chairs, reservations];
}
