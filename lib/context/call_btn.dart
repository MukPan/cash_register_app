import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../dialog/alert_dialog_texts.dart';
import '../dialog/default_alert_dialog.dart';

//インスタンス初期化
final db = FirebaseFirestore.instance;

class CallBtn extends StatelessWidget {
  const CallBtn({Key? key, required this.orderNum}) : super(key: key);

  ///注文番号
  final int orderNum;


  ///この注文番号をコール中の注文番号リストへ移動する
  void _moveCallingList(context) async {
    //コールしてもよいか確認
    final bool isAllReady = await showDialog(
        context: context,
        builder: (content) => DefaultAlertDialog(
          alertDialogTexts: AlertDialogTexts(
            title: const Text("呼び出し確認"),
            content: const Text("この注文番号を呼び出しますか。\nこの操作は取り消すことができません。")),
        )
    ) ?? false;

    //拒否された場合実行しない
    if (!isAllReady) return;

    //データベース更新
    db.collection("orderNumCollection")
        .doc(orderNum.toString())
        .get()
        .then((docRef) {
          docRef.reference
            .update({"isCompleted": true,});
        });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () { _moveCallingList(context); },
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange
      ),
      child: const Text("コール"),
    );
  }
}
