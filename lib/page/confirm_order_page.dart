import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../component/default_app_bar.dart';
import '../component/next_btn.dart';
import '../context/item_details_context.dart';
import '../context/selected_no_context.dart';
import '../context/total_amount_context.dart';
import 'cash_register_page.dart';

class ConfirmOrderPage extends StatelessWidget {
  const ConfirmOrderPage({Key? key}) : super(key: key);

  ///会計画面への遷移メソッド
  void moveCashRegisterPage(BuildContext context) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const CashRegisterPage()
        ));
      }


  //TODO: 注文番号とメニューをプロバイダーから受け取る
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: const DefaultAppBar(title: "注文内容の確認"),
        body: Row(
          children: [
            //注文内容
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                height: double.infinity,
                child: const ItemDetailsContext()
              )
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    //1:注文番号
                    const SelectedNoContext(),
                    //2:合計金額
                    const TotalAmountContext(),
                    //3:次へ
                    NextBtn(moveNextPageFunc: moveCashRegisterPage),

                  ],
                )
              )
            )
          ],
        )
    );
  }
}



