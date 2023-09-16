import 'package:cash_register_app/component/default_app_bar.dart';
import 'package:cash_register_app/context/menu_drawer.dart';
import 'package:cash_register_app/provider/completed_num_list_provider.dart';
import 'package:cash_register_app/provider/paid_num_list_provider.dart';
import 'package:flutter/material.dart';

import '../component/realtime_order_list.dart';
import '../context/gave_btn.dart';

class CallingDetailsPage extends StatelessWidget {
  const CallingDetailsPage({Key? key}) : super(key: key);

  ///ボタンのWidgetを返すメソッド
  Widget _getGaveBtn(int orderNum) => GaveBtn(orderNum: orderNum);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const DefaultAppBar(title: "お渡し状況管理"),
      drawer: const MenuDrawer(),
      body: RealtimeOrderList(
        orderNumListProvider: completedNumListProvider,
        subStateWidgetFunc: _getGaveBtn,

      ),
    );
  }
}
