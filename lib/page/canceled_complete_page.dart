import 'package:flutter/material.dart';

import '../component/default_app_bar.dart';
import '../component/next_btn.dart';
import '../component/order_num.dart';
import '../context/change_display.dart';
import '../context/repay_amount_table.dart';
import '../context/repay_display.dart';
import '../context/selected_no_context.dart';

class CanceledCompletePage extends StatelessWidget {
  const CanceledCompletePage({Key? key, required this.orderNum, required this.repayAmount}) : super(key: key);

  ///注文番号
  final int orderNum;
  ///払い戻し金額
  final int repayAmount;

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
                        child: const RepayAmountTable(),
                      ),
                    ),
                    //右
                    Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("注文番号 : ", style: TextStyle(fontSize: 20)),
                                  OrderNum(orderNum: orderNum),
                                ],
                              ),
                              RepayDisplay(repayAmount: repayAmount),
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
