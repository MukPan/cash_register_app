
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../context/cash_register_context.dart';
import '../context/selected_no_context.dart';
import '../context/various_amounts_context.dart';

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
              //1:注文番号
              const SelectedNoContext(),
              //2:合計金額
              Container(
                //TODO:画面半分コンテナをコンポーネント化する
                width: MediaQuery.of(context).size.width/2.0 - 60.0,
                margin: const EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1)
                ),
                child: const VariousAmountsContext()
              ),

              //3:次へ
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orange,
                ),
                onPressed: () => {}, //moveCashRegisterPage(context)
                child: const Text("次へ"),
              ),

            ],


          )
        ],
      )
    );
  }
}
