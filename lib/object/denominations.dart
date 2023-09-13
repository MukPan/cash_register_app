//金種
import 'denomination_info.dart';

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
  DenominationInfo(amount: 1, name: "1円", denominationType: Denominations.oneYen, imagePath: "images/money_1yen.png"),
  DenominationInfo(amount: 5, name: "5円", denominationType: Denominations.fiveYen, imagePath: "images/money_5yen.png"),
  DenominationInfo(amount: 10, name: "10円", denominationType: Denominations.tenYen, imagePath: "images/money_10yen.png"),
  DenominationInfo(amount: 50, name: "50円", denominationType: Denominations.fiftyYen, imagePath: "images/money_50yen.png"),
  DenominationInfo(amount: 100, name: "100円", denominationType: Denominations.hundredYen, imagePath: "images/money_100yen.png"),
  DenominationInfo(amount: 500, name: "500円", denominationType: Denominations.fiveHundredYen, imagePath: "images/money_500yen.png"),
  DenominationInfo(amount: 1000, name: "1,000円", denominationType: Denominations.oneThousandYen, imagePath: "images/money_1000yen.png"),
  DenominationInfo(amount: 5000, name: "5,000円", denominationType: Denominations.fiveThousandYen, imagePath: "images/money_5000yen.png"),
  DenominationInfo(amount: 10000, name: "10,000円", denominationType: Denominations.tenThousandYen, imagePath: "images/money_10000yen.png"),
];