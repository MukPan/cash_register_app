import 'package:cash_register_app/component/default_app_bar.dart';
import 'package:flutter/material.dart';

import '../context/menu_drawer.dart';
import '../context/standby_num_list.dart';

class CallNumDisplayPage extends StatelessWidget {
  const CallNumDisplayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: "お呼び出し番号管理"),
      drawer: const MenuDrawer(),
      body: Row(
        children: [
          //左
          const Expanded(
            child: StandbyNumList(),
          ),
          //右
          Expanded(
            child: Container(),
          )
        ],
      ),
    );
  }
}
