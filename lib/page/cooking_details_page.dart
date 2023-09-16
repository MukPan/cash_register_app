import 'package:cash_register_app/component/default_app_bar.dart';
import 'package:cash_register_app/context/menu_drawer.dart';
import 'package:flutter/material.dart';

import '../context/cooking_list.dart';

class CookingDetailsPage extends StatelessWidget {
  const CookingDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DefaultAppBar(title: "調理内容管理"),
      drawer: MenuDrawer(),
      body: CookingList(),
    );
  }
}
