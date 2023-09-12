import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../object/denominations.dart';

final salesCountFamily = StateProvider.family<int, Denominations>((ref, id) {
  return 0;
});
