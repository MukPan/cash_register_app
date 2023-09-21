import 'package:cash_register_app/object/denomination_info.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../object/denominations.dart';

//払い戻し枚数
final repayMoneyCountFamily = StateProvider.family<int, Denominations>((ref, id) {
  return 0;
});

