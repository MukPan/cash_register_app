import 'package:flutter/material.dart';

///ローディングを表示するメソッド
void showProgressDialog(context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    transitionDuration: const Duration(milliseconds: 500), // これを入れると遅延を入れなくて
    barrierColor: Colors.black.withOpacity(0.5),
    pageBuilder: (context, animation, secondaryAnimation) {
      return const Center(
          child: SizedBox(
            width: 180,
            height: 180,
            child: CircularProgressIndicator(
              strokeWidth: 10,
              color: Colors.indigo,
            ),
          )
      );
    },
  );
}

///ローディングを閉じるメソッド
void closeProgressDialog(context) {
  //ローディング終了
  if (context.mounted) {
    Navigator.of(context).pop();
  }
}