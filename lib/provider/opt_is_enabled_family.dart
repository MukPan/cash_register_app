

import 'package:hooks_riverpod/hooks_riverpod.dart';

///編集ダイアログのオプションが有効か無効か
final optIsEnabledFamily = StateProvider.family<bool, String>((ref, id) {
  return false;
});
