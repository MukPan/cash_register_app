import 'package:cash_register_app/provider/item_count_provider.dart';
import 'package:cash_register_app/provider/opt_is_enabled_family.dart';
import 'package:cash_register_app/provider/selected_order_num_notifier.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../database/item_infos.dart';
import '../dialog/alert_dialog_texts.dart';
import '../dialog/default_alert_dialog.dart';

final db2 = FirebaseDatabase.instance;

class OrderUpdateBtn extends HookConsumerWidget {
  const OrderUpdateBtn({Key? key, required this.columnIndex, required this.targetOptInfoList, required this.orderUuid}) : super(key: key);

  ///列番号
  final int columnIndex;
  ///オプション候補
  final List<OptInfo> targetOptInfoList;
  ///注文uuid
  final String orderUuid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //注文番号
    final int orderNum = ref.read(selectedOrderNumProvider);
    //有効なオプション
    final options = targetOptInfoList.map((optInfo) => optInfo.optName)
        .where((optName) => ref.watch(optIsEnabledFamily(optName)) == true) //有効なオプションのみ
        .toList();
    //個数
    final qty = ref.watch(itemCountProvider);

    return TextButton(
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, //押したときの波動色
          backgroundColor: Colors.orange,
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20)
      ),
      onPressed: () async {
        //確認ダイアログを表示
        final isAllReady = await showDialog(
            context: context,
            builder: (content) => DefaultAlertDialog(
              alertDialogTexts: AlertDialogTexts(
                  title: const Text("注文の更新"),
                  content: const Text("注文を更新しますか。\n更新前の注文情報は上書きされます。\n"
                      "また、個数が0に設定されている場合、この注文は削除されます。")),
            )
        ) ?? false;

        //いいえなら編集画面に戻るだけ
        if (!isAllReady) return;

        //ダイアログを閉じる
        if (context.mounted) {
          Navigator.of(context).pop();
        }

        ///uuidを取得する///////////////////////
        //0個のときDBから削除
        if (qty == 0) {
          db2.ref("orderNums/$orderNum/orderList/$orderUuid")
              .remove();
          return;
        }

        //DBを更新
        db2.ref("orderNums/$orderNum/orderList/$orderUuid")
          .update({
            "options": options,
            "qty": qty,
          });

      },
      child: const Text(
        '注文を更新',
        style: TextStyle(
            fontSize: 20
        ),
      ),
    );
  }
}
