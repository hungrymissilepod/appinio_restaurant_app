import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_booking_app/cubits/food_cubit/food_cubit.dart';
import 'package:restaurant_booking_app/views/common/common_error_state.dart';
import 'package:restaurant_booking_app/views/common/common_loading_state.dart';
import 'package:restaurant_booking_app/views/menu_view/ui/menu_view_loaded_state.dart';

class MenuView extends StatefulWidget {
  const MenuView({
    super.key,
    required this.cubit,
  });

  final FoodCubit cubit;

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.cubit.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      navigationBar: const CupertinoNavigationBar(
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
                    widget.cubit.search(value);
                  }
                },
              ),
            ),
            Expanded(
              child:
                  BlocBuilder<FoodCubit, FoodState>(builder: (context, state) {
                if (state is FoodLoading) {
                  return const CommonLoadingState(label: 'Fetching menu...');
                }
                if (state is FoodError) {
                  return CommonErrorState(
                    label: 'Failed to load menu',
                    onTap: widget.cubit.fetch,
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
    );
  }
}
