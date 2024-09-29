import 'package:flutter/cupertino.dart';

class CommonLoadingState extends StatelessWidget {
  const CommonLoadingState({
    super.key,
    this.label,
  });

  final String? label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CupertinoActivityIndicator(),
          if (label != null)
            Column(
              children: [
                const SizedBox(height: 8),
                Text(label ?? ''),
              ],
            ),
        ],
      ),
    );
  }
}
