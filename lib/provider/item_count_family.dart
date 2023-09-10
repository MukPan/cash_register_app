import 'package:hooks_riverpod/hooks_riverpod.dart';

final itemCountFamily = StateProviderFamily<int, int>((ref, id) {
  return 1; // 初期値を設定
});

//TODO: トップページに戻った時プロバイダーを初期化