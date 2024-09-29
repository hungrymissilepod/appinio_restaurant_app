import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommonErrorState extends StatelessWidget {
  const CommonErrorState({
    super.key,
    this.label,
    this.onTap,
    this.cta = 'Retry',
  });

  final String? label;
  final VoidCallback? onTap;
  final String cta;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: CupertinoColors.destructiveRed,
          ),
          const SizedBox(height: 8),
          Text(label ?? ''),
          const SizedBox(height: 24),
          CupertinoButton(
            color: CupertinoColors.activeBlue,
            child: Text(cta),
            onPressed: () {
              onTap?.call();
            },
          ),
        ],
      ),
    );
  }
}
