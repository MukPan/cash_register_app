import 'package:cash_register_app/provider/sales_count_family.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../dialog/alert_dialog_texts.dart';
import '../dialog/default_alert_dialog.dart';
import '../object/denominations.dart';

final db2 = FirebaseDatabase.instance;

class ResetSalesAmountBtn extends HookConsumerWidget {
  const ResetSalesAmountBtn({Key? key}) : super(key: key);



  ///売上額をリセットする
  Future<void> _resetSalesAmount(context, WidgetRef ref) async {
    final bool isAllReady = await showDialog(
        context: context,
        builder: (content) => DefaultAlertDialog(
          alertDialogTexts: AlertDialogTexts(
              title: const Text("リセット確認"),
              content: const Text("売上額をリセットしますか。\n現在の売上データは全て削除されます。\nこの操作は取り消すことができません。")),
        )
    ) ?? false;

    //拒否された場合実行しない
    if (!isAllReady) return;

    //売上初期化用Map
    final Map<String, int> initTmpTotalCountMap = {};
    for(final info in denominationInfoList) {
      initTmpTotalCountMap.addAll({info.name: 0});
      //プロバイダーも初期化
      ref.read(salesCountFamily(info.denominationType).notifier)
          .state = 0;
    }

    //データベース更新
    db2.ref("moneyCount/tmpTotalCountMap/")
      .update(initTmpTotalCountMap);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 30, 20, 30),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red
        ),
        onPressed: () { _resetSalesAmount(context, ref); },
        child: const Text("売上額をリセット"),
      ),
    );
  }
}
