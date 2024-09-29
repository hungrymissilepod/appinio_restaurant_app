import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurant_booking_app/views/booking_view/booking_view.dart';
import 'package:restaurant_booking_app/cubits/booking_cubit/booking_cubit.dart';
import 'package:restaurant_booking_app/cubits/food_cubit/food_cubit.dart';
import 'package:restaurant_booking_app/cubits/table_cubit/table_cubit.dart';
import 'package:restaurant_booking_app/firebase_options.dart';
import 'package:restaurant_booking_app/views/menu_view/menu_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_booking_app/repositories/food_repository.dart';
import 'package:restaurant_booking_app/repositories/table_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  /// Current time
  final DateTime date = DateTime.now()
      .copyWith(minute: 0, second: 0, microsecond: 0, millisecond: 0);

  /// Minimum booking time (cannot book in the past)
  final DateTime minDate = DateTime.now()
      .copyWith(minute: 0, second: 0, microsecond: 0, millisecond: 0)
      .add(Duration(hours: -1));

  /// Maximum booking time (one week in future)
  final DateTime maxDate = DateTime.now()
      .copyWith(minute: 0, second: 0, microsecond: 0, millisecond: 0)
      .add(Duration(days: 7));

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FoodCubit>(
            create: (BuildContext context) => FoodCubit(FoodRepository())),
        BlocProvider<BookingCubit>(
          create: (BuildContext context) => BookingCubit(
            datetime: date,
            minDate: minDate,
            maxDate: maxDate,
          ),
        ),
        BlocProvider<TableCubit>(
            create: (BuildContext context) => TableCubit(TableRepository())),
      ],
      child: CupertinoApp(
        theme: CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            textStyle: TextStyle(
              fontSize: 16,
              color: CupertinoColors.black,
            ),
          ),
        ),
        title: 'Flutter Demo',
        home: const MyHomePage(),
      ),
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
        items: [
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
        return CupertinoTabView(
          builder: (BuildContext context) {
            switch (index) {
              case 0:
                return MenuView(
                  cubit: BlocProvider.of<FoodCubit>(context),
                );
              case 1:
                return BookingView(
                  cubit: BlocProvider.of<BookingCubit>(context),
                );
              default:
                return SizedBox();
            }
          },
        );
      },
    );
  }
}
