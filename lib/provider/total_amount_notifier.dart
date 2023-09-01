import 'package:hooks_riverpod/hooks_riverpod.dart';

///供給される処理中の合計金額
class TotalAmountNotifier extends StateNotifier<int> {
  TotalAmountNotifier() : super(defaultTotalAmount);

  ///空の注文番号リスト
  static const int defaultTotalAmount = 0;

  ///状態を初期化
  void initState() {
    state = defaultTotalAmount;
  }

  ///状態を明示的に更新するメソッド
  void changeState(state) => {this.state = state};
}

///処理中の合計金額
final totalAmountProvider
= StateNotifierProvider<TotalAmountNotifier, int>((ref) => TotalAmountNotifier());