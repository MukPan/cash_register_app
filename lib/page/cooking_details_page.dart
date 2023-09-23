import 'package:cash_register_app/component/default_app_bar.dart';
import 'package:cash_register_app/context/call_btn.dart';
import 'package:cash_register_app/context/menu_drawer.dart';
import 'package:flutter/material.dart';

import '../component/realtime_order_list.dart';
import '../database/paid_num_list_provider.dart';

class CookingDetailsPage extends StatelessWidget {
  const CookingDetailsPage({Key? key}) : super(key: key);

  ///ボタンのWidgetを返すメソッド
  Widget _getCallBtn(int orderNum) => CallBtn(orderNum: orderNum);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const DefaultAppBar(title: "調理内容管理"),
      drawer: const MenuDrawer(),
      body: RealtimeOrderList(
        orderNumListProvider: paidNumListProvider,
        subStateWidgetFunc: _getCallBtn,
        emptyText: "新しい注文はありません。"
      ),
    );
  }
}
