import 'package:hooks_riverpod/hooks_riverpod.dart';

//"100円": 5(枚)
final variousAmountsProviderFamily = StateProviderFamily<int, VariousAmounts>((ref, id) {
  return 0; // 初期値を設定
});


//familyのid
enum VariousAmounts {
  totalAmount,
  depositAmount,
  changeAmount,
}

