import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'money_count_provider_family.dart';

//"100円": 5(枚)
final variousAmountsProviderFamily = StateProvider.family<int, VariousAmounts>((ref, id) {
  return 0; // 初期値を設定
});

//familyのid
enum VariousAmounts {
  totalAmount,
  depositAmount,
  changeAmount,
}

///合計、お預り、お釣りの状態を更新する
void changeVariousAmounts(WidgetRef ref) {
  //合計 commaInsertFormat.format
  final int totalAmount = ref.read(variousAmountsProviderFamily(VariousAmounts.totalAmount));
  //お預り
  final int depositAmount = moneyIdList
      .map((moneyId) => moneyIdStrToInt[moneyId] !* ref.watch(moneyCountProviderFamily(moneyId)).toInt())
      .map((amountNum) => amountNum.toInt())
      .reduce((sum, amount) => sum + amount);
  //お釣り
  final int changeAmount = depositAmount - totalAmount;

  //staete更新
  ref.read(variousAmountsProviderFamily(VariousAmounts.totalAmount).notifier).state = totalAmount;
  ref.read(variousAmountsProviderFamily(VariousAmounts.depositAmount).notifier).state = depositAmount;
  ref.read(variousAmountsProviderFamily(VariousAmounts.changeAmount).notifier).state = changeAmount;
}

