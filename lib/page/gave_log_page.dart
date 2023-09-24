import 'package:cash_register_app/component/default_app_bar.dart';
import 'package:cash_register_app/context/call_btn.dart';
import 'package:cash_register_app/context/menu_drawer.dart';
import 'package:cash_register_app/context/gave_log_list.dart';
import 'package:cash_register_app/database/order_status.dart';
import 'package:flutter/material.dart';

import '../component/realtime_order_list.dart';
import '../context/cancel_btn.dart';
import '../database/gave_num_list_provider.dart';

class GaveLogPage extends StatelessWidget {
  const GaveLogPage({Key? key}) : super(key: key);

  ///ボタンのWidgetを返すメソッド
  Widget _getCancelBtn(int orderNum) => CancelBtn(orderNum: orderNum);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: "お渡し履歴"),
      drawer: const MenuDrawer(),
      body: RealtimeOrderList(
        orderNumListProvider: gaveNumListProvider,
        subStateWidgetFunc: _getCancelBtn,
        emptyText: "注文履歴はありません。",
        displayPrice: true,
        beforeStatus: OrderStatus.made,
      ),
    );
  }
}

// GaveLogList(
// gaveNumListProvider: gaveNumListProvider,
// emptyText: "注文履歴はありません。"
// )