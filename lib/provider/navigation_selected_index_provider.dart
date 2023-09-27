import 'package:hooks_riverpod/hooks_riverpod.dart';

///選択中のナビゲーションindex
final navigationSelectedIndexProvider = StateProvider<int>((ref) {
  return 0;
});