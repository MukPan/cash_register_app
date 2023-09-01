
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../context/cash_register_context.dart';

class CashRegisterPage extends StatefulWidget {
  const CashRegisterPage({Key? key}) : super(key: key);

  @override
  CashRegisterPageState createState() => CashRegisterPageState();
}

class CashRegisterPageState extends State<CashRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("お預かり額の入力"),
        ),
      body: Row(
        children: [
          //注文内容
          const CashRegisterContext(),

          Column(
            children: [
              Container()
              //1:注文番号 selected_no_context
              // const SelectedNoContext(),
              // //2:合計金額
              // const TotalAmountContext(),
              //
              // //3:次へ
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     foregroundColor: Colors.white,
              //     backgroundColor: Colors.orange,
              //   ),
              //   onPressed: () => {moveCashRegisterPage(context)},
              //   child: const Text("次へ"),
              // ),

            ],
          )
        ],
      )
    );
  }
}
