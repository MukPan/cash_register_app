import 'package:flutter/material.dart';

import '../component/default_app_bar.dart';
import '../context/category_grid.dart';
import '../context/category_navigation_rail.dart';
import '../context/menu_drawer.dart';

class CustomMenuPage extends StatelessWidget {
  const CustomMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: "メニュー編集"),
      drawer: const MenuDrawer(),
      body: Row(
        children: [
          //商品カテゴリ選択ナビゲーション
          const CategoryNavigationRail(),
          //メニューリスト
          Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: CategoryGrid(),
              )
          )
        ],
      ),
    );
  }
}
