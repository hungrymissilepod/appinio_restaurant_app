import 'package:flutter/cupertino.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Menu'),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Text('Menu'),
              Text('items here'),
            ],
          ),
        ));
  }
}
