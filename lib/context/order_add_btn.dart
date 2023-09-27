import 'package:cash_register_app/provider/item_count_provider.dart';
import 'package:cash_register_app/provider/opt_is_enabled_family.dart';
import 'package:cash_register_app/provider/selected_order_num_notifier.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../database/item_infos.dart';
import '../dialog/alert_dialog_texts.dart';
import '../dialog/default_alert_dialog.dart';
import '../provider/will_add_index_provider.dart';

final db2 = FirebaseDatabase.instance;

//注文の追加を確定させるボタン
class OrderAddBtn extends HookConsumerWidget {
  const OrderAddBtn({Key? key, required this.optInfoList, required this.itemName}) : super(key: key);

  ///オプション候補
  final List<OptInfo> optInfoList;
  ///商品名
  final String itemName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //注文番号
    final int orderNum = ref.read(selectedOrderNumProvider);
    //有効なオプション
    final options = optInfoList.map((optInfo) => optInfo.optName)
        .where((optName) => ref.watch(optIsEnabledFamily(optName)) == true) //有効なオプションのみ
        .toList();
    //個数
    final qty = ref.watch(itemCountProvider);
    //注文配列の最後尾のindexを取得
    final orderListEndIndex = ref.read(wiiAddIndexProvider);

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
                  title: const Text("注文の追加"),
                  content: const Text("この内容の注文を追加しますか。")),
            )
        ) ?? false;

        //いいえなら編集画面に戻るだけ
        if (!isAllReady) return;

        //DBに追加
        db2.ref("orderNums/$orderNum/orderList/") //db2.ref("orderNums/$orderNum/orderList/$columnIndex")
            .push().set({ //uuidを生成してそこに格納
          "item": itemName,
          "options": options,
          "qty": qty,
        });
        //ダイアログを閉じる
        if (context.mounted) {
          Navigator.of(context).pop();
          Navigator.of(context).pop(); //2回閉じる
        }
      },
      child: const Text(
        "注文を追加",
        style: TextStyle(
            fontSize: 20
        ),
      ),
    );
  }
}
