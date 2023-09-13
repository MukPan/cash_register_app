import 'package:cash_register_app/component/default_app_bar.dart';
import 'package:cash_register_app/component/next_btn.dart';
import 'package:cash_register_app/context/change_display.dart';
import 'package:flutter/material.dart';

import '../context/change_table.dart';
import '../context/selected_no_context.dart';

class SettlementCompletePage extends StatelessWidget {
  const SettlementCompletePage({Key? key}) : super(key: key);

  ///ホーム画面に戻るメソッド
  void _moveHomePage(context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: "決済完了", showBackBtn: false),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: const Text(
            "ご注文ありがとうございます。",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          Expanded(
              child: Row(
                children: [
                  //左
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: const ChangeTable(),
                    ),
                  ),
                  //右
                  Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            const SelectedNoContext(),
                            const ChangeDisplay(),
                            NextBtn(moveNextPageFunc: () {_moveHomePage(context);}, btnText: "ホームへ"),                ],
                        ),
                      )
                  )
                ],
              )
          ),
        ],
      )
    );
  }
}
// Column(
// children: [
// const Spacer(),
// const ChangeDisplay(),
// const Spacer(),
// const ChangeTable(),
// const Spacer(),
// NextBtn(moveNextPageFunc: () {_moveHomePage(context);}, btnText: "ホームへ"),
// const Spacer(),
// ],
// ),