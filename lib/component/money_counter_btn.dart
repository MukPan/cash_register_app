import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../provider/money_count_provider_family.dart';

class MoneyCounterBtn extends HookConsumerWidget {
  const MoneyCounterBtn({Key? key, required this.moneyId }) : super(key: key);

  ///貨幣の名称(Familyのid)
  final String moneyId;



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int moenyCount = ref.watch(moneyCountProviderFamily(moneyId));

    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: Colors.blue.shade100,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(0) //角ばったボタン
              )
          )
      ),
      onPressed: () {
        ref.read(moneyCountProviderFamily(moneyId).notifier).state++;
        print("$moneyId: ${moenyCount+1}枚");

      },
      child: Column(
        children: [
          Text(moneyId),
          Text(moenyCount.toString())
        ],
      ),
    );
  }
}
