import 'package:cash_register_app/object/order_status.dart';
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
      appBar: const DefaultAppBar(title: "注文進行状況"),
      drawer: const MenuDrawer(),
      body: Row(
        children: [
          Expanded(
            child: RealtimeOrderList(
                orderNumListProvider: paidNumListProvider,
                subStateWidgetFunc: _getCallBtn,
                emptyText: "新しい注文はありません。",
                stackImage: true,
                titleWidget: Container(
                  width: double.infinity,
                  color: Colors.grey,
                  child: const Text(
                    "調理中",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
            ),
          ),
          const VerticalDivider(width: 0, color: Colors.black),
          Expanded(
            child: RealtimeOrderList(
                orderNumListProvider: madeNumListProvider,
                subStateWidgetFunc: _getGaveBtn,
                emptyText: "お渡し待ちの商品はありません。",
                stackImage: true,
                beforeStatus: OrderStatus.paid,
                titleWidget: Container(
                  width: double.infinity,
                  color: Colors.indigo,
                  child: const Text(
                    "受取待ち",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
            ),
          )
        ],
      )
    );
  }
}
