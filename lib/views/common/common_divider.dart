import 'package:flutter/cupertino.dart';

class CupertinoDivider extends StatelessWidget {
  const CupertinoDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      height: 1,
      color: CupertinoColors.separator,
    );
  }
}
