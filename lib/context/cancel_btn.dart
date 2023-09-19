import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../dialog/alert_dialog_texts.dart';
import '../dialog/default_alert_dialog.dart';

final db2 = FirebaseDatabase.instance;

class CancelBtn extends StatelessWidget {
  const CancelBtn({Key? key, required this.orderNum}) : super(key: key);

  ///注文番号
  final int orderNum;

  ///この注文番号をコール中の注文番号リストから削除する
  void _delFromCallingList(context) async {
    //商品を渡したか確認
    final bool isAllReady = await showDialog(
        context: context,
        builder: (content) => DefaultAlertDialog(
          alertDialogTexts: AlertDialogTexts(
              title: const Text("取消確認"),
              content: const Text("この注文を取り消しますか。\nこの操作を行った後に払い戻しを行ってください。\nこの操作は取り消すことができません。\n(キャッシュカウントの更新とデータベース上から注文番号が削除されるのは未実装)")),
        )
    ) ?? false;

    //拒否された場合実行しない
    if (!isAllReady) return;

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
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () { _delFromCallingList(context); },
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.grey
      ),
      child: const Text("取消"),
    );
  }
}
