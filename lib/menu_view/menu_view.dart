import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_booking_app/cubits/food_cubit/food_cubit.dart';
import 'package:restaurant_booking_app/food_item_detail_view/food_item_detail_view.dart';
import 'package:restaurant_booking_app/menu_view/ui/food_item_tile.dart';

class MenuView extends StatefulWidget {
  const MenuView({
    super.key,
    required this.foodCubit,
  });

  final FoodCubit foodCubit;

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.foodCubit.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      navigationBar: CupertinoNavigationBar(
        middle: Text('Menu'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: CupertinoSearchTextField(
                controller: controller,
                onChanged: (String? value) {
                  if (value != null) {
                    widget.foodCubit.search(value);
                  }
                },
              ),
            ),
            Expanded(
              child:
                  BlocBuilder<FoodCubit, FoodState>(builder: (context, state) {
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
                            widget.foodCubit.fetch();
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
                      return FoodItemTile(
                        item: state.items[index],
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) {
                                return FoodItemDetailView(
                                  item: state.items[index],
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  );
                }
                return SizedBox();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
