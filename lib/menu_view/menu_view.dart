import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_booking_app/cubits/food_cubit/food_cubit.dart';
import 'package:restaurant_booking_app/menu_view/ui/food_item_tile.dart';
import 'package:restaurant_booking_app/models/food_item.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FoodCubit>(context, listen: false).fetch();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodCubit, FoodState>(builder: (context, state) {
      if (state is FoodInitial) {
        return Text('initial state');
      }
      if (state is FoodLoading) {
        return CircularProgressIndicator();
      }
      if (state is FoodLoaded) {
        return CupertinoPageScaffold(
            backgroundColor: CupertinoColors.white,
            navigationBar: CupertinoNavigationBar(
              middle: Text('Menu'),
            ),
            child: SafeArea(
              child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  return FoodItemTile(item: state.items[index]);
                },
              ),
            ));
      }
      return Text('${state.props}');
    });
  }
}
