import 'package:cash_register_app/main.dart';
import 'package:cash_register_app/page/cash_count_manager_page.dart';
import 'package:cash_register_app/page/cooking_details_page.dart';
import 'package:cash_register_app/page/gave_log_page.dart';
import 'package:flutter/material.dart';

import '../page/call_num_display_page.dart';
import '../page/calling_details_page.dart';
import '../page/order_progress_page.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  static const _titles = [
    Text("会計管理"),
    Text("キャッシュカウント"),
    Text("呼出番号一覧"),
    Text("注文進行状況"),
    Text("お渡し履歴"),
  ];

  static const _nextPages = [
    MyHomePage(),
    CashCountManagerPage(),
    CallNumDisplayPage(),
    OrderProgressPage(),
    GaveLogPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      child: ListView.builder(
        itemCount: _titles.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) return const DrawerHeader(child: Text("簡易会計システム"));

          return ListTile(
            title: _titles[index-1],
            selectedColor: Colors.indigo,
            onTap: () { //次ページへ移動
              //Drawerを閉じてから
              Navigator.of(context).pop();
              //次ページへ遷移
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => _nextPages[index-1]
              ));
            },
          );
        },
      ),

    );
  }
}


// ListTile(
// title: const Text("会計管理"),
// selected: true,
// selectedColor: Colors.indigo,
// onTap: () {
// //次ページの移動
// Navigator.of(context).push(MaterialPageRoute(
// builder: (context) => const ConfirmOrderPage()
// ));
// },
// ),

// (
// children: [
// const DrawerHeader(child: Text("簡易会計システム")),
// ListTile(
// title: const Text("会計管理"),
// selected: true,
// selectedColor: Colors.indigo,
// onTap: () {
// //次ページの移動
// Navigator.of(context).push(MaterialPageRoute(
// builder: (context) => const ConfirmOrderPage()
// ));
// },
// ),
// ListTile(title: Text("貨幣枚数管理"),),
// ListTile(title: Text("注文番号管理"),),
// ],
// )