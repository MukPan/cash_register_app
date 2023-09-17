import 'package:cash_register_app/component/default_app_bar.dart';
import 'package:cash_register_app/context/call_btn.dart';
import 'package:cash_register_app/context/menu_drawer.dart';
import 'package:cash_register_app/context/order_log_list.dart';
import 'package:cash_register_app/provider/paid_num_list_provider.dart';
import 'package:flutter/material.dart';

import '../component/realtime_order_list.dart';
import '../provider/all_order_num_docs_provider.dart';

class OrderLogPage extends StatelessWidget {
  const OrderLogPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: "注文履歴"),
      drawer: const MenuDrawer(),
      body: OrderLogList(
          orderNumDocsProvider: allOrderNumDocsProvider,
          emptyText: "注文履歴はありません。"
      ),
    );
  }
}
