//"100円": 5(枚)
import 'package:hooks_riverpod/hooks_riverpod.dart';

final moneyCountProviderFamily = StateProviderFamily<int, String>((ref, id) {
  return 0; // 初期値を設定
});

//貨幣の名称群(familyのid)
const moneyIdList = [
  "1円",
  "5円",
  "10円",
  "50円",
  "100円",
  "500円",
  "1,000円",
  "5,000円",
  "10,000円",
];

//金額の文字例を数値に変換
const moneyIdStrToInt = <String, int>{
  "1円": 1,
  "5円": 5,
  "10円": 10,
  "50円": 50,
  "100円": 100,
  "500円": 500,
  "1,000円": 1000,
  "5,000円": 5000,
  "10,000円": 10000,
};