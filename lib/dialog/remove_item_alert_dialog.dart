import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/item_count_family.dart';

class RemoveItemAlertDialog extends StatelessWidget {
  const RemoveItemAlertDialog({Key? key, required this.index}) : super(key: key);

  ///行番号
  final int index;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("商品の削除"),
      content: const Text("注文リストに登録した商品を削除しますか。"),
      actions: <Widget>[
        TextButton(
          child: const Text("いいえ"),
          onPressed: () => Navigator.pop(context, false),
        ),
        TextButton(
          child: const Text("はい"),
          onPressed: () => Navigator.pop(context, true),
        )
      ],
    );
  }
}
