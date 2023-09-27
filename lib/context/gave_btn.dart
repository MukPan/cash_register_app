import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../object/order_status.dart';
import '../dialog/alert_dialog_texts.dart';
import '../dialog/default_alert_dialog.dart';

//インスタンス初期化
final db2 = FirebaseDatabase.instance;

class GaveBtn extends StatelessWidget {
  const GaveBtn({Key? key, required this.orderNum}) : super(key: key);

  ///注文番号
  final int orderNum;

  ///この注文番号をコール中の注文番号リストから削除する
  void _delFromCallingList(context) async {
    //商品を渡したか確認
    final bool isAllReady = await showDialog(
        context: context,
        builder: (content) => DefaultAlertDialog(
          alertDialogTexts: AlertDialogTexts(
            title: const Text("お渡し確認"),
            content: const Text("この注文番号のお渡しは完了しましたか。\nこの操作は取り消すことができません。")),
        )
    ) ?? false;

    //拒否された場合実行しない
    if (!isAllReady) return;

    //データベース更新
    db2.ref("orderNums/${orderNum.toString()}/")
        .update({"orderStatus": OrderStatus.gave.name});
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () { _delFromCallingList(context); },
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.green
      ),
      child: const Text("お渡し"),
    );
  }
}
