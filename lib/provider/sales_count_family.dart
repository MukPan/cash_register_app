import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../object/denominations.dart';

///売り上げたお金の枚数
final salesCountFamily = StateProvider.family<int, Denominations>((ref, id) {
  return 0;
});
