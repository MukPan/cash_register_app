import 'package:cash_register_app/provider/navigation_selected_index_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryNavigationRail extends HookConsumerWidget {
  const CategoryNavigationRail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    

    return NavigationRail(
      backgroundColor: Colors.black.withAlpha(200),
      indicatorColor: Colors.white,
      onDestinationSelected: (newIndex) {
        //indexプロバイダー更新
        ref.read(navigationSelectedIndexProvider.notifier)
            .state = newIndex;
      },
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.fastfood, color: Colors.white), //TODO: 変える
          selectedIcon: Icon(Icons.fastfood),
          label: Text("food"),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.emoji_food_beverage, color: Colors.white),
          selectedIcon: Icon(Icons.emoji_food_beverage),
          label: Text("drink"),
          padding: EdgeInsets.all(10),
        ),
      ],
      selectedIndex: ref.watch(navigationSelectedIndexProvider), //選択している番号
    );
  }
}
