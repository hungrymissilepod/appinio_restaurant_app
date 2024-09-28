import 'package:flutter/cupertino.dart';

class BookingView extends StatelessWidget {
  const BookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.white,
        navigationBar: CupertinoNavigationBar(
          middle: Text('Reservations'),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Text('Reservations'),
              Text('tables here'),
            ],
          ),
        ));
  }
}
