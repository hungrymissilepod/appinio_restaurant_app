import 'package:flutter/cupertino.dart';
import 'package:restaurant_booking_app/cubits/table_cubit/table_cubit.dart';

class TableAvailabilityChip extends StatelessWidget {
  const TableAvailabilityChip({
    super.key,
    required this.status,
  });

  final TableStatus status;

  String _availablility(TableStatus status) {
    switch (status) {
      case TableStatus.available:
        return 'Available';
      default:
        return 'Reserved';
    }
  }

  Color _color(TableStatus status) {
    switch (status) {
      case TableStatus.available:
        return CupertinoColors.activeGreen.withOpacity(0.8);
      case TableStatus.reservedByMe:
        return CupertinoColors.inactiveGray.withOpacity(0.8);
      case TableStatus.reservedByOther:
        return CupertinoColors.inactiveGray.withOpacity(0.8);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: _color(status),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        child: Text(_availablility(status)),
      ),
    );
  }
}
