
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../dialog/remove_item_alert_dialog.dart';
import '../provider/item_count_family.dart';

class ItemCounter extends HookConsumerWidget {
  const ItemCounter({Key? key, required this.qty}) : super(key: key); //required this.index

  ///行番号
  final int qty;

  ///個数増加
  // void _increaseCount(WidgetRef ref) {
  //   ref.read(itemCountFamily(index).notifier).state++; //書込
  // }

  ///個数減少
  // void _decreaseCount(WidgetRef ref) {
  //   ref.read(itemCountFamily(index).notifier).state--; //書込
  // }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
  // final int count = ref.watch(itemCountFamily(index)); //読取
  const bool countBtnIsEnabled = false;

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
            onPressed: (qty <= 0 || !countBtnIsEnabled) ? null : () async {
              //カウントが1のとき
              bool isRemove = false;
              if (qty == 1) {
                isRemove = await showDialog(
                    context: context,
                    builder: (content) => const RemoveItemAlertDialog()
                ) ?? false;
              }

              // if (qty > 1 || isRemove) _decreaseCount(ref);

            },
            icon: (qty <= 1) ? const Icon(Icons.delete) : const Icon(Icons.remove)
        ),
        Text(qty.toString()),
        IconButton(
            onPressed: (qty >= 5 || !countBtnIsEnabled) ? null : () { //上限を設ける
              // _increaseCount(ref);
            },
            icon: const Icon(Icons.add)
        ),
      ],
    ),
  );
  }
}