import 'package:hooks_riverpod/hooks_riverpod.dart';

//autoDisposeを付けると設定後に初期値が上書きしてしまう
final itemCountFamily = StateProvider.family<int, int>((ref, id) {
  return 1; // 初期値を設定
});



