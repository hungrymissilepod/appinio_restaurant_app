import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    BlocProvider.of<FoodCubit>(context).fetch();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.white,
        navigationBar: CupertinoNavigationBar(
          middle: Text('Menu'),
        ),
        child: SafeArea(
          child: BlocBuilder<FoodCubit, FoodState>(builder: (context, state) {
            if (state is FoodLoading) {
              return Center(child: CupertinoActivityIndicator());
            }
            if (state is FoodError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Failed to load items'),
                    CupertinoButton(
                      color: CupertinoColors.activeBlue,
                      child: Text('Retry'),
                      onPressed: () {
                        BlocProvider.of<FoodCubit>(context).fetch();
                      },
                    ),
                  ],
                ),
              );
            }
            if (state is FoodLoaded) {
              return ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  return FoodItemTile(item: state.items[index]);
                },
              );
            }
            return SizedBox();
          }),
        ));
  }
}
