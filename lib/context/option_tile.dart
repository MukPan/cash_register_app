import 'package:cash_register_app/provider/opt_is_enabled_family.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../database/item_infos.dart';
import '../provider/amount_per_item_provider.dart';

class OptionTile extends HookConsumerWidget {
  const OptionTile({Key? key, required this.optInfo}) : super(key: key);

  ///オプション名
  final OptInfo optInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //オプション名
    final optName = optInfo.optName;
    //オプション価格
    final optPrice = optInfo.optPrice;
    //オプションは有効か
    final bool isEnabled = ref.watch(optIsEnabledFamily(optName));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // これで両端に寄せる
      children: [
        Text(optInfo.optName),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, //押したときの波動色
            backgroundColor: (isEnabled) ? Colors.orange : Colors.grey
          ),
          onPressed: () {
            //ありなし反転
            ref.read(optIsEnabledFamily(optName).notifier)
                .state = !ref.read(optIsEnabledFamily(optName));
            //現在のボタンの状態
            final bool isEnabledNow = ref.read(optIsEnabledFamily(optName));
            //一つ当たりの値段を更新
            ref.read(amountPerItemProvider.notifier)
                .state += (isEnabledNow) ? optPrice : -optPrice;
          },
          child: Text(
            (isEnabled) ? "あり" : "なし",
            style: const TextStyle(
              color: Colors.white
            ),
          )
        ),
      ],
    );
  }
}
