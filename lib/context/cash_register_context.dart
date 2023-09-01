import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///貨幣を入力するグリッド
class CashRegisterContext extends StatelessWidget {
  const CashRegisterContext({Key? key}) : super(key: key);

  static const moneyIdList = [
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/2.0 - 60.0, //TODO: paddingを試す
      color: CupertinoColors.systemGrey3,
      margin: const EdgeInsets.all(30.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10,     //ボックス左右間のスペース
          mainAxisSpacing: 10,      //ボックス上下間のスペース
          crossAxisCount: 3,        //ボックスを横に並べる数
        ),
        itemCount: moneyIdList.length,
        //指定した要素の数分を生成
        itemBuilder: (context, index) {
          return TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue.shade100,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(0) //角ばったボタン
                )
              )
            ),
            onPressed: () => {},
            child: Center(child: Text(moneyIdList[index],
              style: const TextStyle(fontSize: 24,),
            )),
          );
        },
      ),
    );
  }
}
