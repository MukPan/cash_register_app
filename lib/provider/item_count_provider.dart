import 'package:hooks_riverpod/hooks_riverpod.dart';

//autoDisposeを付けると設定後に初期値が上書きしてしまう
final itemCountProvider = StateProvider<int>((ref) {
  return 1; // 初期値を設定
});



