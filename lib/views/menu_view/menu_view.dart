import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_booking_app/cubits/food_cubit/food_cubit.dart';
import 'package:restaurant_booking_app/repositories/food_repository.dart';
import 'package:restaurant_booking_app/views/common/common_error_state.dart';
import 'package:restaurant_booking_app/views/common/common_loading_state.dart';
import 'package:restaurant_booking_app/views/menu_view/ui/menu_view_loaded_state.dart';

class MenuView extends StatelessWidget {
  MenuView({
    super.key,
  });

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FoodCubit>(
      create: (context) => FoodCubit(FoodRepository())..fetch(),
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.white,
        navigationBar: const CupertinoNavigationBar(
          backgroundColor: CupertinoColors.white,
          middle: Text(
            'Menu',
            style: TextStyle(color: CupertinoColors.black),
          ),
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
                      context.read<FoodCubit>().search(value);
                    }
                  },
                ),
              ),
              Expanded(
                child: BlocBuilder<FoodCubit, FoodState>(
                    builder: (context, state) {
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
                  return const SizedBox();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
