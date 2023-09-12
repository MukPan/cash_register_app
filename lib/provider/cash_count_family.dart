import 'package:cash_register_app/object/denomination_info.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final cashCountFamily = StateProvider.family<int, Denominations>((ref, id) {
  return 0; //0枚
});

//金種
enum Denominations {
  oneYen, //1円
  fiveYen, //5円
  tenYen, //10円
  fiftyYen, //50円
  hundredYen, //100円
  fiveHundredYen, //500円
  oneThousandYen, //1000円
  fiveThousandYen, //5000円
  tenThousandYen  //10000円
}

//金種文字例
final List<DenominationInfo> denominationInfoList = [
  DenominationInfo(amount: 1, name: "1円", denominationType: Denominations.oneYen),
  DenominationInfo(amount: 5, name: "5円", denominationType: Denominations.fiveYen),
  DenominationInfo(amount: 10, name: "10円", denominationType: Denominations.tenYen),
  DenominationInfo(amount: 50, name: "50円", denominationType: Denominations.fiftyYen),
  DenominationInfo(amount: 100, name: "100円", denominationType: Denominations.hundredYen),
  DenominationInfo(amount: 500, name: "500円", denominationType: Denominations.fiveHundredYen),
  DenominationInfo(amount: 1000, name: "1,000円", denominationType: Denominations.oneThousandYen),
  DenominationInfo(amount: 5000, name: "5,000円", denominationType: Denominations.fiveThousandYen),
  DenominationInfo(amount: 10000, name: "10,000円", denominationType: Denominations.tenThousandYen),
];
