import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_booking_app/cubits/food_cubit/food_cubit.dart';
import 'package:restaurant_booking_app/repositories/food_repository.dart';
import 'package:restaurant_booking_app/views/common/common_error_state.dart';
import 'package:restaurant_booking_app/views/common/common_loading_state.dart';
import 'package:restaurant_booking_app/views/menu_view/ui/menu_view_loaded_state.dart';

class MenuView extends StatefulWidget {
  const MenuView({
    super.key,
    required this.repository,
  });

  final FoodRepository repository;

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FoodCubit>(
      create: (context) => FoodCubit(widget.repository)..fetch(),
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.white,
        navigationBar: const CupertinoNavigationBar(
          backgroundColor: CupertinoColors.white,
          middle: Text(
            'Menu',
            style: TextStyle(color: CupertinoColors.black),
          ),
        ),
        child: BlocBuilder<FoodCubit, FoodState>(builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: CupertinoSearchTextField(
                    controller: controller,
                    onChanged: (String? value) {
                      if (value != null) {
                        context.read<FoodCubit>().search(value);
                      }
                    },
                  ),
                ),
                Expanded(
                  child: Builder(builder: (context) {
                    if (state is FoodLoading) {
                      return const CommonLoadingState(
                        label: 'Loading menu...',
                      );
                    }
                    if (state is FoodError) {
                      return CommonErrorState(
                        label: 'Failed to load menu',
                        onTap: () {
                          context.read<FoodCubit>().fetch();
                        },
                      );
                    }
                    if (state is FoodLoaded) {
                      return MenuViewLoadedState(items: state.items);
                    }
                    return CommonErrorState(
                      label: 'Failed to load menu',
                      onTap: () {
                        context.read<FoodCubit>().fetch();
                      },
                    );
                  }),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
