import 'package:cash_register_app/component/default_app_bar.dart';
import 'package:cash_register_app/context/menu_drawer.dart';
import 'package:flutter/material.dart';

import '../context/cash_count_table.dart';
import '../context/reset_sales_amount_btn.dart';

class CashCountManagerPage extends StatelessWidget {
  const CashCountManagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DefaultAppBar(title: "キャッシュカウント"),
      drawer: MenuDrawer(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: CashCountTable()),
          ResetSalesAmountBtn(),
        ],
      ),
    );
  }
}
