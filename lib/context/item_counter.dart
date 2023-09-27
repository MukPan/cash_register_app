
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../dialog/alert_dialog_texts.dart';
import '../dialog/default_alert_dialog.dart';
import '../provider/item_count_provider.dart';

class ItemCounter extends HookConsumerWidget {
  const ItemCounter({Key? key, required this.amountPerItem, this.deleteItem = true}) : super(key: key); //required this.index

  ///一個あたりの値段
  final int amountPerItem;
  ///0個表示をするか
  final bool deleteItem;

  ///個数増加
  void _increaseCount(WidgetRef ref) {
    ref.read(itemCountProvider.notifier).state++; //書込
  }

  ///個数減少
  void _decreaseCount(WidgetRef ref) {
    ref.read(itemCountProvider.notifier).state--; //書込
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final int count = ref.watch(itemCountProvider); //読取

    return Container(
    width: 100,
    margin: const EdgeInsets.only(top: 10, bottom: 10),
    decoration: BoxDecoration(
      color: const Color(0x10000000),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: ((deleteItem && count > 0) || count > 1) ? () async { //qty <= 0 || !countBtnIsEnabled
            //カウントが1のとき
            bool isRemove = false;
            if (count == 1) {
              isRemove = await showDialog(
                context: context,
                builder: (content) => DefaultAlertDialog(
                  alertDialogTexts: AlertDialogTexts(
                    title: const Text("商品の削除"),
                    content: const Text("注文リストに登録した商品を削除しますか。\n注文の更新時にこの注文が削除されます。")),
                )
              ) ?? false;
            }
            //更新
            if (count > 1 || isRemove) {
              _decreaseCount(ref);
            }

          } : null,
          icon: (count <= 1) ? const Icon(Icons.delete) : const Icon(Icons.remove)
        ),
        Text(count.toString()),
        IconButton(
          onPressed: (count < 5) ? () { //上限を設ける
            //更新
            _increaseCount(ref);
          } : null,
          icon: const Icon(Icons.add)
        ),
      ],
    ),
  );
  }
}