import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///タイトルと×ボタンをRowで並べたもの
///title: TitleAndCloseDialogBtn(title: title)と使う
class TitleAndCloseDialogBtn extends StatelessWidget {
  const TitleAndCloseDialogBtn({Key? key, required this.title}) : super(key: key);

  //タイトル文字例
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //商品名
        Text(title, style: const TextStyle(fontSize: 20),),
        //バツボタン
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(CupertinoIcons.xmark),
          ),
        )
      ],
    );
  }
}
