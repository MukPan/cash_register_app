
import 'denominations.dart';

///金種のデータ参照用のオブジェクト
class DenominationInfo {
  DenominationInfo({required this.name, required this.amount, required this.denominationType});
  ///金種文字例
  final String name;
  ///金額
  final int amount;
  ///割り当てるenum
  final Denominations denominationType;
}