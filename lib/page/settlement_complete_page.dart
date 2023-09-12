import 'package:cash_register_app/component/default_app_bar.dart';
import 'package:cash_register_app/component/next_btn.dart';
import 'package:flutter/material.dart';

class SettlementCompletePage extends StatelessWidget {
  const SettlementCompletePage({Key? key}) : super(key: key);

  ///ホーム画面に戻るメソッド
  void _moveHomePage(context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: "決済完了", showBackBtn: false),
      body: Center(
        child: Column(
          children: [
            const Spacer(flex: 2),
            const Text(
              "ご注文ありがとうございます。",
              style: TextStyle(
                  fontSize: 40
              ),
            ),
            const Spacer(flex: 1),
            NextBtn(moveNextPageFunc: _moveHomePage, btnText: "ホームへ"),
            const Spacer(flex: 2),
          ],
        )
      ),
    );
  }
}
