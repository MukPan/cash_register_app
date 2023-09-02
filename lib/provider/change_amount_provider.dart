import 'package:hooks_riverpod/hooks_riverpod.dart';

///供給される処理中のお釣り
class ChangeAmountProvider extends StateNotifier<int> {
  ChangeAmountProvider() : super(defaultChangeAmount);

  ///デフォルトのお釣り
  static const int defaultChangeAmount = 0;

  ///状態を初期化
  void initState() {
    state = defaultChangeAmount;
  }

  ///状態を明示的に更新するメソッド
  void changeState(state) => {this.state = state};
}

//処理中のお釣り
final changeAmountProvider
  = StateNotifierProvider<ChangeAmountProvider, int>((ref) => ChangeAmountProvider());

