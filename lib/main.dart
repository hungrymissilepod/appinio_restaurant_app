import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurant_booking_app/repositories/food_repository.dart';
import 'package:restaurant_booking_app/views/booking_view/booking_view.dart';
import 'package:restaurant_booking_app/firebase_options.dart';
import 'package:restaurant_booking_app/views/common/common_error_state.dart';
import 'package:restaurant_booking_app/views/menu_view/menu_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontSize: 16,
            color: CupertinoColors.black,
          ),
        ),
      ),
      title: 'Ding!',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: CupertinoColors.white,
      tabBar: CupertinoTabBar(
        backgroundColor: CupertinoColors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.burger),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.utensils),
            label: 'Reservations',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) => MenuView(
                repository: FoodRepository(),
              ),
            );
          case 1:
            return CupertinoTabView(
              builder: (context) => const BookingView(),
            );
          default:
            return const CommonErrorState(
              label: 'You shouldn\'t be here!',
            );
        }
      },
    );
  }
}
