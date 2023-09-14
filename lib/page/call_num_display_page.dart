import 'package:cash_register_app/component/default_app_bar.dart';
import 'package:cash_register_app/context/completed_num_list.dart';
import 'package:flutter/material.dart';

import '../context/menu_drawer.dart';
import '../context/standby_num_list.dart';

class CallNumDisplayPage extends StatelessWidget {
  const CallNumDisplayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DefaultAppBar(title: "お呼び出し番号管理"),
      drawer: MenuDrawer(),
      body: Row(
        children: [
          //左
          Expanded(
            child: StandbyNumList(),
          ),
          VerticalDivider(width: 0, color: Colors.black),
          //右
          Expanded(
            child: CompletedNumList(),
          )
        ],
      ),
    );
  }
}
