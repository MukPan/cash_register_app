
import 'package:cash_register_app/component/next_btn.dart';
import 'package:cash_register_app/context/move_settlement_complete_page_btn.dart';
import 'package:cash_register_app/dialog/alert_dialog_texts.dart';
import 'package:cash_register_app/page/settlement_complete_page.dart';
import 'package:cash_register_app/provider/various_amounts_provider_family.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../component/default_app_bar.dart';
import '../context/cash_register_context.dart';
import '../context/selected_no_context.dart';
import '../context/various_amounts_context.dart';

class CashRegisterPage extends StatelessWidget {
  const CashRegisterPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const DefaultAppBar(title: "お預かり額の入力"),
        body: Row(
          children: [
            //注文内容
            Expanded(
                child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                    child: const CashRegisterContext(),
                )
            ),

            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                height: double.infinity,
                child: Column(
                  children: [
                    //1:注文番号
                    const SelectedNoContext(),
                    //2:合計金額
                    Container(
                      //TODO:画面半分コンテナをコンポーネント化する
                        margin: const EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1)
                        ),
                        child: const VariousAmountsContext()
                    ),
                    //3:次ページボタン
                    const MoveSettlementCompletePageBtn()
                  ],
                ),
              )
            )
          ],
        )
    );
  }
}
