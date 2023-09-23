import 'package:flutter/material.dart';

import '../component/default_app_bar.dart';
import '../component/realtime_order_list.dart';
import '../context/call_btn.dart';
import '../context/gave_btn.dart';
import '../context/menu_drawer.dart';
import '../database/made_num_list_provider.dart';
import '../database/paid_num_list_provider.dart';

class OrderProgressPage extends StatelessWidget {
  const OrderProgressPage({Key? key}) : super(key: key);

  ///コールボタン
  Widget _getCallBtn(int orderNum) => CallBtn(orderNum: orderNum);
  ///お渡しボタン
  Widget _getGaveBtn(int orderNum) => GaveBtn(orderNum: orderNum);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: "調理内容管理"),
      drawer: const MenuDrawer(),
      body: Row(
        children: [
          Expanded(
            child: RealtimeOrderList(
                orderNumListProvider: paidNumListProvider,
                subStateWidgetFunc: _getCallBtn,
                emptyText: "新しい注文はありません。",
                stackImage: true,
            ),
          ),
          const VerticalDivider(width: 0, color: Colors.black),
          Expanded(
            child: RealtimeOrderList(
                orderNumListProvider: madeNumListProvider,
                subStateWidgetFunc: _getGaveBtn,
                emptyText: "お渡し待ちの商品はありません。",
                stackImage: true,
            ),
          )
        ],
      )
    );
  }
}
