import 'package:flutter/cupertino.dart';

class BookingDateTimeRow extends StatelessWidget {
  const BookingDateTimeRow({
    super.key,
    required this.title,
    required this.body,
    required this.onTap,
  });

  final String? title;
  final String? body;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title ?? ''),
        CupertinoButton(
          onPressed: onTap,
          child: Text(body ?? ''),
        ),
      ],
    );
  }
}
