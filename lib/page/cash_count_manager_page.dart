import 'package:cash_register_app/component/default_app_bar.dart';
import 'package:flutter/material.dart';

import '../context/cash_count_table.dart';

class CashCountManagerPage extends StatelessWidget {
  const CashCountManagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DefaultAppBar(title: "貨幣枚数管理"),
      body: CashCountTable(),
    );
  }
}
