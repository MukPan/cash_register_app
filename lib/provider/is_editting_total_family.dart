import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../object/denominations.dart';

final isEdittingTotalFamily = StateProvider.family<bool, Denominations>((ref, id) {
  return false;
});
