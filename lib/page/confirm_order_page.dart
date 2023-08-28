import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../component/order_num.dart';
import 'cash_register_page.dart';

class ConfirmOrderPage extends StatefulWidget {
  const ConfirmOrderPage({Key? key, required this.orderNum}) : super(key: key);

  ///注文番号
  final int orderNum;

  @override
  ConfirmOrderPageState createState() => ConfirmOrderPageState();
}

class ConfirmOrderPageState extends State<ConfirmOrderPage> {
  List<String> orderList = ["唐揚げ", "ポテト", "コーラ"];

  ///会計画面への遷移メソッド
  void moveCashRegisterPage(BuildContext context) => {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const CashRegisterPage()
    ))
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("お会計"),
        ),
        body: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width/2.0 - 60.0,
              color: CupertinoColors.systemGrey3,
              margin: const EdgeInsets.all(30.0), //できれば比率によって余白を変えたい
              child: Scrollbar(
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) => Text(orderList[index]),
                    separatorBuilder: (BuildContext context, int index) => Container(),
                    itemCount: orderList.length,
                  )
              ),
            ),
            Column(
              children: [
                //1:注文番号
                const Row(children: [
                  Text("注文番号 : ", style: TextStyle(fontSize: 20)),
                  OrderNum(orderNum: 150),
                ],),
                //2:合計金額
                Container(
                  width: MediaQuery.of(context).size.width/2.0 - 60.0,
                  margin: const EdgeInsets.all(30.0),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1)
                  ),
                  child: Center(
                      child: RichText(
                        text: const TextSpan(
                            children: [
                              TextSpan(text: "合計金額 : \n", style: TextStyle(fontSize: 20)),
                              TextSpan(text: "1,000", style: TextStyle(fontSize: 80)),
                              TextSpan(text: " 円", style: TextStyle(fontSize: 30))
                            ]
                        ),
                      )
                  ),
                ),
                //3:次へ
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () => {moveCashRegisterPage(context)},
                  child: const Text("次へ"),
                ),

              ],
            )
          ],
        )
    );
  }
}


