import 'package:cash_register_app/common/show_progress_dialog.dart';
import 'package:cash_register_app/provider/change_money_count_family.dart';
import 'package:cash_register_app/provider/sales_count_family.dart';
import 'package:cash_register_app/provider/selected_order_num_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../component/next_btn.dart';
import '../dialog/alert_dialog_texts.dart';
import '../object/denomination_info.dart';
import '../object/denominations.dart';
import '../page/settlement_complete_page.dart';
import '../provider/money_count_provider_family.dart';
import '../provider/various_amounts_provider_family.dart';
import '../provider/cash_count_family.dart';

// final db = FirebaseFirestore.instance;
//インスタンス初期化
final db2 = FirebaseDatabase.instance;

class MoveSettlementCompletePageBtn extends HookConsumerWidget {
  const MoveSettlementCompletePageBtn({Key? key}) : super(key: key);


  ///決済完了画面への遷移メソッド
  void _moveSettlementCompletePage(BuildContext context) {
    //遷移
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const SettlementCompletePage()
    ));
  }

  ///キャッシュカウントの状態を更新するメソッド
  void _updateCashCountState(WidgetRef ref) {
    //お釣りをプロバイダーから取得
    final int changeAmount = ref.read(
        variousAmountsProviderFamily(VariousAmounts.changeAmount));
    int remainder = changeAmount; //残量初期化
    

    for (DenominationInfo info in denominationInfoList.reversed.toList()) {
      //お預り枚数
      final int receivedCount = ref.read(moneyCountProviderFamily(info.name));
      //お釣り枚数
      final int changeCount = remainder ~/ info.amount;
      //余り
      remainder %= info.amount;

      //お釣りの枚数をプロバイダーに登録
      ref.read(changeMoneyCountFamily(info.denominationType).notifier)
          .state = changeCount;
      //(お預り枚数-お釣り枚数)を累計プロバイダーに加算
      ref.read(cashCountFamily(info.denominationType).notifier) //累積
          .state += (receivedCount - changeCount);
      ref.read(salesCountFamily(info.denominationType).notifier) //キャッシュ累積
          .state += (receivedCount - changeCount);
    }

    //データベース用のMapを作成、1円から10000円までの枚数を記録
    final Map<String, int> totalCountMap = {};
    final Map<String, int> tmpTotalCountMap = {}; //一時的
    for (final info in denominationInfoList) {
      totalCountMap.addAll({"totalCountMap/${info.name}": ref.read(cashCountFamily(info.denominationType))});
      tmpTotalCountMap.addAll({"tmpTotalCountMap/${info.name}": ref.read(salesCountFamily(info.denominationType))});
    }

    // データベース更新
    db2.ref("moneyCount/")
        .update(totalCountMap..addAll(tmpTotalCountMap));
    // db.collection("moneyCountCollection")
    //   .doc("moneyCountDoc")
    //   .update(totalCountMap..addAll(tmpTotalCountMap));


  }

  ///firestoreに支払済みであることを伝えるメソッド
  void _updatePaidIsTrue(BuildContext context, WidgetRef ref) {

    //処理中の注文番号管理をプロバイダーから取得
    final orderNumStr = ref.read(selectedOrderNumProvider).toString();
    db2.ref("orderNums/$orderNumStr/")
        .update({"isPaid": true});
    //データベース更新
    // db.collection("orderNumCollection")
    //   .doc(orderNumStr)
    //   .update({"isPaid": true});
  }

  ///プロバイダーを初期化する
  void _initProviderState(WidgetRef ref) {
    //お預り金額
    ref.read(variousAmountsProviderFamily(VariousAmounts.depositAmount).notifier)
      .state = 0;
    //レジの貨幣枚数カウント
    for (final moneyId in moneyIdList) {
      ref.read(moneyCountProviderFamily(moneyId).notifier)
        .state = 0;
    }
  }

  ///Widget返却
    @override
    Widget build(BuildContext context, WidgetRef ref) {
      //現在のお釣り
      int changeAmount = ref.watch(
          variousAmountsProviderFamily(VariousAmounts.changeAmount));

      return NextBtn(
          moveNextPageFunc: () {
            //データベース更新
            _updatePaidIsTrue(context, ref);
            //キャッシュ状態更新
            _updateCashCountState(ref);
            //お預り金額と初期化
            _initProviderState(ref);
            //ページ遷移
            _moveSettlementCompletePage(context);
          },
          isValid: changeAmount >= 0, //お釣りが0円以上のとき有効
          btnText: "決済",
          alertDialogTexts: AlertDialogTexts(
              title: const Text("決済確認"),
              content: const Text(
                  "決済を完了しますか。\nこの操作は取り消すことができません。")
          )
      );
    }
  }
