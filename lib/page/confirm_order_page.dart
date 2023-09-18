import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../component/default_app_bar.dart';
import '../component/next_btn.dart';
import '../context/item_details_context.dart';
import '../context/selected_no_context.dart';
import '../context/total_amount_context.dart';
import '../database/order_list_family.dart';
import '../provider/selected_order_num_notifier.dart';
import 'cash_register_page.dart';

class ConfirmOrderPage extends HookConsumerWidget {
  const ConfirmOrderPage({Key? key}) : super(key: key);

  ///会計画面への遷移メソッド
  void moveCashRegisterPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const CashRegisterPage()
    ));
  }

  //TODO: 注文番号とメニューをプロバイダーから受け取る
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //注文番号
    final int orderNum = ref.read(selectedOrderNumProvider);
    //注文リストAsyVal
    final orderListAsyVal = ref.watch(orderListFamily(orderNum));

    return Scaffold(
        appBar: const DefaultAppBar(title: "注文内容の確認"),
        body: Row(
          children: [
            //注文内容
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                height: double.infinity,
                child: ItemDetailsContext(orderListAsyVal: orderListAsyVal) //ItemDetailsContext()
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
                    TotalAmountContext(orderListAsyVal: orderListAsyVal),
                    //3:次へ
                    NextBtn(moveNextPageFunc: () {moveCashRegisterPage(context);}),
                  ],
                )
              )
            )
          ],
        )
    );
  }
}



