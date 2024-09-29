import 'package:flutter/cupertino.dart';

class TableTileRow extends StatelessWidget {
  const TableTileRow({
    super.key,
    required this.label,
    required this.data,
  });

  final String? label;
  final String? data;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label ?? '',
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(width: 8),
        Text(data ?? ''),
      ],
    );
  }
}
