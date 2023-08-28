import 'package:flutter/material.dart';

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
      body: Container(),
    );
  }
}
