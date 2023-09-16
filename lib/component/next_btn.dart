import 'package:cash_register_app/dialog/alert_dialog_texts.dart';
import 'package:cash_register_app/dialog/default_alert_dialog.dart';
import 'package:flutter/material.dart';

class NextBtn extends StatelessWidget {
  const NextBtn({
    Key? key,
    required this.moveNextPageFunc,
    this.isValid = true,
    this.btnText = "次へ",
    this.alertDialogTexts
  }) : super(key: key);

  ///次のページに遷移するための関数
  final void Function() moveNextPageFunc;

  ///ボタンが有効であるか
  final bool isValid;

  ///ボタン内のテキスト
  final String btnText;

  ///確認ダイアログの内容
  final AlertDialogTexts? alertDialogTexts;


  ///次ページへ遷移
  void _moveNextPage(context) async {
    //確認ダイアログ非表示
    if (alertDialogTexts == null) {
    moveNextPageFunc();
    return;
    }
    //確認ダイアログ表示
    final isMoveNextPage = await showDialog(
      context: context,
      builder: (content) => DefaultAlertDialog(
        alertDialogTexts: alertDialogTexts ?? AlertDialogTexts(title: const Text(""), content: const Text("")),
      )
    ) ?? false;

    if (!context.mounted) return;
    if (isMoveNextPage) moveNextPageFunc();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange,
        ),
        onPressed: isValid ? () {_moveNextPage(context);} : null,
        child: Text(
          btnText,
          style: const TextStyle(
            fontSize: 20
          ),
        ),
      ),
    );
  }
}


// AlertDialog(
// title: const Text("確認"),
// content: const Text("決済を完了しますか。\nこの操作は取り消すことができません。"),
// actions: [
// TextButton(
// child: const Text("いいえ"),
// onPressed: () => Navigator.pop(context, false),
// ),
// TextButton(
// child: const Text("はい"),
// onPressed: () => Navigator.pop(context, true),
// )
// ],
// )