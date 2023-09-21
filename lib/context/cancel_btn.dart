import 'package:cash_register_app/database/order_list_family.dart';
import 'package:cash_register_app/object/order_params.dart';
import 'package:cash_register_app/provider/cash_count_family.dart';
import 'package:cash_register_app/provider/sales_count_family.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../dialog/alert_dialog_texts.dart';
import '../dialog/default_alert_dialog.dart';
import '../object/denominations.dart';
import '../page/canceled_complete_page.dart';
import '../provider/repay_money_count_family.dart';

final db2 = FirebaseDatabase.instance;

class CancelBtn extends HookConsumerWidget {
  const CancelBtn({Key? key, required this.orderNum}) : super(key: key);

  ///注文番号
  final int orderNum;

  ///この注文番号をコール中の注文番号リストから削除する
  void _delFromCallingList(context, WidgetRef ref) async {
    //商品を渡したか確認
    final bool isAllReady = await showDialog(
        context: context,
        builder: (content) => DefaultAlertDialog(
          alertDialogTexts: AlertDialogTexts(
              title: const Text("取消確認"),
              content: const Text("この注文を取り消しますか。\nこの操作を行った後に払い戻しを行ってください。\nこの操作は取り消すことができません。\n(データベース上から注文番号が削除されるのは未実装)")),
        )
    ) ?? false;

    //拒否された場合実行しない
    if (!isAllReady) return;

    //取消実行//
    //注文番号からdbにアクセスして合計金額を算出
    final orderListEvent = await db2.ref("orderNums/$orderNum/orderList")
        .once();

    //合計金額
    int totalAmount = 0;
    for (final orderSnap in orderListEvent.snapshot.children) {
      final orderParams = OrderParams.getInstanceFromSnap(orderSnap);
      totalAmount += orderParams.subtotal;
    }

    //合計金額を分解して払い戻し枚数をプロバイダーに登録
    int remained = totalAmount; //あまり
    Map<String, int> resTotalCountMap = {};
    Map<String, int> resTmpTotalCountMap = {};
    for (final info in denominationInfoList.reversed) {
      int count = remained ~/ info.amount; //枚数
      remained %= info.amount; //あまり

      //前回の枚数を取得
      final beforeTotalCount = ref.read(cashCountFamily(info.denominationType));
      final beforeTmpTotalCount = ref.read(salesCountFamily(info.denominationType));

      resTotalCountMap.addAll({info.name: beforeTotalCount - count});
      resTmpTotalCountMap.addAll({info.name: beforeTmpTotalCount - count});
      print("${info.name}: $count");

      //プロバイダーに登録
      ref.read(repayMoneyCountFamily(info.denominationType).notifier)
          .state = count; //払い戻し枚数(初期化)
      ref.read(cashCountFamily(info.denominationType).notifier)
          .state -= count; //総量枚数(減)
      ref.read(salesCountFamily(info.denominationType).notifier)
          .state -= count; //総量枚数(減)
    }

    //dbに登録
    db2.ref("moneyCount/totalCountMap/")
      .update(resTotalCountMap);
    db2.ref("moneyCount/tmpTotalCountMap/")
      .update(resTmpTotalCountMap);

    //遷移
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CanceledCompletePage(
            orderNum: orderNum,
            repayAmount: totalAmount
        )
    ));

    //TODO: ここでデータベースから注文番号データを削除する
    //データベース更新
    // db2.ref("orderNums/${orderNum.toString()}/")
    //     .update({"orderStatus": OrderStatus.gave.name});

    // db.collection("orderNumCollection")
    //     .doc(orderNum.toString())
    //     .get()
    //     .then((docRef) {
    //   docRef.reference
    //       .update({"isGave": true});
    // });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () { _delFromCallingList(context, ref); },
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.grey
      ),
      child: const Text("取消"),
    );
  }
}
