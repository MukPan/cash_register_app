import 'package:hooks_riverpod/hooks_riverpod.dart';

///供給される選択された注文番号
class SelectedOrderNumNotifier extends StateNotifier<int> {
  SelectedOrderNumNotifier() : super(defaultOrderNum);

  ///空の注文番号リスト
  static const int defaultOrderNum = 0;

  ///状態を初期化
  void initState() {
    state = defaultOrderNum;
  }

  ///状態を明示的に更新するメソッド
  void changeState(state) => {this.state = state};
}

///処理中の注文番号
final selectedOrderNumProvider
= StateNotifierProvider<SelectedOrderNumNotifier, int>((ref) => SelectedOrderNumNotifier());