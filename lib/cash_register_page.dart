import 'package:flutter/material.dart';

class CashRegisterPage extends StatefulWidget {
  const CashRegisterPage({Key? key}) : super(key: key);

  @override
  State<CashRegisterPage> createState() => _CashRegisterPageState();
}

class _CashRegisterPageState extends State<CashRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("お会計"),
        ),
        body: Container()
    );
  }
}
