import 'package:hooks_riverpod/hooks_riverpod.dart';

///供給されるList
class OrderNumListNotifier extends StateNotifier<List<int>> {
  OrderNumListNotifier() : super([...emptyOrderNumList]);

  //TODO: ここをfirestoreによって獲得する
  ///空の注文番号リスト
  static const List<int> emptyOrderNumList = <int>[];

  ///状態を初期化
  void initState() {
    state = emptyOrderNumList;
  }

  ///状態を明示的に更新するメソッド
  void changeState(state) => {this.state = state};
}
