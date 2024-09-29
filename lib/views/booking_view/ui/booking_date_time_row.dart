import 'package:flutter/cupertino.dart';

class BookingDateTimeRow extends StatelessWidget {
  const BookingDateTimeRow({
    super.key,
    required this.title,
    required this.body,
    required this.onTap,
    required this.icon,
  });

  final String? title;
  final String? body;
  final VoidCallback? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: CupertinoColors.black,
        ),
        const SizedBox(width: 8),
        Text(title ?? ''),
        CupertinoButton(
          onPressed: onTap,
          child: Text(body ?? ''),
        ),
      ],
    );
  }
}
