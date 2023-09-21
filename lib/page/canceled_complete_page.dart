import 'package:flutter/material.dart';

import '../component/default_app_bar.dart';
import '../component/next_btn.dart';
import '../context/repay_amount_table.dart';

class CanceledCompletePage extends StatelessWidget {
  const CanceledCompletePage({Key? key}) : super(key: key);

  ///お渡し履歴ページへ遷移
  void _moveGaveLogPage(context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const DefaultAppBar(title: "取消完了", showBackBtn: false),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: const Text(
                "注文を取り消しました。",
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
                        child: const RepayAmountTable(), //合計金額を渡したい
                      ),
                    ),
                    //右
                    Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              // const SelectedNoContext(),
                              // const ChangeDisplay(),
                              NextBtn(moveNextPageFunc: () {_moveGaveLogPage(context);}, btnText: "お渡し履歴へ"),                ],
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
