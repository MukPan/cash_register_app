
import 'package:cash_register_app/component/next_btn.dart';
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

  ///会計画面への遷移メソッド
  void moveSettlementCompletePage(BuildContext context) => {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const SettlementCompletePage()
    ))
  };

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

                    //3:次へ
                    Consumer(
                      builder: (context, ref, child) {
                        //現在のお釣り
                        int changeAmount = ref.watch(variousAmountsProviderFamily(VariousAmounts.changeAmount));

                        return NextBtn(
                          moveNextPageFunc: moveSettlementCompletePage,
                          isValid: changeAmount >= 0, //お釣りが0円以上のとき有効
                          btnText: "決済",
                          alertDialogTexts: AlertDialogTexts(
                            title: const Text("決済確認"),
                            content: const Text("決済を完了しますか。\nこの操作は取り消すことができません。")
                          )
                        );
                      },
                    )
                  ],
                ),
              )
            )
          ],
        )
    );
  }
}
