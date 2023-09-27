import 'package:cash_register_app/provider/navigation_selected_index_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../database/item_infos.dart';
import 'menu_tile.dart';

class CategoryGrid extends HookConsumerWidget {
  CategoryGrid({Key? key}) : super(key: key);

  final List<String> _categoryStrArr = [
    "food",
    "drink",
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategoryIndex = ref.watch(navigationSelectedIndexProvider);
    //選択されているカテゴリのリスト
    final List<ItemInfo> selectedInfoList = itemInfos
        .getList()
        .where((itemInfo) => itemInfo.category == _categoryStrArr[selectedCategoryIndex])
        .toList();

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 30,     //ボックス左右間のスペース
          mainAxisSpacing: 30,      //ボックス上下間のスペース
          crossAxisCount: 3,        //ボックスを横に並べる数
          childAspectRatio: 4 / 5   //横幅:高さ
      ),
      itemCount: selectedInfoList.length, //要素数
      //指定した要素の数分を生成
      itemBuilder: (context, index) {
        return MenuTile(itemInfo: selectedInfoList[index]);
      },
    );
  }
}
